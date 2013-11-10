From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3] l10n: de.po: translate 68 new messages
Date: Sun, 10 Nov 2013 18:55:07 +0100
Message-ID: <1384106107-3435-1-git-send-email-ralf.thielow@gmail.com>
References: <877gchu66x.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: tr@thomasrast.ch, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 18:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfZEZ-0006CC-T5
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 18:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab3KJRzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Nov 2013 12:55:16 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:60192 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3KJRzN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 12:55:13 -0500
Received: by mail-ee0-f47.google.com with SMTP id c13so1999535eek.34
        for <git@vger.kernel.org>; Sun, 10 Nov 2013 09:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VAweLUjTMTOOG83QaXHlWMP0z1P+K6HA2DbQ7Jx2brg=;
        b=KUSXfueeiKi8REPt4VFPZNQB8jbFM5PqYNScj2BFaBnIQ+M6Nih+vFkQ4ObmG4aP/t
         GbbtBLdzfR/crfAO9gvWdLv0SiDlnji0pnoUNCysdSRajAFVum529uHWmfdbJwKCRxfj
         aUy4a4TkjwFTvokWt4oN/oyAxJjKiTTnVEULOWMmHqAcpAIJUZ/9urnr92DcoAnsCJSH
         WBFGVlcyJGizgugUHHL1UrB3USfGO2mQoJ/f77gxHOWcEWS2RsGDObdeEVcy0EgGRsoS
         QNnaT/JFFtxngsSha1MR/2w4UtkCg5EM9YVsSPAOHzQErxQyub5SV9Dsg/8zAREjirD4
         FDQg==
X-Received: by 10.14.5.133 with SMTP id 5mr144602eel.84.1384106112124;
        Sun, 10 Nov 2013 09:55:12 -0800 (PST)
Received: from localhost (dslb-178-005-121-004.pools.arcor-ip.net. [178.5.121.4])
        by mx.google.com with ESMTPSA id 8sm51938253eem.15.2013.11.10.09.55.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Nov 2013 09:55:11 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc1.303.g27c0606
In-Reply-To: <877gchu66x.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237591>

Translate 68 new messages came from git.pot update in 727b957
(l10n: git.pot: v1.8.5 round 1 (68 new, 9 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 191 ++++++++++++++++++++++++++++---------------------------=
--------
 1 file changed, 86 insertions(+), 105 deletions(-)

diff --git a/po/de.po b/po/de.po
index 492390c..c5f9b61 100644
--- a/po/de.po
+++ b/po/de.po
@@ -902,51 +902,49 @@ msgid "-NUM"
 msgstr "-NUM"
=20
 #: pathspec.c:118
-#, fuzzy
 msgid "global 'glob' and 'noglob' pathspec settings are incompatible"
-msgstr "Die Optionen --bare und --origin %s sind inkompatibel."
+msgstr "Globale Einstellungen zur Pfadspezifikation 'glob' und 'noglob=
' sind inkompatibel."
=20
 #: pathspec.c:128
-#, fuzzy
 msgid ""
 "global 'literal' pathspec setting is incompatible with all other glob=
al "
 "pathspec settings"
-msgstr "--patch ist inkompatibel mit allen anderen Optionen"
+msgstr "Globale Einstellung zur Pfadspezifikation 'literal' ist inkomp=
atibel\n"
+"mit allen anderen Optionen."
=20
 #: pathspec.c:158
 msgid "invalid parameter for pathspec magic 'prefix'"
-msgstr ""
+msgstr "ung=C3=BCltiger Parameter f=C3=BCr Pfadspezifikationsangabe 'p=
refix'"
=20
 #: pathspec.c:164
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid pathspec magic '%.*s' in '%s'"
-msgstr "ung=C3=BCltige Pfadspezifikation"
+msgstr "ung=C3=BCltige Pfadspezifikationsangabe '%.*s' in '%s'"
=20
 #: pathspec.c:168
 #, c-format
 msgid "Missing ')' at the end of pathspec magic in '%s'"
-msgstr ""
+msgstr "Fehlendes ')' am Ende der Pfadspezifikationsangabe in '%s'"
=20
 #: pathspec.c:186
 #, c-format
 msgid "Unimplemented pathspec magic '%c' in '%s'"
-msgstr ""
+msgstr "nicht unterst=C3=BCtzte Pfadspezifikationsangabe '%c' in '%s'"
=20
 #: pathspec.c:211
-#, fuzzy, c-format
+#, c-format
 msgid "%s: 'literal' and 'glob' are incompatible"
-msgstr "Die Optionen --all und --tags sind inkompatibel."
+msgstr "%s: 'literal' und 'glob' sind inkompatibel"
=20
 #: pathspec.c:222
-#, fuzzy, c-format
+#, c-format
 msgid "%s: '%s' is outside repository"
-msgstr ""
-"Die Option --index kann nicht au=C3=9Ferhalb eines Repositories verwe=
ndet werden."
+msgstr "%s: '%s' liegt au=C3=9Ferhalb des Repositories"
=20
 #: pathspec.c:278
-#, fuzzy, c-format
+#, c-format
 msgid "Pathspec '%s' is in submodule '%.*s'"
-msgstr "Pfad '%s' befindet sich in Submodul '%.*s'"
+msgstr "Pfadspezifikation '%s' befindet sich in Submodul '%.*s'"
=20
 #.
 #. * We may want to substitute "this command" with a command
@@ -956,27 +954,26 @@ msgstr "Pfad '%s' befindet sich in Submodul '%.*s=
'"
 #: pathspec.c:340
 #, c-format
 msgid "%s: pathspec magic not supported by this command: %s"
-msgstr ""
+msgstr "%s: Pfadspezifikationsangabe wird von diesem Kommando nicht un=
terst=C3=BCtzt: %s"
=20
 #: pathspec.c:415
-#, fuzzy, c-format
+#, c-format
 msgid "pathspec '%s' is beyond a symbolic link"
-msgstr "'%s' ist hinter einem symbolischen Verweis"
+msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
=20
 #: remote.c:1833
-#, fuzzy, c-format
+#, c-format
 msgid "Your branch is based on '%s', but the upstream is gone.\n"
-msgstr "Ihr Branch ist vor '%s' um %d Commit.\n"
+msgstr "Ihr Branch basiert auf '%s', aber Upstream-Branch wurde entfer=
nt.\n"
=20
 #: remote.c:1837
-#, fuzzy
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
-msgstr "    git branch --set-upstream-to %s\n"
+msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n=
"
=20
 #: remote.c:1840
-#, fuzzy, c-format
+#, c-format
 msgid "Your branch is up-to-date with '%s'.\n"
-msgstr "Ihr Branch ist vor '%s' um %d Commit.\n"
+msgstr "Ihr Branch ist auf dem selben Stand wie '%s'.\n"
=20
 #: remote.c:1844
 #, c-format
@@ -1329,54 +1326,49 @@ msgstr "Upstream-Branch '%s' ist nicht als Remo=
te-Tracking-Branch gespeichert"
=20
 #: submodule.c:64 submodule.c:98
 msgid "Cannot change unmerged .gitmodules, resolve merge conflicts fir=
st"
-msgstr ""
+msgstr "Kann nicht zusammengef=C3=BChrte .gitmodules-Datei nicht =C3=A4=
ndern, l=C3=B6sen\n"
+"Sie zuerst die Konflikte auf"
=20
 #: submodule.c:68 submodule.c:102
 #, c-format
 msgid "Could not find section in .gitmodules where path=3D%s"
-msgstr ""
+msgstr "Konnte keine Sektion in .gitmodules mit Pfad \"%s\" finden"
=20
 #. Maybe the user already did that, don't error out here
 #: submodule.c:76
-#, fuzzy, c-format
+#, c-format
 msgid "Could not update .gitmodules entry %s"
-msgstr "Konnte git-Verweis %s nicht erstellen"
+msgstr "Konnte Eintrag '%s' in .gitmodules nicht aktualisieren"
=20
 #. Maybe the user already did that, don't error out here
 #: submodule.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "Could not remove .gitmodules entry for %s"
-msgstr "Konnte Sektion '%s' nicht aus Konfiguration entfernen"
+msgstr "Konnte Eintrag '%s' nicht aus .gitmodules entfernen"
=20
 #: submodule.c:127
-#, fuzzy
 msgid "could not find .gitmodules in index"
-msgstr "Konnte die Staging-Area nicht lesen"
+msgstr "Konnte .gitmodules nicht in der Staging-Area finden"
=20
 #: submodule.c:133
-#, fuzzy
 msgid "reading updated .gitmodules failed"
-msgstr "Hinzuf=C3=BCgen von Dateien fehlgeschlagen"
+msgstr "Lesen der aktualisierten .gitmodules-Datei fehlgeschlagen"
=20
 #: submodule.c:135
-#, fuzzy
 msgid "unable to stat updated .gitmodules"
-msgstr "konnte neu erstellte Datei '%s' nicht lesen"
+msgstr "Konnte aktualisierte .gitmodules-Datei nicht lesen"
=20
 #: submodule.c:139
-#, fuzzy
 msgid "unable to remove .gitmodules from index"
-msgstr "konnte %s nicht aus der Staging-Area entfernen"
+msgstr "Konnte .gitmodules nicht aus der Staging-Area entfernen"
=20
 #: submodule.c:141
-#, fuzzy
 msgid "adding updated .gitmodules failed"
-msgstr "Hinzuf=C3=BCgen von Dateien fehlgeschlagen"
+msgstr "Konnte aktualisierte .gitmodules-Datei nicht hinzuf=C3=BCgen"
=20
 #: submodule.c:143
-#, fuzzy
 msgid "staging updated .gitmodules failed"
-msgstr "Aktualisierung der Dateien fehlgeschlagen"
+msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vormer=
ken"
=20
 #: submodule.c:1144 builtin/init-db.c:363
 #, c-format
@@ -1384,40 +1376,38 @@ msgid "Could not create git link %s"
 msgstr "Konnte git-Verweis %s nicht erstellen"
=20
 #: submodule.c:1155
-#, fuzzy, c-format
+#, c-format
 msgid "Could not set core.worktree in %s"
-msgstr "Konnte Arbeitsverzeichnis '%s' nicht erstellen."
+msgstr "Konnte core.worktree in '%s' nicht setzen."
=20
 #: urlmatch.c:120
 msgid "invalid URL scheme name or missing '://' suffix"
-msgstr ""
+msgstr "Ung=C3=BCltiges URL-Schema oder Suffix '://' fehlt"
=20
 #: urlmatch.c:144 urlmatch.c:297 urlmatch.c:356
 #, c-format
 msgid "invalid %XX escape sequence"
-msgstr ""
+msgstr "ung=C3=BCltige Escape-Sequenz %XX"
=20
 #: urlmatch.c:172
 msgid "missing host and scheme is not 'file:'"
-msgstr ""
+msgstr "fehlender Host und Schema ist nicht 'file:'"
=20
 #: urlmatch.c:189
 msgid "a 'file:' URL may not have a port number"
-msgstr ""
+msgstr "eine 'file:' URL darf keine Portnummer enthalten"
=20
 #: urlmatch.c:199
 msgid "invalid characters in host name"
-msgstr ""
+msgstr "Hostname enth=C3=A4lt ung=C3=BCltige Zeichen"
=20
 #: urlmatch.c:244 urlmatch.c:255
-#, fuzzy
 msgid "invalid port number"
-msgstr "Nummer des Elternteils"
+msgstr "ung=C3=BCltige Portnummer"
=20
 #: urlmatch.c:322
-#, fuzzy
 msgid "invalid '..' path segment"
-msgstr "ung=C3=BCltige Pfadspezifikation"
+msgstr "ung=C3=BCltiges '..' Pfadsegment"
=20
 #: wrapper.c:422
 #, c-format
@@ -1718,9 +1708,9 @@ msgstr ""
 "abgeschlossen sind)"
=20
 #: wt-status.c:999
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently cherry-picking commit %s."
-msgstr "Sie f=C3=BChren gerade \"cherry-pick\" aus."
+msgstr "Sie f=C3=BChren gerade \"cherry-pick\" von Commit %s aus."
=20
 #: wt-status.c:1004
 msgid "  (fix conflicts and run \"git cherry-pick --continue\")"
@@ -1890,7 +1880,7 @@ msgstr "Initialer Commit auf "
=20
 #: wt-status.c:1463
 msgid "gone"
-msgstr ""
+msgstr "entfernt"
=20
 #: wt-status.c:1465
 msgid "behind "
@@ -2886,12 +2876,12 @@ msgstr "Branch '%s' zeigt auf keinen Commit"
 #: builtin/branch.c:453
 #, c-format
 msgid "[%s: gone]"
-msgstr ""
+msgstr "[%s: entfernt]"
=20
 #: builtin/branch.c:456
 #, c-format
 msgid "[%s]"
-msgstr ""
+msgstr "[%s]"
=20
 #: builtin/branch.c:459
 #, c-format
@@ -3281,7 +3271,7 @@ msgstr "liest Dateinamen von der Standard-Eingabe=
"
=20
 #: builtin/check-attr.c:23 builtin/check-ignore.c:24
 msgid "terminate input and output records by a NUL character"
-msgstr ""
+msgstr "schlie=C3=9Ft Eintr=C3=A4ge von Ein- und Ausgabe mit NUL-Zeich=
en ab"
=20
 #: builtin/check-ignore.c:18 builtin/checkout.c:1090 builtin/gc.c:259
 msgid "suppress progress reporting"
@@ -3293,7 +3283,7 @@ msgstr "zeigt Eingabe-Pfade ohne =C3=9Cbereinstim=
mungen"
=20
 #: builtin/check-ignore.c:28
 msgid "ignore index when checking"
-msgstr ""
+msgstr "ignoriert Staging-Area bei der Pr=C3=BCfung"
=20
 #: builtin/check-ignore.c:154
 msgid "cannot specify pathnames with --stdin"
@@ -3545,7 +3535,7 @@ msgstr "Sie sind auf einem Branch, der noch gebor=
en wird"
 #: builtin/checkout.c:935
 #, c-format
 msgid "only one reference expected, %d given."
-msgstr ""
+msgstr "nur eine Referenz erwartet, %d gegeben."
=20
 #: builtin/checkout.c:974
 #, c-format
@@ -4786,7 +4776,7 @@ msgstr "gibt Werte f=C3=BCr den regul=C3=A4ren Au=
sdruck zur=C3=BCck: Name-regex [Wert-regex]
=20
 #: builtin/config.c:64
 msgid "get value specific for the URL: section[.var] URL"
-msgstr ""
+msgstr "gibt Wert spezifisch f=C3=BCr eine URL zur=C3=BCck: section[.v=
ar] URL"
=20
 #: builtin/config.c:65
 msgid "replace all matching variables: name value [value_regex]"
@@ -5484,7 +5474,8 @@ msgstr "aktiviert \"auto-gc\" Modus"
=20
 #: builtin/gc.c:265
 msgid "force running gc even if there may be another gc running"
-msgstr ""
+msgstr "erzwingt Ausf=C3=BChrung von \"git gc\" selbst wenn ein andere=
s\n"
+"\"git gc\" bereits ausgef=C3=BChrt wird"
=20
 #: builtin/gc.c:305
 #, c-format
@@ -5502,6 +5493,8 @@ msgstr ""
 msgid ""
 "gc is already running on machine '%s' pid %<PRIuMAX> (use --force if =
not)"
 msgstr ""
+"\"git gc\" wird bereits auf Maschine '%s' pid %<PRIuMAX> ausgef=C3=BC=
hrt\n"
+"(benutzen Sie --force falls nicht)"
=20
 #: builtin/gc.c:340
 msgid ""
@@ -5581,9 +5574,8 @@ msgid "don't match patterns in binary files"
 msgstr "findet keine Muster in Bin=C3=A4rdateien"
=20
 #: builtin/grep.c:662
-#, fuzzy
 msgid "process binary files with textconv filters"
-msgstr "verarbeitet bin=C3=A4re Dateien als Text"
+msgstr "verarbeitet bin=C3=A4re Dateien mit \"textconv\"-Filtern"
=20
 #: builtin/grep.c:664
 msgid "descend at most <depth> levels"
@@ -7226,13 +7218,13 @@ msgstr "kann Verzeichnis nicht =C3=BCber Datei =
verschieben"
 #: builtin/mv.c:129
 #, c-format
 msgid "Huh? Directory %s is in index and no submodule?"
-msgstr ""
+msgstr "Huh? Verzeichnis %s ist zum Commit vorgemerkt und kein Submodu=
l?"
=20
 #: builtin/mv.c:131 builtin/rm.c:318
-#, fuzzy
 msgid "Please, stage your changes to .gitmodules or stash them to proc=
eed"
 msgstr ""
-"Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\" um fo=
rtzufahren."
+"Bitte merken Sie Ihre =C3=84nderungen in .gitmodules zum Commit vor o=
der benutzen\n"
+"Sie \"stash\" um fortzufahren."
=20
 #: builtin/mv.c:147
 #, c-format
@@ -7312,9 +7304,8 @@ msgid "read from stdin"
 msgstr "liest von der Standard-Eingabe"
=20
 #: builtin/name-rev.c:320
-#, fuzzy
 msgid "allow to print `undefined` names (default)"
-msgstr "erlaubt Ausgabe von `undefinierten` Namen"
+msgstr "erlaubt Ausgabe von `undefinierten` Namen (Standard)"
=20
 #: builtin/name-rev.c:326
 msgid "dereference tags in the input (internal use)"
@@ -8139,11 +8130,11 @@ msgstr "erzwingt Aktualisierung"
=20
 #: builtin/push.c:463
 msgid "refname>:<expect"
-msgstr ""
+msgstr "Referenzname>:<Erwartungswert"
=20
 #: builtin/push.c:464
 msgid "require old value of ref to be at this value"
-msgstr ""
+msgstr "Referenz muss sich auf dem angegebenen Wert befinden"
=20
 #: builtin/push.c:466
 msgid "check"
@@ -8291,9 +8282,8 @@ msgid "git remote remove <name>"
 msgstr "git remote remove <Name>"
=20
 #: builtin/remote.c:15
-#, fuzzy
 msgid "git remote set-head <name> (-a | --auto | -d | --delete |<branc=
h>)"
-msgstr "git remote set-head <Name> (-a | -d | <Branch>)"
+msgstr "git remote set-head <Name> (-a | --auto | -d | --delete | <Bra=
nch>)"
=20
 #: builtin/remote.c:16
 msgid "git remote [-v | --verbose] show [-n] <name>"
@@ -8330,9 +8320,8 @@ msgid "git remote add [<options>] <name> <url>"
 msgstr "git remote add [<Optionen>] <Name> <URL>"
=20
 #: builtin/remote.c:42
-#, fuzzy
 msgid "git remote set-head <name> (-a | --auto | -d | --delete | <bran=
ch>)"
-msgstr "git remote set-head <Name> (-a | -d | <Branch>)"
+msgstr "git remote set-head <Name> (-a | --auto | -d | --delete | <Bra=
nch>)"
=20
 #: builtin/remote.c:47
 msgid "git remote set-branches <name> <branch>..."
@@ -8784,71 +8773,66 @@ msgid "be verbose; must be placed before a subc=
ommand"
 msgstr "erweiterte Ausgaben; muss vor einem Unterkommando angegeben we=
rden"
=20
 #: builtin/repack.c:15
-#, fuzzy
 msgid "git repack [options]"
-msgstr "git pack-refs [Optionen]"
+msgstr "git repack [Optionen]"
=20
 #: builtin/repack.c:143
-#, fuzzy
 msgid "pack everything in a single pack"
-msgstr "packt alles"
+msgstr "packt alles in eine einzige Pack-Datei"
=20
 #: builtin/repack.c:145
-#, fuzzy
 msgid "same as -a, and turn unreachable objects loose"
-msgstr "zeigt unerreichbare Objekte"
+msgstr "genau wie -a, unerreichbare Objekte werden aber nicht gel=C3=B6=
scht"
=20
 #: builtin/repack.c:148
 msgid "remove redundant packs, and run git-prune-packed"
-msgstr ""
+msgstr "entfernt redundante Pakete und f=C3=BChrt \"git-prune-packed\"=
 aus"
=20
 #: builtin/repack.c:150
 msgid "pass --no-reuse-delta to git-pack-objects"
-msgstr ""
+msgstr "=C3=BCbergibt --no-reuse-delta an git-pack-objects"
=20
 #: builtin/repack.c:152
 msgid "pass --no-reuse-object to git-pack-objects"
-msgstr ""
+msgstr "=C3=BCbergibt --no-reuse-object an git-pack-objects"
=20
 #: builtin/repack.c:154
-#, fuzzy
 msgid "do not run git-update-server-info"
-msgstr "git update-server-info [--force]"
+msgstr "git-update-server-info nicht ausf=C3=BChren"
=20
 #: builtin/repack.c:157
 msgid "pass --local to git-pack-objects"
-msgstr ""
+msgstr "=C3=BCbergibt --local an git-pack-objects"
=20
 #: builtin/repack.c:158
 msgid "approxidate"
-msgstr ""
+msgstr "Datumsangabe"
=20
 #: builtin/repack.c:159
-#, fuzzy
 msgid "with -A, do not loosen objects older than this"
-msgstr "l=C3=A4sst Objekte =C3=A4lter als <Zeit> verfallen"
+msgstr "mit -A, l=C3=B6scht keine Objekte =C3=A4lter als dieses Datum"
=20
 #: builtin/repack.c:161
 msgid "size of the window used for delta compression"
-msgstr ""
+msgstr "Gr=C3=B6=C3=9Fe des Fensters f=C3=BCr die Delta-Kompression"
=20
 #: builtin/repack.c:163
 msgid "same as the above, but limit memory size instead of entries cou=
nt"
-msgstr ""
+msgstr "gleiches wie oben, limitiert aber die Speichergr=C3=B6=C3=9Fe =
anstatt der\n"
+"Anzahl der Eintr=C3=A4ge"
=20
 #: builtin/repack.c:165
 msgid "limits the maximum delta depth"
-msgstr ""
+msgstr "limitiert die maximale Delta-Tiefe"
=20
 #: builtin/repack.c:167
-#, fuzzy
 msgid "maximum size of each packfile"
-msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jede ausgegebene Paketdatei"
+msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jede Paketdatei"
=20
 #: builtin/repack.c:345
-#, fuzzy, c-format
+#, c-format
 msgid "removing '%s' failed"
-msgstr "Umbenennung von '%s' fehlgeschlagen"
+msgstr "L=C3=B6schen von '%s' fehlgeschlagen"
=20
 #: builtin/replace.c:17
 msgid "git replace [-f] <object> <replacement>"
@@ -9749,9 +9733,8 @@ msgid "git update-ref [options]    <refname> <new=
val> [<oldval>]"
 msgstr "git update-ref [Optionen]    <Referenzname> <neuerWert> [<alte=
rWert>]"
=20
 #: builtin/update-ref.c:11
-#, fuzzy
 msgid "git update-ref [options] --stdin [-z]"
-msgstr "git name-rev [Optionen] --stdin"
+msgstr "git update-ref [Optionen] --stdin [-z]"
=20
 #: builtin/update-ref.c:255
 msgid "delete the reference"
@@ -9762,14 +9745,12 @@ msgid "update <refname> not the one it points t=
o"
 msgstr "aktualisiert <Referenzname>, nicht den Verweis"
=20
 #: builtin/update-ref.c:258
-#, fuzzy
 msgid "stdin has NUL-terminated arguments"
-msgstr "Eingabe ist durch NUL-Zeichen abgeschlossen"
+msgstr "Standard-Eingabe hat durch NUL-Zeichen abgeschlossene Argument=
e"
=20
 #: builtin/update-ref.c:259
-#, fuzzy
 msgid "read updates from stdin"
-msgstr "liest von der Standard-Eingabe"
+msgstr "liest Aktualisierungen von der Standard-Eingabe"
=20
 #: builtin/update-server-info.c:6
 msgid "git update-server-info [--force]"
--=20
1.8.5.rc1.303.g27c0606
