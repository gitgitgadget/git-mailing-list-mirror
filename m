From: avarab@gmail.com
Subject: [PATCH 1/2] po/de.po: add German translation
Date: Sat,  4 Sep 2010 00:49:26 +0000
Message-ID: <4c8197ab.1707e30a.3f10.714a@mx.google.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 02:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrgxX-0006cP-3T
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab0IDAtx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:49:53 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46695 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab0IDAtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 20:49:49 -0400
Received: by mail-ww0-f42.google.com with SMTP id 20so13162wwd.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fhaYWUhyGXq8posbX5fIfoQQMNYtyd9zaby59e9h13s=;
        b=LqtrfxSgmthM7fZR22HK05BKAmFYkM9wpPZopsj0u9shp8EmMA/xFAtSdVtdbySSW4
         rXdrgfSzya1hG8T2J5sKFUGJxdIYpecTcH4nh2O4gMlc3SS4po9Vlkzjkso7mBIO/A8/
         5aGIRom/5O7Nfj0MbHaCveSIMdpkZ+zcBvfno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y4Far+F9nyOmOr0PdBtdzNp7OocQgHzrZ5VkLCGwqzz6GaQqEUqaRtaVQvI/UyR2gF
         rYHPkTr/CWSuuo6FMr4tIXed6QFw38ah6V4ybGf+pcGZyUM93GrBJL4wfyAD/ZDVhnsy
         pD0eDGBA8T2dzhg+qvXxb2mLWPZ0puyeIfyGY=
Received: by 10.227.157.17 with SMTP id z17mr271077wbw.122.1283561388444;
        Fri, 03 Sep 2010 17:49:48 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm2108432wbb.22.2010.09.03.17.49.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 17:49:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155294>

=46rom: Jan Kr=C3=BCger <jk@jk.gs>

Translate all the translatable messages currently in Git, except for
the 10 TEST messages that shouldn't be translated.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/de.po | 1888 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 1888 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po

diff --git a/po/de.po b/po/de.po
new file mode 100644
index 0000000..2f178f5
--- /dev/null
+++ b/po/de.po
@@ -0,0 +1,1888 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-09-03 15:45+0200\n"
+"Last-Translator: Jan Kr=C3=BCger <jk@jk.gs>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Language: de\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+msgid "# Unmerged paths:"
+msgstr "# Verbleibende Konflikte in Pfaden:"
+
+#, c-format
+msgid "#   (use \"git reset %s <file>...\" to unstage)"
+msgstr ""
+"#   (benutze \"git reset %s <Datei>\", um die =C3=84nderungen nicht m=
ehr "
+"vorzumerken)"
+
+msgid "#   (use \"git rm --cached <file>...\" to unstage)"
+msgstr ""
+"#   (benutze \"git rm --cached <Datei>\", um die Datei nicht mehr "
+"vorzumerken)"
+
+msgid "#   (use \"git add/rm <file>...\" as appropriate to mark resolu=
tion)"
+msgstr ""
+"#   (benutze \"git add/rm <Datei>...\", um den Konflikt als gel=C3=B6=
st zu "
+"markieren)"
+
+msgid "# Changes to be committed:"
+msgstr "# Vorgemerkte =C3=84nderungen f=C3=BCr den n=C3=A4chsten Commi=
t:"
+
+msgid "# Changed but not updated:"
+msgstr "# Ge=C3=A4ndert, aber nicht f=C3=BCr den n=C3=A4chsten Commit =
vorgemerkt:"
+
+msgid "#   (use \"git add <file>...\" to update what will be committed=
)"
+msgstr ""
+"#   (benutze \"git add <Datei>...\", um den aktuellen Stand vorzumerk=
en)"
+
+msgid "#   (use \"git add/rm <file>...\" to update what will be commit=
ted)"
+msgstr ""
+"#   (benutze entsprechend \"git add/rm <Datei>...\", um den aktuellen=
 Stand "
+"vorzumerken)"
+
+msgid ""
+"#   (use \"git checkout -- <file>...\" to discard changes in working =
"
+"directory)"
+msgstr ""
+"#   (benutze \"git checkout -- <Datei>...\", um =C3=84nderungen in de=
r Datei zu "
+"verwerfen)"
+
+msgid "#   (commit or discard the untracked or modified content in sub=
modules)"
+msgstr ""
+"#   (committe oder verwerfe die unber=C3=BCcksichtigten Dateien oder =
=C3=84nderungen "
+"in Submodules)"
+
+#, c-format
+msgid "# %s files:"
+msgstr "# %s Dateien:"
+
+#, c-format
+msgid "#   (use \"git %s <file>...\" to include in what will be commit=
ted)"
+msgstr ""
+"#   (benutze \"git %s <Datei>...\", um zu vorgemerkten Dateien hinzuz=
uf=C3=BCgen)"
+
+msgid "bug"
+msgstr "Bug"
+
+msgid "both deleted:"
+msgstr "beide gel=C3=B6scht:"
+
+msgid "added by us:"
+msgstr "hier hinzugef=C3=BCgt:"
+
+msgid "deleted by them:"
+msgstr "dort gel=C3=B6scht:"
+
+msgid "added by them:"
+msgstr "dort hinzugef=C3=BCgt:"
+
+msgid "deleted by us:"
+msgstr "hier gel=C3=B6scht:"
+
+msgid "both added:"
+msgstr "bei beiden hinzugef=C3=BCgt:"
+
+msgid "both modified:"
+msgstr "bei beiden ge=C3=A4ndert:"
+
+msgid "new commits, "
+msgstr "neue Commits, "
+
+msgid "modified content, "
+msgstr "ver=C3=A4nderte Dateien, "
+
+msgid "untracked content, "
+msgstr "unber=C3=BCcksichtigte Dateien, "
+
+#, c-format
+msgid "new file:   %s"
+msgstr "neue Datei: %s"
+
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr "kopiert:    %s -> %s"
+
+#, c-format
+msgid "deleted:    %s"
+msgstr "gel=C3=B6scht:   %s"
+
+#, c-format
+msgid "modified:   %s"
+msgstr "ge=C3=A4ndert:   %s"
+
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr "umbenannt:  %s -> %s"
+
+#, c-format
+msgid "typechange: %s"
+msgstr "neuer Typ:  %s"
+
+#, c-format
+msgid "unknown:    %s"
+msgstr "unbekannt:  %s"
+
+#, c-format
+msgid "unmerged:   %s"
+msgstr "Konflikt:   %s"
+
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr "Bug: nicht behandelter Diff-Status %c"
+
+msgid "On branch "
+msgstr "Aktueller Branch: "
+
+msgid "Not currently on any branch."
+msgstr "Aktuell ist kein Branch aktiv."
+
+msgid "# Initial commit"
+msgstr "# Erster Commit"
+
+msgid "Untracked"
+msgstr "Unber=C3=BCcksichtigte"
+
+msgid "add"
+msgstr "add"
+
+msgid "Ignored"
+msgstr "Ignorierte"
+
+msgid "add -f"
+msgstr "add -f"
+
+#, c-format
+msgid "# Untracked files not listed%s\n"
+msgstr "# Unber=C3=BCcksichtigte Dateien werden nicht aufgef=C3=BChrt%=
s\n"
+
+msgid " (use -u option to show untracked files)"
+msgstr " (benutze die Option -u, um sie anzuzeigen)"
+
+#, c-format
+msgid "# No changes\n"
+msgstr "# Keine =C3=84nderungen\n"
+
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr "keine =C3=84nderungen f=C3=BCr den Commit vorgemerkt\n"
+
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr " (benutze \"git add\" und/oder \"git commit -a\")"
+
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr "keine =C3=84nderungen f=C3=BCr den Commit vorgemerkt, aber unb=
er=C3=BCcksichtigte Dateien vorhanden\n"
+
+msgid " (use \"git add\" to track)"
+msgstr " (benutze \"git add\", um sie zu ber=C3=BCcksichtigen)"
+
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr " (erstelle Dateien und benutze \"git add\", um sie zu ber=C3=BC=
cksichtigen)"
+
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr "nichts zu committen%s\n"
+
+msgid " (use -u to show untracked files)"
+msgstr " (benutze -u, um unber=C3=BCcksichtigte Datei anzuzeigen)"
+
+msgid " (working directory clean)"
+msgstr " (Arbeitsverzeichnis sauber)"
+
+msgid "HEAD (no branch)"
+msgstr "HEAD (kein Branch)"
+
+msgid "Initial commit on "
+msgstr "Erster Commit in "
+
+msgid "behind "
+msgstr "nur dort "
+
+msgid "ahead "
+msgstr "nur hier "
+
+msgid ", behind "
+msgstr "nur dort "
+
+#, c-format
+msgid "unexpected diff status %c"
+msgstr "unerwarteter Diff-Status %s"
+
+msgid "updating files failed"
+msgstr "Aktualisieren der Dateien ist fehlgeschlagen"
+
+#, c-format
+msgid "remove '%s'\n"
+msgstr "entferne '%s'\n"
+
+#, c-format
+msgid "Path '%s' is in submodule '%.*s'"
+msgstr "Pfad '%s' ist im Submodule '%.*s'"
+
+msgid "Unstaged changes after refreshing the index:"
+msgstr "Nicht vorgemerkte =C3=84nderungen nach Aktualisieren des Index=
es:"
+
+#, c-format
+msgid "pathspec '%s' did not match any files"
+msgstr "Pfadangabe '%s' passt auf keine Dateien"
+
+#, c-format
+msgid "'%s' is beyond a symbolic link"
+msgstr "'%s' befindet sich jenseits eines symbolischen Links"
+
+msgid "Could not read the index"
+msgstr "Konnte den Index nicht auslesen"
+
+#, c-format
+msgid "Could not open '%s' for writing."
+msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
+
+msgid "Could not write patch"
+msgstr "Konnte keinen Patch erstellen"
+
+# Keine genaue =C3=9Cbersetzung, aber IMO im Kontext passend --jk@jk.g=
s
+#, c-format
+msgid "Could not stat '%s'"
+msgstr "Konnte '%s' nicht mehr finden"
+
+msgid "Empty patch. Aborted."
+msgstr "Leerer Patch. Breche ab."
+
+#, c-format
+msgid "Could not apply '%s'"
+msgstr "Konnte '%s' nicht anwenden"
+
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr "Benutze -f, wenn du sie wirklich hinzuf=C3=BCgen willst.\n"
+
+msgid "no files added"
+msgstr "keine Dateien hinzugef=C3=BCgt"
+
+msgid "adding files failed"
+msgstr "Das Hinzuf=C3=BCgen der Dateien ist fehlgeschlagen"
+
+msgid "-A and -u are mutually incompatible"
+msgstr "-A und -u vertragen sich nicht"
+
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr "Option --ignore-missing kann nur zusammen mit --dry-run benutz=
t werden"
+
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr "Nichts angegeben, nichts hinzugef=C3=BCgt.\n"
+
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr "Vielleicht wolltest du 'git add .' benutzen?\n"
+
+msgid "index file corrupt"
+msgstr "Indexdatei besch=C3=A4digt"
+
+msgid "Unable to write new index file"
+msgstr "Konnte keine neue Indexdatei anlegen"
+
+#, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but it is not yet merged to HEAD."
+msgstr ""
+"l=C3=B6sche Branch '%', der nach '%s' gemerged wurde,\n"
+"         aber er ist noch nicht nach HEAD gemerged."
+
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+"l=C3=B6sche Branch '%s' nicht, der noch nicht nach '%s' gemerged\n"
+"wurde, auch wenn er schon nach HEAD gemerged wurde."
+
+#. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
+msgid "remote "
+msgstr "Remote-"
+
+msgid "cannot use -a with -d"
+msgstr "du kannst -a und -d nicht zusammen benutzen"
+
+msgid "Couldn't look up commit object for HEAD"
+msgstr "Konnte Commit-Objekt f=C3=BCr HEAD nicht finden"
+
+#, c-format
+msgid "Cannot delete the branch '%s' which you are currently on."
+msgstr "Du kannst den aktiven Branch '%s' nicht l=C3=B6schen."
+
+#, c-format
+msgid "%sbranch '%s' not found."
+msgstr "%sBranch '%s' nicht gefunden."
+
+#, c-format
+msgid "Couldn't look up commit object for '%s'"
+msgstr "Konnte Commit-Objekt f=C3=BCr '%s' nicht finden"
+
+#, c-format
+msgid ""
+"The branch '%s' is not fully merged.\n"
+"If you are sure you want to delete it, run 'git branch -D %s'."
+msgstr ""
+"Der Branch '%s' ist nicht komplett gemerged.\n"
+"Wenn du ihn trotzdem l=C3=B6schen willst, benutze 'git branch -D %s'.=
"
+
+#, c-format
+msgid "Error deleting %sbranch '%s'"
+msgstr "Fehler beim L=C3=B6schen von %sBranch '%s'"
+
+#, c-format
+msgid "Deleted %sbranch %s (was %s).\n"
+msgstr "%sBranch '%s' gel=C3=B6scht (war %s).\n"
+
+msgid "Update of config-file failed"
+msgstr "Konfigurationsdatei konnte nicht aktualisiert werden"
+
+#, c-format
+msgid "branch '%s' does not point at a commit"
+msgstr "Branch '%s' zeigt nicht auf einen Commit"
+
+#, c-format
+msgid "behind %d] "
+msgstr "nur dort %d] "
+
+#, c-format
+msgid "ahead %d] "
+msgstr "nur hier %d] "
+
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr "nur hier %d, nur dort %d] "
+
+msgid "(no branch)"
+msgstr "(kein Branch)"
+
+msgid "some refs could not be read"
+msgstr "einige Eintr=C3=A4ge konnten nicht gelesen werden"
+
+msgid "cannot rename the current branch while not on any."
+msgstr ""
+"kann den aktuellen Branch nicht umbenennen, wenn es keinen aktuellen =
Branch "
+"gibt."
+
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr "Ung=C3=BCltiger Name f=C3=BCr Branch: '%s'"
+
+#, c-format
+msgid "A branch named '%s' already exists."
+msgstr "Einen Branch namens '%s' gibt es schon."
+
+msgid "Branch rename failed"
+msgstr "Umbenennung des Branches fehlgeschlagen"
+
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr "Ung=C3=BCltigen Branchnamen '%s' durch Umbenennen in Ordnung g=
ebracht"
+
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr "Branch umbenannt nach %s, aber HEAD nicht aktualisiert!"
+
+msgid "Branch is renamed, but update of config-file failed"
+msgstr ""
+"Branch wurde umbenannt, aber die Konfigurationsdatei konnte nicht "
+"aktualisiert werden"
+
+#, c-format
+msgid "malformed object name %s"
+msgstr "ung=C3=BCltiger Objektname %s"
+
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr "Konnte HEAD nicht als g=C3=BCltige Referenze aufl=C3=B6sen."
+
+msgid "HEAD not found below refs/heads!"
+msgstr "HEAD zeigt nicht auf eine Referenz unter refs/heads!"
+
+msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
+msgstr ""
+"Die Optionen -a und -r f=C3=BCr 'git branch' ergeben keinen Sinn zusa=
mmen mit "
+"einem Branchnamen"
+
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr "Pfad '%s' hat keine Version 'von uns' im Index"
+
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr "Pfad '%s' hat keine Version 'von denen' im Index"
+
+#, c-format
+msgid "path '%s' does not have all three versions"
+msgstr "Pfad '%s' hat keine drei verschiedenen Versionen im Index"
+
+#, c-format
+msgid "path '%s' does not have all 3 versions"
+msgstr "Pfad '%s' hat keine drei verschiedenen Versionen im Index"
+
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr "Pfad '%s': kann nicht mergen"
+
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr "Kann Merge-Ergebnis f=C3=BCr '%s' nicht hinzuf=C3=BCgen"
+
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr "make_cache_entry fehlgeschlagen f=C3=BCr Pfad '%s'"
+
+msgid "corrupt index file"
+msgstr "besch=C3=A4digte Indexdatei"
+
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr "Pfad '%s' enth=C3=A4lt Konflikte"
+
+msgid "unable to write new index file"
+msgstr "kann keine neue Indexdatei anlegen"
+
+msgid "diff_setup_done failed"
+msgstr "diff_setup_done fehlgeschlagen"
+
+msgid "you need to resolve your current index first"
+msgstr "du musst zuerst Konflikte im aktuellen Index aufl=C3=B6sen"
+
+#, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr "Kann Reflog f=C3=BCr '%s' nicht einrichten\n"
+
+#, c-format
+msgid "Already on '%s'\n"
+msgstr "'%s' ist schon aktiv\n"
+
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr "Zu Branch '%s' gewechselt und Inhalt =C3=BCberschrieben\n"
+
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr "Zu neuem Branch '%s' gewechselt\n"
+
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr "Zu Branch '%s' gewechselt\n"
+
+msgid "HEAD is now at"
+msgstr "HEAD zeigt jetzt auf"
+
+msgid "You are on a branch yet to be born"
+msgstr "Der aktive Branch ist noch nicht angelegt"
+
+msgid "Previous HEAD position was"
+msgstr "HEAD zeigte vorher auf"
+
+msgid "-B cannot be used with -b"
+msgstr "-B kann nicht mit -b kombiniert werden"
+
+msgid "--patch is incompatible with all other options"
+msgstr "--patch vertr=C3=A4gt sich nicht mit allen anderen Optionen"
+
+msgid "--track needs a branch name"
+msgstr "--track braucht einen Branchnamen"
+
+msgid "Missing branch name; try -b"
+msgstr "Fehlender Branchname; versuch's mit -b"
+
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr "--orphan und -b|-B vertragen sich nicht"
+
+msgid "--orphan cannot be used with -t"
+msgstr "--orphan kann nicht mit -t kombiniert werden"
+
+msgid "git checkout: -f and -m are incompatible"
+msgstr "git checkout: -f und -m sind nicht kompatibel"
+
+#. case (1)
+#, c-format
+msgid "invalid reference: %s"
+msgstr "ung=C3=BCltige Referenz: %s"
+
+#. case (1): want a tree
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr "Referenz ist kein Tree: %s"
+
+msgid "invalid path specification"
+msgstr "ung=C3=BCltige Pfadangabe"
+
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+"git checkout: Pfade aktualisieren und den Branch wechseln kann nicht\=
n"
+"kombiniert werden. Wolltest du '%s' (das wir nicht als Commit\n"
+"finden k=C3=B6nnen) auschecken?"
+
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr ""
+"git checkout: Pfade aktualisieren und den Branch wechseln kann nicht =
"
+"kombiniert werden."
+
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+"git checkout: --ours/--theirs, --force und --merge ergeben keinen Sin=
n, "
+"wenn\n"
+"Pfade aus dem Index ausgecheckt werden."
+
+#, c-format
+msgid "git checkout: we do not like '%s' as a branch name."
+msgstr "git checkout: '%s' ist kein g=C3=BCltiger Branchname."
+
+#, c-format
+msgid "git checkout: branch %s already exists"
+msgstr "git checkout: den Branch '%s' gibt es schon"
+
+msgid "Cannot switch branch to a non-commit."
+msgstr "Kann einen Branch nicht auf etwas anderes als einen Commit umb=
iegen."
+
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr "--ours/--theirs k=C3=B6nnen nicht beim Branch-wechseln benutzt=
 werden."
+
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr "Referenz-Repository '%s' ist kein lokales Verzeichnis."
+
+#, c-format
+msgid "failed to open '%s'"
+msgstr "konnte '%s' nicht =C3=B6ffnen"
+
+#, c-format
+msgid "failed to create directory '%s'"
+msgstr "konnte Verzeichnis '%s' nicht anlegen"
+
+#, c-format
+msgid "failed to stat '%s'"
+msgstr "konnte '%s' nicht finden/pr=C3=BCfen"
+
+#, c-format
+msgid "%s exists and is not a directory"
+msgstr "%s existiert und ist kein Verzeichnis"
+
+#, c-format
+msgid "failed to stat %s\n"
+msgstr "konnte '%s' nicht finden/pr=C3=BCfen\n"
+
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr "konnte '%s' nicht entfernen"
+
+#, c-format
+msgid "failed to create link '%s'"
+msgstr "konnte Link '%s' nicht anlegen"
+
+#, c-format
+msgid "failed to copy file to '%s'"
+msgstr "konnte Datei nicht nach '%s' kopieren"
+
+#, c-format
+msgid "done.\n"
+msgstr "fertig.\n"
+
+msgid "Too many arguments."
+msgstr "Zu viele Parameter."
+
+msgid "You must specify a repository to clone."
+msgstr "Du musst ein Quell-Repository angeben."
+
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr "--bare und --origin %s sind nicht kombinierbar."
+
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr "Zielfpad '%s' existiert schon und ist kein leeres Verzeichnis.=
"
+
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr "Arbeitsverzeichnis '%s' existiert schon."
+
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr "konnte =C3=BCbergeordnete Verzeichnisse f=C3=BCr '%s' nicht an=
legen"
+
+#, c-format
+msgid "could not create work tree dir '%s'."
+msgstr "konnte Verzeichnis '%s' im Arbeitsverzeichnis nicht anlegen."
+
+#, c-format
+msgid "Cloning into bare repository %s"
+msgstr "Klone in Lager-Repository %s"
+
+#, c-format
+msgid "Cloning into %s"
+msgstr "Klone nach %s"
+
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr "Ich wei=C3=9F nicht, wie man %s klonen kann"
+
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr ""
+"Remote-branch %s nicht in Ursprung %s gefunden, benutze stattdessen H=
EAD"
+
+msgid "You appear to have cloned an empty repository."
+msgstr "Du hast anscheinend ein leeres Repository geklont."
+
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr ""
+"Ursprungs-HEAD verweist auf fehlende Referenz, kann keinen Checkout m=
achen.\n"
+
+msgid ""
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n=
"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"If the identity used for this commit is wrong, you can fix it with:\n=
"
+"\n"
+"    git commit --amend --author=3D'Your Name <you@example.com>'\n"
+msgstr ""
+"Dein Name und deine E-Mail-Adresse wurden automatisch =C3=BCbernommen=
 aus\n"
+"deinem Benutzernamen und Hostnamen. Bitte pr=C3=BCfe, ob sie korrekt =
sind.\n"
+"Du kannst diese Nachricht loswerden, indem du sie ausdr=C3=BCcklich e=
instellst:\n"
+"\n"
+"    git config --global user.name \"Dein Name\"\n"
+"    git config --global user.email du@example.com\n"
+"\n"
+"Falls die Angaben nicht stimmten, kannst du sie im angelegten Commit\=
n"
+"nachtr=C3=A4glich korrigieren mit:\n"
+"\n"
+"    git commit --amend --author=3D'Dein Name <du@example.com>'\n"
+
+msgid ""
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\=
n"
+"remove the commit entirely with \"git reset HEAD^\".\n"
+msgstr ""
+"Du willst den neuesten Commit nachbearbeiten, aber dadurch w=C3=BCrde=
 er leer\n"
+"werden. Du kannst deinen Befehl mit --allow-empty wiederholen oder de=
n\n"
+"Commit mit \"git reset HEAD^\" komplett entfernen.\n"
+
+msgid "failed to unpack HEAD tree object"
+msgstr "konnte das HEAD-Tree-Objekt nicht entpacken"
+
+msgid "interactive add failed"
+msgstr "Interaktives 'add' fehlgeschlagen"
+
+msgid "unable to write new_index file"
+msgstr "konnte new_index-Datei nicht anlegen"
+
+msgid "cannot do a partial commit during a merge."
+msgstr ""
+"w=C3=A4hrend eines Merges kannst du keinen Commit anlegen, der\n"
+"vorgemerkte =C3=84nderungen ignoriert."
+
+msgid "cannot read the index"
+msgstr "kann den Index nicht auslesen"
+
+msgid "unable to write temporary index file"
+msgstr "kann keine tempor=C3=A4re Indexdatei anlegen"
+
+msgid "could not parse HEAD commit"
+msgstr "konnte HEAD-Commit nicht analysieren"
+
+#, c-format
+msgid "invalid commit: %s"
+msgstr "ung=C3=BCltiger Commit: %s"
+
+msgid "malformed --author parameter"
+msgstr "ung=C3=BCltiger '--author'-Parameter"
+
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr "(Commit-Kommentar wird von der Standardeingabe gelesen)\n"
+
+msgid "could not read log from standard input"
+msgstr "konnte Kommentar nicht von der Standardeingabe lesen"
+
+#, c-format
+msgid "could not read log file '%s'"
+msgstr "konnte Kommentardatei '%s' nicht lesen"
+
+msgid "commit has empty message"
+msgstr "der Commit-Kommentar ist leer"
+
+msgid "could not read MERGE_MSG"
+msgstr "konnte MERGE_MSG nicht lesen"
+
+msgid "could not read SQUASH_MSG"
+msgstr "konnte SQUASH_MSG nicht lesen"
+
+#, c-format
+msgid "could not read '%s'"
+msgstr "konnte '%s' nicht lesen"
+
+#, c-format
+msgid "could not open '%s'"
+msgstr "konnte '%s' nicht =C3=B6ffnen"
+
+msgid "could not write commit template"
+msgstr "konnte Kommentarvorlage nicht anlegen"
+
+#, c-format
+msgid ""
+"#\n"
+"# It looks like you may be committing a MERGE.\n"
+"# If this is not correct, please remove the file\n"
+"#\t%s\n"
+"# and try again.\n"
+"#\n"
+msgstr ""
+"#\n"
+"# Es sieht so aus, als ob du einen MERGE committen willst.\n"
+"# Falls das nicht stimmt, entferne bitte die Datei\n"
+"#\t%s\n"
+"# und versuch's noch einmal.\n"
+"#\n"
+
+#, c-format
+msgid ""
+"\n"
+"# Please enter the commit message for your changes."
+msgstr "\n# Bitte gib einen Commit-Kommentar f=C3=BCr deine =C3=84nder=
ungen an."
+
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be ignored, and an empty message aborts the commit.\n=
"
+msgstr ""
+" Zeilen, die mit '#'\n"
+"# anfangen, werden ignoriert, und ein leerer Kommentar bricht den Com=
mit "
+"ab.\n"
+
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be kept; you may remove them yourself if you want to.=
\n"
+"# An empty message aborts the commit.\n"
+msgstr ""
+" Zeilen, die mit '#'\n"
+"# anfangen, werden beibehalten; du kannst sie selbst entfernen, wenn =
du\n"
+"willst. Ein leerer Kommentar bricht den Commit ab.\n"
+
+#, c-format
+msgid "%s# Author:    %s\n"
+msgstr "%s# Autor:     %s\n"
+
+#, c-format
+msgid "%s# Committer: %s\n"
+msgstr "%s# Committer: %s\n"
+
+msgid "Cannot read index"
+msgstr "Kann Index nicht auslesen"
+
+msgid "Error building trees"
+msgstr "Fehler beim Anlegen der Trees"
+
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr "Bitte gib den Kommentar mit der Option -m oder -F an.\n"
+
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr "Kein bekannter Autor gefunden mit '%s'"
+
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr "Ung=C3=BCltiger Modus f=C3=BCr unber=C3=BCcksichtigte Dateien:=
 '%s'"
+
+msgid "Using both --reset-author and --author does not make sense"
+msgstr "Es ist unsinnig, --reset-author und --author zusammen zu benut=
zen"
+
+msgid "You have nothing to amend."
+msgstr "Da ist nichts, was du nachbearbeiten k=C3=B6nntest."
+
+msgid "You are in the middle of a merge -- cannot amend."
+msgstr "Du bist mitten in einem Merge; da kannst du nichts nachbearbei=
ten."
+
+msgid "Only one of -c/-C/-F can be used."
+msgstr "Nur eine der Optionen -c/-C/-F kann auf einmal benutzt werden.=
"
+
+msgid "Option -m cannot be combined with -c/-C/-F."
+msgstr "Option -m kann nicht kombiniert werden mit -c/-C/-F."
+
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr "--reset-author kann nur mit -C, -c oder --amend benutzt werden=
=2E"
+
+#, c-format
+msgid "could not lookup commit %s"
+msgstr "konnte Commit %s nicht finden"
+
+#, c-format
+msgid "could not parse commit %s"
+msgstr "konnte Commit %s nicht analysieren"
+
+msgid "Only one of --include/--only/--all/--interactive can be used."
+msgstr ""
+"Nur eins von --include/--only/--all/--interactive kann auf einmal ben=
utzt "
+"werden."
+
+msgid "No paths with --include/--only does not make sense."
+msgstr "F=C3=BCr --include/--only musst du Pfade angeben."
+
+msgid "Clever... amending the last one with dirty index."
+msgstr ""
+"Bearbeite letzten Commit nach, ohne =C3=84nderungen an Dateien zu =C3=
=BCbernehmen."
+
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr ""
+"Pfade angegeben ohne ausdr=C3=BCckliches -i oder -o angegeben, ich ne=
hme -o an..."
+
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr "Ung=C3=BCltiger Aufr=C3=A4ummodus (--cleanup) f=C3=BCr den Com=
mit-Kommentar"
+
+msgid "Paths with -a does not make sense."
+msgstr "Es ist unsinnig, mit -a Pfade anzugeben."
+
+msgid "Paths with --interactive does not make sense."
+msgstr "Es ist unsinnig, Pfade mit --interactive anzugeben."
+
+msgid "couldn't look up newly created commit"
+msgstr "konnte neu angelegten Commit nicht finden"
+
+msgid "could not parse newly created commit"
+msgstr "konnte neu angelegten Commit nicht analysieren"
+
+msgid "detached HEAD"
+msgstr "von HEAD abgetrennt"
+
+msgid " (root-commit)"
+msgstr " (erster Commit)"
+
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr "konnte '%s' nicht zum Lesen =C3=B6ffnen"
+
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr "Besch=C3=A4digte MERGE_HEAD-Datei (%s)"
+
+msgid "could not read MERGE_MODE"
+msgstr "konnte MERGE_MODE nicht auslesen"
+
+#, c-format
+msgid "could not read commit message: %s"
+msgstr "konnte Commit-Kommentar nicht lesen: %s"
+
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr "Commit abgebrochen wegen leerem Kommentar.\n"
+
+msgid "failed to write commit object"
+msgstr "konnte Commit-Objekt nicht anlegen"
+
+msgid "cannot lock HEAD ref"
+msgstr "kann kein Lock f=C3=BCr HEAD-Referenz anfordern"
+
+msgid "cannot update HEAD ref"
+msgstr "kann HEAD-Referenz nicht aktualisieren"
+
+msgid ""
+"Repository has been updated, but unable to write\n"
+"new_index file. Check that disk is not full or quota is\n"
+"not exceeded, and then \"git reset HEAD\" to recover."
+msgstr ""
+"Repository wurde aktualisiert, aber ich kann die new_index-Datei nich=
t\n"
+"anlegen. Stelle sicher, dass der Datentr=C3=A4ger nicht voll ist und =
du deine\n"
+"Limits nicht =C3=BCberschreitest, und benutze \"git reset HEAD\" zum =
Reparieren."
+
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr "'%s': weder normale Datei noch Symlink"
+
+#, c-format
+msgid "invalid option: %s"
+msgstr "ung=C3=BCltige Option: %s"
+
+msgid "Not a git repository"
+msgstr "Kein git-Repository"
+
+msgid "No HEAD commit to compare with (yet)"
+msgstr "Es gibt (noch) keinen HEAD-Commit als Vergleich"
+
+#, c-format
+msgid "invalid object '%s' given."
+msgstr "ung=C3=BCltiges Objekt '%s' angegeben."
+
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr "mehr als %d Trees angegeben: '%s'"
+
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr "mehr als zwei Blobs angegeben: '%s'"
+
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr "nicht unterst=C3=BCtztes Objekt '%s' angegeben."
+
+msgid "Couldn't find remote ref HEAD"
+msgstr "Konnte Remote-Referenz HEAD nicht finden"
+
+#, c-format
+msgid "object %s not found"
+msgstr "Objekt %s nicht gefunden"
+
+msgid "[up to date]"
+msgstr "[aktuell]"
+
+#.
+#. * If this is the head, and it's not okay to update
+#. * the head, and the old value of the head isn't empty...
+#.
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr "! %-*s %-*s -> %s  (kann nicht den aktuellen Branch =C3=BCbers=
chreiben)"
+
+msgid "[rejected]"
+msgstr "[abgewiesen]"
+
+msgid "[tag update]"
+msgstr "[Tag-Update]"
+
+msgid "  (unable to update local ref)"
+msgstr "  (kann lokale Referenz nicht aktualisieren)"
+
+#, c-format
+msgid "cannot open %s: %s\n"
+msgstr "kann %s nicht =C3=B6ffnen: %s\n"
+
+msgid "branch"
+msgstr "Branch"
+
+msgid "tag"
+msgstr "Tag"
+
+msgid "remote branch"
+msgstr "Remote-Branch"
+
+#, c-format
+msgid "From %.*s\n"
+msgstr "Von %.*s\n"
+
+#, c-format
+msgid ""
+"some local refs could not be updated; try running\n"
+" 'git remote prune %s' to remove any old, conflicting branches"
+msgstr ""
+"ein paar lokale Referenzen konnten nicht aktualisiert werden; versuch=
e,\n"
+"alte Branches, die evtl. im Weg sind, mit 'git remote prune %s' zu en=
tfernen"
+
+msgid "could not run rev-list"
+msgstr "konnte rev-list nicht ausf=C3=BChren"
+
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr "konnte Daten nicht an rev-list =C3=BCbergeben: %s"
+
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr "konnte Standardeingabe von rev-list nicht schlie=C3=9Fen: %s"
+
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr "   (%s wird auf nichts mehr zeigen)\n"
+
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr "   (%s zeigt auf nichts mehr)\n"
+
+msgid "[deleted]"
+msgstr "[entfernt]"
+
+msgid "(none)"
+msgstr "(nichts)"
+
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr ""
+"=C3=9Cberschreiben des aktuellen Branches %s in Arbeits-Repository ve=
rweigert"
+
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr "Ich wei=C3=9F nicht, wie man von %s fetchen kann"
+
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr "Option \"%s\" (Wert \"%s\") ist nicht g=C3=BCltig f=C3=BCr %s"
+
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr "Option \"%s\" wird f=C3=BCr %s ignoriert\n"
+
+#, c-format
+msgid "Fetching %s\n"
+msgstr "Hole %s\n"
+
+#, c-format
+msgid "Could not fetch %s"
+msgstr "Konnte %s nicht holen"
+
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr ""
+"Kein Ursprungs-Repository angebene. Bitte gib entweder eine URL oder =
einen\n"
+"Remote-Namen an, um die Quelle f=C3=BCr neu geholte Revisionen festzu=
legen."
+
+msgid "You need to specify a tag name."
+msgstr "Du musst einen Tagnamen angeben."
+
+msgid "fetch --all does not take a repository argument"
+msgstr ""
+"fetch --all akzeptiert keine ausdr=C3=BCckliche Angabe eines Ursprung=
s-Repositorys"
+
+msgid "fetch --all does not make sense with refspecs"
+msgstr "fetch --all ergibt keinen Sinn mit Refspecs"
+
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr "Es gibt keinen Remote %s und auch keine entsprechende Remote-G=
rouppe"
+
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr "Das Holen einer Gruppe unter Angabe von Refspecs ergibt keinen=
 Sinn"
+
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr "grep: konnte Thread nicht anlegen: %s"
+
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr "'%s': kann %s nicht lesen"
+
+#, c-format
+msgid "'%s': %s"
+msgstr "'%s': %s"
+
+# FIXME: ich hab keine Ahnung, worum es hier geht
+#, c-format
+msgid "'%s': short read %s"
+msgstr "'%s': short read %s"
+
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr "Konnte Verzeichnis nicht wechseln: %s"
+
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr "kann Tree nicht lesen (%s)"
+
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr "kann Objekte des Typs %s nicht greppen"
+
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr "Option `%c' ben=C3=B6tigt einen numerischen Wert"
+
+#, c-format
+msgid "cannot open '%s'"
+msgstr "kann '%s' nicht =C3=B6ffnen"
+
+msgid "no pattern given."
+msgstr "kein Suchmuster angegeben."
+
+msgid "cannot mix --fixed-strings and regexp"
+msgstr "kann --fixed-strings nicht mit regul=C3=A4rem Ausdruck kombini=
eren"
+
+#, c-format
+msgid "bad object %s"
+msgstr "ung=C3=BCltiges Objekt %s"
+
+msgid "--open-files-in-pager only works on the worktree"
+msgstr "--open-files-in-pager funktioniert nur im Arbeitsverzeichnis"
+
+msgid "--cached cannot be used with --no-index."
+msgstr "--cached kann nicht mit --no-index kombiniert werden."
+
+msgid "--no-index cannot be used with revs."
+msgstr "--no-index kann nicht mit der Angabe von Revisionen kombiniert=
 werden."
+
+msgid "both --cached and trees are given."
+msgstr "Du hast sowohl --cached als auch Trees angegeben."
+
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Konnte %s nicht f=C3=BCr die Gruppe beschreibbar machen"
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr "irrsinnig langer Vorlagen-Name %s"
+
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "kann '%s' nicht finden/pr=C3=BCfen"
+
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "kann Vorlage '%s' nicht anlegen/pr=C3=BCfen"
+
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "kann Verzeichnis '%s' nicht auslesen"
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "kann Linkziel f=C3=BCr '%s' nicht ermitteln"
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "irrsinnig langer Symlink '%s'"
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "kann '%s' nicht von '%s' aus symlinken"
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "kann '%s'=C2=A0nicht nach '%s' kopieren"
+
+#, c-format
+msgid "ignoring template %s"
+msgstr "ignoriere Vorlage %s"
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr "irrsinnig langer Vorlagen-Pfad %s"
+
+#, c-format
+msgid "templates not found %s"
+msgstr "Vorlagen nicht gefunden: %s"
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "kopiere keine Vorlage in einer falschen Formatversion %d von '=
%s'"
+
+#, c-format
+msgid "insane git directory %s"
+msgstr "irrsinniges git-Verzeichnis %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s git-Repository in %s%s\n"
+
+msgid "Reinitialized existing"
+msgstr "Noch einmal neu initialisiert:"
+
+msgid "Initialized empty"
+msgstr "Neu angelegt:"
+
+msgid " shared"
+msgstr " gemeinsam benutztes"
+
+msgid "cannot tell cwd"
+msgstr "kann aktuelles Verzeichnis nicht ermitteln"
+
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "cann Verzeichnis %s nicht anlegen"
+
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "kann nicht in Verzeichnis %s wechseln"
+
+#, c-format
+msgid ""
+"%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
+"dir=3D<directory>)"
+msgstr ""
+"%s (oder --work-tree=3D<Verzeichnis>) nicht erlaubt ohne %s (oder --g=
it-"
+"dir=3D<Verzeichnis)"
+
+msgid "Cannot access current working directory"
+msgstr "Kann auf aktuelles Verzeichnis nicht zugreifen"
+
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Kann auf Arbeitsverzeichnis '%s' nicht zugreifen"
+
+#, c-format
+msgid "invalid --decorate option: %s"
+msgstr "ung=C3=BCltige '--decorate'-Option: %s"
+
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "ung=C3=BCltiger Parameter: %s"
+
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr "Endg=C3=BCltige Ausgabe: %d %s\n"
+
+msgid "revision walk setup failed"
+msgstr "Einrichtung der Revisionsverfolgung fehlgeschlagen"
+
+#, c-format
+msgid "Could not read object %s"
+msgstr "Konnte Objekt %s nicht lesen"
+
+#, c-format
+msgid "Unknown type: %d"
+msgstr "Unbekannter Typ: %d"
+
+msgid "format.headers without value"
+msgstr "format.headers ohne Wert"
+
+msgid "name of output directory is too long"
+msgstr "Name des Ausgabeverzeichnisses ist zu lang"
+
+#, c-format
+msgid "Cannot open patch file %s"
+msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
+
+msgid "Need exactly one range."
+msgstr "Brauche genau eine Bereichsangabe."
+
+msgid "Not a range."
+msgstr "Keine g=C3=BCltige Bereichsangabe."
+
+msgid "Could not extract email from committer identity."
+msgstr "Konnte E-Mail-Adresse nicht aus der Committer-Angabe entnehmen=
=2E"
+
+msgid ""
+"*** SUBJECT HERE ***\n"
+"\n"
+"*** BLURB HERE ***\n"
+msgstr ""
+"*** BETREFF HIER ***\n"
+"\n"
+"*** DETAILS HIER ***\n"
+
+msgid "Cover letter needs email format"
+msgstr "Begleittext muss im E-Mail-Format sein"
+
+#, c-format
+msgid "insane in-reply-to: %s"
+msgstr "irrsinniges in-reply-to: %s"
+
+msgid "Two output directories?"
+msgstr "Zwei Ausgabeverzeichnisse?"
+
+#, c-format
+msgid "bogus committer info %s"
+msgstr "merkw=C3=BCrdige Committer-Angabe %s"
+
+msgid "-n and -k are mutually exclusive."
+msgstr "-n und -k vertragen sich nicht."
+
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr "--subject-prefix und -k vertragen sich nicht."
+
+msgid "--name-only does not make sense"
+msgstr "--name-only ergibt keinen Sinn"
+
+msgid "--name-status does not make sense"
+msgstr "--name-status ergibt keinen Sinn"
+
+msgid "--check does not make sense"
+msgstr "--check ergibt keinen Sinn"
+
+msgid "standard output, or directory, which one?"
+msgstr "Standardausgabe oder Verzeichnis... entscheide dich!"
+
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr "Konnte Verzeichnis '%s' nicht anlegen"
+
+msgid "Failed to create output files"
+msgstr "Konnte Ausgabedateien nicht anlegen"
+
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr ""
+"Konnte keinen verfolgten Remote-Branch finden, bitte gib <Ursprung> s=
elbst "
+"an.\n"
+
+#, c-format
+msgid "Unknown commit %s"
+msgstr "Unbekannter Commit %s"
+
+msgid "switch `m' requires a value"
+msgstr "Option `m' ben=C3=B6tigt einen Wert"
+
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr "Konnte Merge-Strategie '%s' nicht finden.\n"
+
+#, c-format
+msgid "Available strategies are:"
+msgstr "Verf=C3=BCgbare Strategien sind:"
+
+#, c-format
+msgid "Available custom strategies are:"
+msgstr "Verf=C3=BCgbare benutzerdefinierte Strategien sind:"
+
+msgid "could not run stash."
+msgstr "konnte 'stash' nicht ausf=C3=BChren."
+
+msgid "stash failed"
+msgstr "'stash' fehlgeschlagen"
+
+#, c-format
+msgid "not a valid object: %s"
+msgstr "kein g=C3=BCltiges Object: %s"
+
+msgid "read-tree failed"
+msgstr "read-tree fehlgeschlagen"
+
+msgid " (nothing to squash)"
+msgstr " (nichts zu kombinieren (--squash))"
+
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr "Squash-Commit -- HEAD wird nicht aktualisiert\n"
+
+#, c-format
+msgid "Could not write to '%s'"
+msgstr "Konnte '%s' nicht beschreiben"
+
+msgid "Writing SQUASH_MSG"
+msgstr "Schreibe SQUASH_MSG"
+
+msgid "Finishing SQUASH_MSG"
+msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
+
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr "Kein Merge-Kommentar -- HEAD wird nicht aktualisiert\n"
+
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr "'%s' zeigt nicht auf einen Commit"
+
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr "Ung=C3=BCltiger Wert f=C3=BCr branch.%s.mergeoptions: %s"
+
+msgid "git write-tree failed to write a tree"
+msgstr "'git write-tree' konnte keinen Tree anlegen"
+
+msgid "failed to read the cache"
+msgstr "konnte den Index nicht auslesen"
+
+msgid "Unable to write index."
+msgstr "Konnte den Index nicht anlegen."
+
+msgid "Not handling anything other than two heads merge."
+msgstr "Ich erledige ausschlie=C3=9Flich Merges mit zwei Quellen."
+
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr "Unbekannte Option f=C3=BCr merge-recursive: -X%s"
+
+#, c-format
+msgid "unable to write %s"
+msgstr "konnte %s nicht beschreiben"
+
+#, c-format
+msgid "Wonderful.\n"
+msgstr "Wunderbar.\n"
+
+msgid "In-index merge"
+msgstr "Merge im Index"
+
+#, c-format
+msgid "Merge made by %s."
+msgstr "Merge produziert von '%s'."
+
+#, c-format
+msgid "Could not open '%s' for writing"
+msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen"
+
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr ""
+"Automatischer Merge fehlgeschlagen; behebe die Konflikte und committe=
 das "
+"Ergebnis.\n"
+
+#, c-format
+msgid "'%s' is not a commit"
+msgstr "'%s' ist kein Commit"
+
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
+"Bitte committe deine =C3=84nderungen, bevor du einen weiteren Merge s=
tartest."
+
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr "Du hast deinen Merge nicht abgeschlossen (MERGE_HEAD existiert=
)."
+
+msgid "You cannot combine --squash with --no-ff."
+msgstr "Du kannst --squash nicht mit --no-ff kombinieren."
+
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr "Du kannst --no-ff nicht mit --ff-only kombinieren (wirklich wa=
hr)."
+
+# Die Originalumschreibung "exactly one commit" ist irref=C3=BChrend; =
es geht
+# nat=C3=BCrlich um die gesamte History hinter diesem Commit
+msgid "Can merge only exactly one commit into empty head"
+msgstr "Kann nur exakt eine Historie in einen leeren Branch mergen"
+
+msgid "Squash commit into empty head not supported yet"
+msgstr "Squash-Commit in leeren Branch wird noch nicht unterst=C3=BCtz=
t"
+
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr "Das Erzwingen eines Merge-Commits in einem leeren Branch ist u=
nsinnig"
+
+#, c-format
+msgid "%s - not something we can merge"
+msgstr "%s ist etwas, das wir nicht mergen k=C3=B6nnen"
+
+#.
+#. * If head can reach all the merge then we are up to date.
+#. * but first the most common case of merging one remote.
+#.
+msgid "Already up-to-date."
+msgstr "Bereits aktuell."
+
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr "Aktualisiere %s..%s\n"
+
+msgid "Fast-forward"
+msgstr "Update ohne Merge"
+
+msgid " (no commit created; -m option ignored)"
+msgstr " (kein Commit angelegt; -m ignoriert)"
+
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr "Probiere simplen Merge im Index...\n"
+
+#, c-format
+msgid "Nope.\n"
+msgstr "N=C3=B6.\n"
+
+msgid "Already up-to-date. Yeeah!"
+msgstr "Bereits aktuell. Juchu!"
+
+msgid "Not possible to fast-forward, aborting."
+msgstr "Kann nicht ohne Merge-Commit aktualisieren, breche ab."
+
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr "R=C3=A4ume auf...\n"
+
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr "Probiere Merge-Strategie %s...\n"
+
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr "Keine Merge-Strategie hat den Merge erledigt.\n"
+
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr "Merge mit Strategie '%s' fehlgeschlagen.\n"
+
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr "Benutze Strategie '%s', um auf manuelle Aufl=C3=B6sung vorzube=
reiten.\n"
+
+#, c-format
+msgid "Automatic merge went well; stopped before committing as request=
ed\n"
+msgstr ""
+"Automatischer Merge hat gut funktioniert; warte wie gew=C3=BCnscht vo=
r dem "
+"Commit\n"
+
+#, c-format
+msgid "Checking rename of '%s' to '%s'\n"
+msgstr "Pr=C3=BCfe Umbenennen von '%s' nach '%s'\n"
+
+msgid "bad source"
+msgstr "ung=C3=BCltige Quelle"
+
+msgid "can not move directory into itself"
+msgstr "kann ein Verzeichnis nicht in sich selbst verschieben"
+
+msgid "cannot move directory over file"
+msgstr "kann Verzeichnis nicht an die Stelle einer Datei verschieben"
+
+#, c-format
+msgid "Huh? %.*s is in index?"
+msgstr "H=C3=A4? %.*s ist im Index?"
+
+msgid "source directory is empty"
+msgstr "Quellverzeichnis ist leer"
+
+msgid "not under version control"
+msgstr "nicht unter Versionskontrolle"
+
+msgid "destination exists"
+msgstr "Ziel existiert schon"
+
+#, c-format
+msgid "%s; will overwrite!"
+msgstr "%s; werde =C3=BCberschreiben!"
+
+msgid "Cannot overwrite"
+msgstr "Kann nicht =C3=BCberschreiben"
+
+msgid "multiple sources for the same target"
+msgstr "mehrere Quellen f=C3=BCr das gleiche Ziel"
+
+#, c-format
+msgid "%s, source=3D%s, destination=3D%s"
+msgstr "%s, Quelle=3D%s, Ziel=3D%s"
+
+#, c-format
+msgid "Renaming %s to %s\n"
+msgstr "Benenne %s um nach %s\n"
+
+#, c-format
+msgid "renaming '%s' failed"
+msgstr "Umbenennen von '%s' fehlgeschlagen"
+
+msgid "tag shorthand without <tag>"
+msgstr "'tag'-Kurzschreibweise ohne <Tag>"
+
+msgid "--delete only accepts plain target ref names"
+msgstr "--delete akzeptiert nur einfache Referenzen, keine Refspecs"
+
+msgid "You are not currently on a branch."
+msgstr "Es ist momentan kein Branch aktiv."
+
+#, c-format
+msgid "The current branch %s is not tracking anything."
+msgstr "Der aktuelle Branch %s verfolgt keinen Branch."
+
+#, c-format
+msgid "The current branch %s is tracking multiple branches, refusing t=
o push."
+msgstr "Der aktuelle Branch %s verfolgt mehrere Branches, 'push' verwe=
igert."
+
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr ""
+"Du hast keine Refspecs angegeben und push.default ist auf 'nothing' g=
esetzt."
+
+#, c-format
+msgid "Pushing to %s\n"
+msgstr "=C3=9Cbertrag zu %s\n"
+
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr "=C3=9Cbertragen einiger Referenzen zu '%s' fehlgeschlagen"
+
+# TODO: Verweis auf Manpage aktualisieren, sobald wir die auch =C3=BCb=
ersetzen
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+"Um zu verhindern, dass du Daten verlierst, wurden Updates, die einen\=
n"
+"Merge-Commit erfordern, zur=C3=BCckgewiesen. Merge die =C3=84nderunge=
n im\n"
+"im Ursprungs-Repository (z.B. 'git pull'), bevor du es nochmal versuc=
hst.\n"
+"Siehe den Abschnitt 'Note about fast-forwards' von 'git push --help' =
f=C3=BCr\n"
+"mehr Informationen.\n"
+
+#, c-format
+msgid "bad repository '%s'"
+msgstr "ung=C3=BCltiges Repository '%s'"
+
+msgid "No destination configured to push to."
+msgstr "Kein Ziel f=C3=BCr 'push' festgelegt."
+
+msgid "--all and --tags are incompatible"
+msgstr "--all und --tags vertragen sich nicht"
+
+msgid "--all can't be combined with refspecs"
+msgstr "--all kann nicht mit Refspecs kombiniert werden"
+
+msgid "--mirror and --tags are incompatible"
+msgstr "--mirror und --tags vertragen sich nicht"
+
+msgid "--mirror can't be combined with refspecs"
+msgstr "--mirror kann nicht mit Refspecs kombiniert werden"
+
+msgid "--all and --mirror are incompatible"
+msgstr "--all und --mirror vertragen sich nicht"
+
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr "--delete vertr=C3=A4gt sich nicht mit --all, --mirror und --ta=
gs"
+
+msgid "--delete doesn't make sense without any refs"
+msgstr "--delete ergibt keinen Sinn ohne Angabe von Referenzen"
+
+# Originalwerte f=C3=BCr diese Strings belassen wg. =C3=9Cbereinstimmu=
ng mit
+# Optionsnamen
+msgid "mixed"
+msgstr ""
+
+msgid "soft"
+msgstr ""
+
+msgid "hard"
+msgstr ""
+
+msgid "merge"
+msgstr ""
+
+msgid "keep"
+msgstr ""
+
+msgid "You do not have a valid HEAD."
+msgstr "Du hast kein g=C3=BCltiges HEAD."
+
+msgid "Failed to find tree of HEAD."
+msgstr "Konnte Tree von HEAD nicht finden."
+
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr "Konnte Tree von %s nicht finden."
+
+msgid "Could not write new index file."
+msgstr "Konnte neue Indexdatei nicht anlegen."
+
+#, c-format
+msgid "HEAD is now at %s"
+msgstr "HEAD ist jetzt bei %s"
+
+msgid "Could not read index"
+msgstr "Konnte den Index nicht auslesen"
+
+msgid "Unstaged changes after reset:"
+msgstr "Nicht vorgemerkte =C3=84nderungen nach Reset:"
+
+#, c-format
+msgid "Reflog action message too long: %.*s..."
+msgstr "Aktionsbeschreibung im Reflog zu lang: %.*s..."
+
+#, c-format
+msgid "Cannot do a %s reset in the middle of a merge."
+msgstr "Kann keinen '%s'-Reset mitten in einem Merge machen."
+
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
+
+#, c-format
+msgid "Could not parse object '%s'."
+msgstr "Konnte Objekt '%s' nicht einlesen."
+
+msgid "--patch is incompatible with --{hard,mixed,soft}"
+msgstr "--patch vertr=C3=A4gt sich nicht mit --{hard,mixed,soft}"
+
+msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
+msgstr ""
+"--mixed mit Pfaden ist veraltet; benutze stattdessen 'git reset -- <P=
fade>'."
+
+#, c-format
+msgid "Cannot do %s reset with paths."
+msgstr "Kann keinen '%s'-Reset mit Pfadangaben durchf=C3=BChren."
+
+#, c-format
+msgid "%s reset is not allowed in a bare repository"
+msgstr "'%s'-Reset ist in einem Lager-Repository nicht erlaubt"
+
+#, c-format
+msgid "Could not reset index file to revision '%s'."
+msgstr "Konnte Indexdatei nicht auf Revision '%s' zur=C3=BCcksetzen."
+
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+"'%s' hat vorgemerkte =C3=84nderungen, die sich sowohl von der Datei\n=
"
+"als auch vom letzten Commit unterscheiden (-f, um trotzdem zu l=C3=B6=
schen)"
+
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"'%s' hat =C3=84nderungen im Index vorgemerkt\n"
+"(--cached, um die Datei zu behalten, oder -f, um trotzdem zu l=C3=B6s=
chen)"
+
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"'%s' hat =C3=84nderungen im Arbeitsverzeichnis\n"
+"(--cached, um die Datei zu behalten, oder -f, um trotzdem zu l=C3=B6s=
chen)"
+
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr "entferne Verzeichnis '%s' nicht rekursiv ohne -r"
+
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr "git rm: kann %s nicht entfernen"
+
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr "Tagname zu lang: %.*s..."
+
+#, c-format
+msgid "tag '%s' not found."
+msgstr "Tag '%s' nicht gefunden."
+
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr "Tag '%s' gel=C3=B6scht (war %s)\n"
+
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr "konnte den Tag '%s' nicht =C3=BCberpr=C3=BCfen"
+
+msgid "committer info too long."
+msgstr "Committer-Angabe zu lang."
+
+msgid "could not run gpg."
+msgstr "konnte gpg nicht ausf=C3=BChren."
+
+msgid "gpg did not accept the tag data"
+msgstr "gpg hat die Tag-Daten nicht angenommen"
+
+msgid "gpg failed to sign the tag"
+msgstr "gpg konnte den Tag nicht signieren"
+
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"#\n"
+msgstr ""
+"\n"
+"#\n"
+"# Schreibe einen Tag-Kommentar\n"
+"#\n"
+
+#, c-format
+msgid "signing key value too long (%.10s...)"
+msgstr "Wert f=C3=BCr Signatur-Key zu lang (%.10s...)"
+
+msgid "unable to sign the tag"
+msgstr "kann den Tag nicht signieren"
+
+msgid "unable to write tag file"
+msgstr "kann die Tag-Datei nicht anlegen"
+
+msgid "bad object type."
+msgstr "ung=C3=BCltiger Objekttyp."
+
+msgid "tag header too big."
+msgstr "Tag-Header zu gro=C3=9F."
+
+#, c-format
+msgid "could not create file '%s'"
+msgstr "konnte Datei '%s' nicht anlegen"
+
+msgid "no tag message?"
+msgstr "kein Tag-Kommentar?"
+
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr "Der Tag-Kommentar wurde nach %s gesichert\n"
+
+msgid "-n option is only allowed with -l."
+msgstr "-n ist nur in Kombination mit -l erlaubt."
+
+msgid "--contains option is only allowed with -l."
+msgstr "--contains ist nur in Kombination mit -l erlaubt."
+
+msgid "only one -F or -m option is allowed."
+msgstr "entweder -F oder -m -- entscheide dich."
+
+#, c-format
+msgid "cannot read '%s'"
+msgstr "kann '%s' nicht auslesen"
+
+#, c-format
+msgid "could not open or read '%s'"
+msgstr "kann '%s' nicht =C3=B6ffnen oder auslesen"
+
+msgid "too many params"
+msgstr "zu viele Parameter"
+
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr "'%s' ist kein g=C3=BCltiger Tagname."
+
+#, c-format
+msgid "tag '%s' already exists"
+msgstr "Tag '%s' existiert schon"
+
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr "%s: kann kein Lock f=C3=BCr die Referenz anfordern"
+
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr "%s: kann die Referenz nicht aktualisieren"
+
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr "Tag '%s' aktualisiert (war %s)\n"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A C test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: Hello World!"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A Shell test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+msgid "TEST: A Perl test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr ""
--=20
1.7.2.2.336.g704fc
