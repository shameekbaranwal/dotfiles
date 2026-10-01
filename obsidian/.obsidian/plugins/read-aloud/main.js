"use strict";
// Read Aloud (Kokoro) — registers Obsidian commands that shell out to the local
// read-aloud pipeline. No-build plugin (plain CommonJS). Desktop only: uses Node
// child_process / fs.

const { Plugin, Notice, MarkdownView } = require("obsidian");
const { spawn } = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");

// Location of the tool scripts (this repo). install-plugin.sh replaces the
// placeholder with the absolute repo path when it copies the plugin into a vault.
const TOOL = "/Users/shameek/Desktop/code/repositories/obsidian-read-aloud";

module.exports = class ReadAloudPlugin extends Plugin {
  async onload() {
    // Fire a reading; stream its [stage] lines into one live-updating Notice.
    const fire = (script, args, msg) => {
      const notice = new Notice(msg, 0); // 0 = stay until we hide it
      const child = spawn(path.join(TOOL, script), args, {
        stdio: ["ignore", "ignore", "pipe"],
      });
      let buf = "";
      child.stderr.on("data", (d) => {
        buf += d.toString();
        const lines = buf.split("\n");
        buf = lines.pop();
        for (const line of lines) {
          const m = line.match(/^\[stage\]\s*(.*)$/);
          if (m) notice.setMessage("🔊 " + m[1]);
        }
      });
      child.on("close", () => notice.hide());
      child.on("error", (e) => {
        notice.setMessage("Read aloud failed: " + e.message);
        setTimeout(() => notice.hide(), 4000);
      });
    };

    // A quick, transient action (stop) — no streaming.
    const quick = (script, msg) => {
      spawn(path.join(TOOL, script), [], { detached: true, stdio: "ignore" }).unref();
      new Notice(msg);
    };

    // Read in `mode` (clean|narrate) starting from the cursor — or the current
    // selection if any text is highlighted. In preview mode (no editor) there's
    // no cursor, so fall back to reading the whole note.
    const read = (mode) => {
      const editor = this.app.workspace.getActiveViewOfType(MarkdownView)?.editor;
      if (editor) {
        const sel = editor.getSelection();
        let text, scope;
        if (sel && sel.trim()) {
          text = sel;
          scope = "selection";
        } else {
          const from = editor.getCursor();
          const lastLine = editor.lastLine();
          const to = { line: lastLine, ch: editor.getLine(lastLine).length };
          text = editor.getRange(from, to);
          scope = "from cursor";
        }
        if (!text.trim()) {
          new Notice("Read aloud: nothing to read from here.");
          return;
        }
        const tmp = path.join(os.tmpdir(), "read-aloud-input.md");
        fs.writeFileSync(tmp, text, "utf8");
        fire("read-aloud.sh", [tmp, mode], `🔊 ${mode} (${scope})…`);
      } else {
        const file = this.app.workspace.getActiveFile();
        if (!file) {
          new Notice("Read aloud: no active note.");
          return;
        }
        const abs = path.join(this.app.vault.adapter.basePath, file.path);
        fire("read-aloud.sh", [abs, mode], `🔊 ${mode} (whole note)…`);
      }
    };

    this.addCommand({
      id: "clean",
      name: "Read aloud from cursor/selection (clean)",
      callback: () => read("clean"),
    });
    this.addCommand({
      id: "narrate",
      name: "Read aloud from cursor/selection (narrated)",
      callback: () => read("narrate"),
    });
    this.addCommand({
      id: "pause",
      name: "Pause / resume",
      callback: () => quick("pause.sh", "⏯"),
    });
    this.addCommand({
      id: "next",
      name: "Skip forward one segment",
      callback: () => quick("next.sh", "⏭"),
    });
    this.addCommand({
      id: "prev",
      name: "Skip back one segment",
      callback: () => quick("prev.sh", "⏮"),
    });
    this.addCommand({
      id: "stop",
      name: "Stop reading",
      callback: () => quick("stop.sh", "⏹ Reading stopped."),
    });

    // Pre-warm the synthesis daemon in the background so the first read is
    // instant (it self-exits after being idle a while).
    spawn(path.join(TOOL, "daemon.sh"), ["start"], {
      detached: true,
      stdio: "ignore",
    }).unref();
  }
};
