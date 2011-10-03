From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/9] po/sv.po: add Swedish translation
Date: Mon,  3 Oct 2011 18:58:14 +0000
Message-ID: <1317668297-2702-7-git-send-email-avarab@gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?Marcin=20Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 20:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnji-0005Y3-Ed
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab1JCS7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 14:59:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50138 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab1JCS7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:59:30 -0400
Received: by eya28 with SMTP id 28so3121204eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=r9v7MhEFR7iEJ9IlhOXNTP6tkHet6RqqpEO1sCRl11g=;
        b=uC7uS6CEr9EwzhsZ/Ymr//YowPeDmR7lHJylbv+BVYJyx7cjUY7NIreWDD9SNDpDkM
         LCUaowm3JO/VwbgbOldi3o/nypIas5QvZJd2ZAFp9qS+jZ1kXfxeP4JBderILk/GEuX4
         q63L6MMI6MadbFdTMEoa6j44cjFQNyZlrHprk=
Received: by 10.223.41.153 with SMTP id o25mr334981fae.79.1317668367428;
        Mon, 03 Oct 2011 11:59:27 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id f25sm22312819faf.7.2011.10.03.11.59.26
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:59:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182690>

=46rom: Peter Krefting <peter@softwolves.pp.se>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/sv.po | 3626 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 3626 insertions(+), 0 deletions(-)
 create mode 100644 po/sv.po

diff --git a/po/sv.po b/po/sv.po
new file mode 100644
index 0000000..3c651cf
--- /dev/null
+++ b/po/sv.po
@@ -0,0 +1,3626 @@
+# Swedish translations for Git.
+# Copyright (C) 2010 Peter krefting <peter@softwolves.pp.se>
+# This file is distributed under the same license as the Git package.
+# Peter krefting <peter@softwolves.pp.se>, 2010.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git 1.7.3\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2011-07-06 19:20+0000\n"
+"PO-Revision-Date: 2010-09-12 21:07+0100\n"
+"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
+"Language: sv\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+#: diff.c:104
+#, c-format
+msgid "  Failed to parse dirstat cut-off percentage '%.*s'\n"
+msgstr ""
+
+#: diff.c:109
+#, fuzzy, c-format
+msgid "  Unknown dirstat parameter '%.*s'\n"
+msgstr "kan inte ta status p=C3=A5 mallen \"%s\""
+
+#: diff.c:205
+#, c-format
+msgid ""
+"Found errors in 'diff.dirstat' config variable:\n"
+"%s"
+msgstr ""
+
+#: diff.c:3295
+#, c-format
+msgid ""
+"Failed to parse --dirstat/-X option parameter:\n"
+"%s"
+msgstr ""
+
+#: wt-status.c:134
+#, fuzzy
+msgid "Unmerged paths:"
+msgstr "# Ej sammanslagna s=C3=B6kv=C3=A4gar:"
+
+#: wt-status.c:140 wt-status.c:157
+#, fuzzy, c-format
+msgid "  (use \"git reset %s <file>...\" to unstage)"
+msgstr "#   (anv=C3=A4nd \"git reset %s <fil>...\" f=C3=B6r att ta bor=
t fr=C3=A5n k=C3=B6)"
+
+#: wt-status.c:142 wt-status.c:159
+#, fuzzy
+msgid "  (use \"git rm --cached <file>...\" to unstage)"
+msgstr "#   (anv=C3=A4nd \"git rm --cached <fil>...\" f=C3=B6r att ta =
bort fr=C3=A5n k=C3=B6)"
+
+#: wt-status.c:143
+#, fuzzy
+msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
+msgstr "#   (anv=C3=A4nd \"git add/rm <fil>...\" som l=C3=A4mpligt f=C3=
=B6r att ange l=C3=B6sning)"
+
+#: wt-status.c:151
+#, fuzzy
+msgid "Changes to be committed:"
+msgstr "# =C3=84ndringar att checka in:"
+
+#: wt-status.c:169
+#, fuzzy
+msgid "Changes not staged for commit:"
+msgstr "# =C3=84ndringar att checka in:"
+
+#: wt-status.c:173
+#, fuzzy
+msgid "  (use \"git add <file>...\" to update what will be committed)"
+msgstr ""
+"#   (anv=C3=A4nd \"git add <fil>...\" f=C3=B6r att uppdatera vad som =
skall checkas in)"
+
+#: wt-status.c:175
+#, fuzzy
+msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
+msgstr ""
+"#   (anv=C3=A4nd \"git add/rm <fil>...\" f=C3=B6r att uppdatera vad s=
om skall checkas "
+"in)"
+
+#: wt-status.c:176
+#, fuzzy
+msgid ""
+"  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
+msgstr ""
+"#   (anv=C3=A4nd \"git checkout -- <fil>...\" f=C3=B6r att f=C3=B6rka=
sta =C3=A4ndringar i "
+"arbetskatalogen)"
+
+#: wt-status.c:178
+#, fuzzy
+msgid "  (commit or discard the untracked or modified content in submo=
dules)"
+msgstr ""
+"#   (checka in eller f=C3=B6rkasta osp=C3=A5rat eller =C3=A4ndrat inn=
eh=C3=A5ll i undermoduler)"
+
+#: wt-status.c:187
+#, fuzzy, c-format
+msgid "%s files:"
+msgstr "# %s filer:"
+
+#: wt-status.c:190
+#, fuzzy, c-format
+msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
+msgstr ""
+"#   (anv=C3=A4nd \"git %s <fil>...\" f=C3=B6r att ta med i vad som sk=
all checkas in)"
+
+#: wt-status.c:207
+msgid "bug"
+msgstr "programfel"
+
+#: wt-status.c:212
+msgid "both deleted:"
+msgstr "borttaget av b=C3=A4gge:"
+
+#: wt-status.c:213
+msgid "added by us:"
+msgstr "tillagt av oss:"
+
+#: wt-status.c:214
+msgid "deleted by them:"
+msgstr "borttaget av dem:"
+
+#: wt-status.c:215
+msgid "added by them:"
+msgstr "tillagt av dem:"
+
+#: wt-status.c:216
+msgid "deleted by us:"
+msgstr "borttaget av oss:"
+
+#: wt-status.c:217
+msgid "both added:"
+msgstr "tillagt av b=C3=A4gge:"
+
+#: wt-status.c:218
+msgid "both modified:"
+msgstr "=C3=A4ndrat av b=C3=A4gge:"
+
+#: wt-status.c:248
+msgid "new commits, "
+msgstr "nya incheckningar, "
+
+#: wt-status.c:250
+msgid "modified content, "
+msgstr "=C3=A4ndrat inneh=C3=A5ll, "
+
+#: wt-status.c:252
+msgid "untracked content, "
+msgstr "osp=C3=A5rat inneh=C3=A5ll, "
+
+#: wt-status.c:266
+#, c-format
+msgid "new file:   %s"
+msgstr "ny fil:     %s"
+
+#: wt-status.c:269
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr "kopierad:   %s -> %s"
+
+#: wt-status.c:272
+#, c-format
+msgid "deleted:    %s"
+msgstr "borttagen:  %s"
+
+#: wt-status.c:275
+#, c-format
+msgid "modified:   %s"
+msgstr "=C3=A4ndrad:     %s"
+
+#: wt-status.c:278
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr "namnbyte:   %s -> %s"
+
+#: wt-status.c:281
+#, c-format
+msgid "typechange: %s"
+msgstr "typbyte:    %s"
+
+#: wt-status.c:284
+#, c-format
+msgid "unknown:    %s"
+msgstr "ok=C3=A4nd:      %s"
+
+#: wt-status.c:287
+#, c-format
+msgid "unmerged:   %s"
+msgstr "osammansl.: %s"
+
+#: wt-status.c:290
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr "programfel: diff-status %c ej hanterad"
+
+#: wt-status.c:713
+msgid "On branch "
+msgstr "P=C3=A5 grenen "
+
+#: wt-status.c:720
+msgid "Not currently on any branch."
+msgstr "Inte p=C3=A5 n=C3=A5gon gren f=C3=B6r n=C3=A4rvarande."
+
+#: wt-status.c:731
+#, fuzzy
+msgid "Initial commit"
+msgstr "# Grundincheckning"
+
+#: wt-status.c:745
+msgid "Untracked"
+msgstr "Osp=C3=A5rad"
+
+#: wt-status.c:747
+msgid "Ignored"
+msgstr "Ignorerad"
+
+#: wt-status.c:749
+#, fuzzy, c-format
+msgid "Untracked files not listed%s"
+msgstr "# Osp=C3=A5rade filer visas ej%s\n"
+
+#: wt-status.c:751
+msgid " (use -u option to show untracked files)"
+msgstr " (anv=C3=A4nd flaggan -u f=C3=B6r att visa osp=C3=A5rade filer=
)"
+
+#: wt-status.c:757
+#, fuzzy
+msgid "No changes"
+msgstr "# Inga =C3=A4ndringar\n"
+
+#: wt-status.c:761
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr "inga =C3=A4ndringar att checka in%s\n"
+
+#: wt-status.c:763
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr " (anv=C3=A4nd \"git add\" och/eller \"git commit -a\")"
+
+#: wt-status.c:765
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr "inget k=C3=B6at f=C3=B6r incheckning, men osp=C3=A5rade filer =
finns%s\n"
+
+#: wt-status.c:767
+msgid " (use \"git add\" to track)"
+msgstr " (anv=C3=A4nd \"git add\" f=C3=B6r att sp=C3=A5ra)"
+
+#: wt-status.c:769 wt-status.c:772 wt-status.c:775
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr "inget att checka in%s\n"
+
+#: wt-status.c:770
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr " (skapa/kopiera filer och anv=C3=A4nd \"git add\" f=C3=B6r att=
 sp=C3=A5ra)"
+
+#: wt-status.c:773
+msgid " (use -u to show untracked files)"
+msgstr " (anv=C3=A4nd -u f=C3=B6r att visa osp=C3=A5rade filer)"
+
+#: wt-status.c:776
+msgid " (working directory clean)"
+msgstr " (arbetskatalogen ren)"
+
+#: wt-status.c:884
+msgid "HEAD (no branch)"
+msgstr "HEAD (ingen gren)"
+
+#: wt-status.c:890
+msgid "Initial commit on "
+msgstr "Grundincheckning p=C3=A5 "
+
+#: wt-status.c:905
+msgid "behind "
+msgstr "efter "
+
+#: wt-status.c:908 wt-status.c:911
+msgid "ahead "
+msgstr "f=C3=B6re "
+
+#: wt-status.c:913
+msgid ", behind "
+msgstr ", efter "
+
+#: builtin/add.c:61
+#, c-format
+msgid "unexpected diff status %c"
+msgstr "diff-status %c f=C3=B6rv=C3=A4ntades inte"
+
+#: builtin/add.c:66 builtin/commit.c:291
+msgid "updating files failed"
+msgstr "misslyckades uppdatera filer"
+
+#: builtin/add.c:76
+#, c-format
+msgid "remove '%s'\n"
+msgstr "ta bort \"%s\"\n"
+
+#: builtin/add.c:175
+#, c-format
+msgid "Path '%s' is in submodule '%.*s'"
+msgstr "S=C3=B6kv=C3=A4gen \"%s\" =C3=A4r i undermodulen \"%.*s\""
+
+#: builtin/add.c:191
+msgid "Unstaged changes after refreshing the index:"
+msgstr "Osp=C3=A5rade =C3=A4ndringar efter att ha uppdaterat indexet:"
+
+#: builtin/add.c:194 builtin/add.c:454 builtin/rm.c:186
+#, c-format
+msgid "pathspec '%s' did not match any files"
+msgstr "s=C3=B6kv=C3=A4gsangivelsen \"%s\" motsvarade inte n=C3=A5gra =
filer"
+
+#: builtin/add.c:208
+#, c-format
+msgid "'%s' is beyond a symbolic link"
+msgstr "\"%s\" =C3=A4r p=C3=A5 andra sidan av en symbolisk l=C3=A4nk"
+
+#: builtin/add.c:275
+msgid "Could not read the index"
+msgstr "Kunde inte l=C3=A4sa indexet"
+
+#: builtin/add.c:284
+#, c-format
+msgid "Could not open '%s' for writing."
+msgstr "Kunde inte =C3=B6ppna \"%s\" f=C3=B6r skrivning"
+
+#: builtin/add.c:288
+msgid "Could not write patch"
+msgstr "Kunde inte skriva patch"
+
+#: builtin/add.c:293
+#, c-format
+msgid "Could not stat '%s'"
+msgstr "Kunde inte ta status p=C3=A5 \"%s\""
+
+#: builtin/add.c:295
+msgid "Empty patch. Aborted."
+msgstr "Tom patch. Avbryter."
+
+#: builtin/add.c:301
+#, c-format
+msgid "Could not apply '%s'"
+msgstr "Kunde inte applicera \"%s\""
+
+#: builtin/add.c:310
+msgid "The following paths are ignored by one of your .gitignore files=
:\n"
+msgstr ""
+
+#: builtin/add.c:350
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr "Anv=C3=A4nd -f om du verkligen vill l=C3=A4gga till dem.\n"
+
+#: builtin/add.c:351
+msgid "no files added"
+msgstr "inga filer har lagts till"
+
+#: builtin/add.c:357
+msgid "adding files failed"
+msgstr "misslyckades l=C3=A4gga till filer"
+
+#: builtin/add.c:389
+msgid "-A and -u are mutually incompatible"
+msgstr "-A och -u =C3=A4r =C3=B6msesidigt inkompatibla"
+
+#: builtin/add.c:391
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr "Flaggan --ignore-missing kan endast anv=C3=A4ndas tillsammans =
med --dry-run"
+
+#: builtin/add.c:411
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr "Inget angivet, inget tillagt.\n"
+
+#: builtin/add.c:412
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr "Kanske menade du att skriva \"git add .\"?\n"
+
+#: builtin/add.c:418 builtin/clean.c:95 builtin/commit.c:350 builtin/m=
v.c:77
+#: builtin/rm.c:162
+msgid "index file corrupt"
+msgstr "indexfilen trasig"
+
+#: builtin/add.c:470 builtin/mv.c:223 builtin/rm.c:260
+msgid "Unable to write new index file"
+msgstr "Kunde inte skriva ny indexfil"
+
+#: builtin/archive.c:17
+#, c-format
+msgid "could not create archive file '%s'"
+msgstr "Kunde inte skapa arkivfilen \"%s\""
+
+#: builtin/archive.c:20
+msgid "could not redirect output"
+msgstr "kunde inte omdirigera utdata"
+
+#: builtin/archive.c:36
+msgid "git archive: Remote with no URL"
+msgstr "git archive: Fj=C3=A4rr utan URL"
+
+#: builtin/archive.c:46
+msgid "git archive: expected ACK/NAK, got EOF"
+msgstr "git archive: f=C3=B6rv=C3=A4ntade ACK/NAK, fick EOF"
+
+#: builtin/archive.c:51
+#, c-format
+msgid "git archive: NACK %s"
+msgstr "git archive: NACK %s"
+
+#: builtin/archive.c:52
+msgid "git archive: protocol error"
+msgstr "git archive: protokollfel"
+
+#: builtin/archive.c:57
+msgid "git archive: expected a flush"
+msgstr "git archive: f=C3=B6rv=C3=A4ntade en t=C3=B6mning (flush)"
+
+#: builtin/branch.c:136
+#, fuzzy, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but not yet merged to HEAD."
+msgstr ""
+"tar bort grenen \"%s\" som inte har slagits ihop med\n"
+"         \"%s\", men som =C3=A4nnu inte slagits ihop med HEAD."
+
+#: builtin/branch.c:140
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+"tar inte bort grenen \"%s\" som inte har slagits ihop med\n"
+"         \"%s\", trots att den har slagits ihop med HEAD."
+
+#. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
+#: builtin/branch.c:161
+msgid "remote "
+msgstr "fj=C3=A4rr"
+
+#: builtin/branch.c:169
+msgid "cannot use -a with -d"
+msgstr "kan inte ange -a med -d"
+
+#: builtin/branch.c:175
+msgid "Couldn't look up commit object for HEAD"
+msgstr "Kunde inte sl=C3=A5 upp incheckningsobjekt f=C3=B6r HEAD"
+
+#: builtin/branch.c:180
+#, c-format
+msgid "Cannot delete the branch '%s' which you are currently on."
+msgstr "Kan inte ta bort grenen \"%s\" som du befinner dig p=C3=A5 f=C3=
=B6r n=C3=A4rvarande."
+
+#: builtin/branch.c:190
+#, c-format
+msgid "%sbranch '%s' not found."
+msgstr "%sgrenen \"%s\" hittades inte."
+
+#: builtin/branch.c:198
+#, c-format
+msgid "Couldn't look up commit object for '%s'"
+msgstr "Kunde inte sl=C3=A5 upp incheckningsobjekt f=C3=B6r \"%s\""
+
+#: builtin/branch.c:204
+#, c-format
+msgid ""
+"The branch '%s' is not fully merged.\n"
+"If you are sure you want to delete it, run 'git branch -D %s'."
+msgstr ""
+"Grenen \"%s\" har inte slagits samman i sin helhet.\n"
+"Om du =C3=A4r s=C3=A4ker p=C3=A5 att du vill ta bort den, k=C3=B6r \"=
git branch -D %s\"."
+
+#: builtin/branch.c:212
+#, c-format
+msgid "Error deleting %sbranch '%s'"
+msgstr "Fel vid borttagning av %sgrenen \"%s\""
+
+#: builtin/branch.c:217
+#, c-format
+msgid "Deleted %sbranch %s (was %s).\n"
+msgstr "Tog bort %sgrenen %s (var %s).\n"
+
+#: builtin/branch.c:222
+msgid "Update of config-file failed"
+msgstr "Misslyckades uppdatera konfigurationsfil"
+
+#: builtin/branch.c:304
+#, c-format
+msgid "branch '%s' does not point at a commit"
+msgstr "grenen \"%s\" pekar inte p=C3=A5 en incheckning"
+
+#: builtin/branch.c:376
+#, c-format
+msgid "behind %d] "
+msgstr "bakom %d] "
+
+#: builtin/branch.c:378
+#, c-format
+msgid "ahead %d] "
+msgstr "f=C3=B6re %d] "
+
+#: builtin/branch.c:380
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr "f=C3=B6re %d, bakom %d] "
+
+#: builtin/branch.c:483
+msgid "(no branch)"
+msgstr "(ingen gren)"
+
+#: builtin/branch.c:543
+msgid "some refs could not be read"
+msgstr "vissa referenser kunde inte l=C3=A4sas"
+
+#: builtin/branch.c:556
+msgid "cannot rename the current branch while not on any."
+msgstr ""
+"kunde inte byta namn p=C3=A5 aktuell gren n=C3=A4r du inte befinner d=
ig p=C3=A5 n=C3=A5gon."
+
+#: builtin/branch.c:566 builtin/branch.c:570
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr "Felaktigt namn p=C3=A5 gren: \"%s\""
+
+#: builtin/branch.c:573
+#, c-format
+msgid "A branch named '%s' already exists."
+msgstr "Det finns redan en gren som heter \"%s\""
+
+#: builtin/branch.c:579
+msgid "Branch rename failed"
+msgstr "Misslyckades byta namn p=C3=A5 gren"
+
+#: builtin/branch.c:583
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr "Bytte bort namn p=C3=A5 en felaktigt namngiven gren \"%s\""
+
+#: builtin/branch.c:587
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr "Grenen namnbytt till %s, men HEAD har inte uppdaterats!"
+
+#: builtin/branch.c:594
+msgid "Branch is renamed, but update of config-file failed"
+msgstr "Grenen namnbytt, men misslyckades uppdatera konfigurationsfile=
n"
+
+#: builtin/branch.c:609
+#, c-format
+msgid "malformed object name %s"
+msgstr "felformat objektnamn %s"
+
+#: builtin/branch.c:683
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr "Misslyckades sl=C3=A5 upp HEAD som giltig referens"
+
+#: builtin/branch.c:689
+msgid "HEAD not found below refs/heads!"
+msgstr "HEAD hittades inte under refs/heads!"
+
+#: builtin/branch.c:709
+msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
+msgstr ""
+"flaggorna -a och -r p=C3=A5 \"git branch\" kan inte anges tillsammans=
 med ett "
+"grennamn"
+
+#: builtin/bundle.c:47
+#, c-format
+msgid "%s is okay\n"
+msgstr "%s =C3=A4r okej\n"
+
+#: builtin/bundle.c:56
+msgid "Need a repository to create a bundle."
+msgstr "Beh=C3=B6ver ett arkiv f=C3=B6r att skapa ett paket (bundle)."
+
+#: builtin/bundle.c:60
+msgid "Need a repository to unbundle."
+msgstr "Beh=C3=B6ver ett arkiv f=C3=B6r att packa upp ett paket (bundl=
e)."
+
+#: builtin/checkout.c:111 builtin/checkout.c:139
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte v=C3=A5r version"
+
+#: builtin/checkout.c:113 builtin/checkout.c:141
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte deras version"
+
+#: builtin/checkout.c:124
+#, c-format
+msgid "path '%s' does not have all three versions"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte alla tre versionerna"
+
+#: builtin/checkout.c:159
+#, c-format
+msgid "path '%s' does not have all 3 versions"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte alla 3 versionerna"
+
+#: builtin/checkout.c:176
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr "s=C3=B6kv=C3=A4g \"%s\": kan inte sl=C3=A5 ihop"
+
+#: builtin/checkout.c:193
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr "Kunde inte l=C3=A4gga till sammanslagningsresultat f=C3=B6r \"=
%s\""
+
+#: builtin/checkout.c:198 builtin/reset.c:170
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr "make_cache_entry misslyckades f=C3=B6r s=C3=B6kv=C3=A4gen \"%s=
\""
+
+#: builtin/checkout.c:220 builtin/checkout.c:374
+msgid "corrupt index file"
+msgstr "indexfilen =C3=A4r trasig"
+
+#: builtin/checkout.c:248 builtin/checkout.c:255
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte slagits ihop"
+
+#: builtin/checkout.c:284 builtin/checkout.c:478 builtin/clone.c:668
+#: builtin/merge.c:789
+msgid "unable to write new index file"
+msgstr "kunde inte skriva ny indexfil"
+
+#: builtin/checkout.c:301 builtin/diff.c:301 builtin/merge.c:396
+msgid "diff_setup_done failed"
+msgstr "diff_setup_done misslyckades"
+
+#: builtin/checkout.c:396
+msgid "you need to resolve your current index first"
+msgstr "du m=C3=A5ste l=C3=B6sa ditt befintliga index f=C3=B6rst"
+
+#: builtin/checkout.c:527
+#, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr "Kan inte skapa referenslog f=C3=B6r \"%s\"\n"
+
+#: builtin/checkout.c:557
+msgid "HEAD is now at"
+msgstr "HEAD =C3=A4r nu p=C3=A5"
+
+#: builtin/checkout.c:563
+#, c-format
+msgid "Already on '%s'\n"
+msgstr "Redan p=C3=A5 \"%s\"\n"
+
+#: builtin/checkout.c:567
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr "V=C3=A4xlade till och nollst=C3=A4llde grenen \"%s\"\n"
+
+#: builtin/checkout.c:569
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr "V=C3=A4xlade till en ny gren \"%s\"\n"
+
+#: builtin/checkout.c:571
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr "V=C3=A4xlade till grenen \"%s\"\n"
+
+#: builtin/checkout.c:651
+#, c-format
+msgid " ... and %d more.\n"
+msgstr ""
+
+#. The singular version
+#: builtin/checkout.c:657
+#, c-format
+msgid ""
+"Warning: you are leaving %d commit behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgid_plural ""
+"Warning: you are leaving %d commits behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgstr[0] ""
+msgstr[1] ""
+
+#: builtin/checkout.c:675
+#, c-format
+msgid ""
+"If you want to keep them by creating a new branch, this may be a good=
 time\n"
+"to do so with:\n"
+"\n"
+" git branch new_branch_name %s\n"
+"\n"
+msgstr ""
+
+#: builtin/checkout.c:700
+msgid "internal error: only -- alone should have been left"
+msgstr ""
+
+#: builtin/checkout.c:702
+msgid "internal error in revision walk"
+msgstr ""
+
+#: builtin/checkout.c:706
+msgid "Previous HEAD position was"
+msgstr "Tidigare position f=C3=B6r HEAD var"
+
+#: builtin/checkout.c:731
+msgid "You are on a branch yet to be born"
+msgstr "Du =C3=A4r p=C3=A5 en gren som =C3=A4nnu inte =C3=A4r f=C3=B6d=
d"
+
+#. case (1)
+#: builtin/checkout.c:859
+#, c-format
+msgid "invalid reference: %s"
+msgstr "felaktig referens: %s"
+
+#. case (1): want a tree
+#: builtin/checkout.c:898
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr "referensen =C3=A4r inte ett tr=C3=A4d: %s"
+
+#: builtin/checkout.c:965
+msgid "-B cannot be used with -b"
+msgstr "-B kan inte anv=C3=A4ndas med -b"
+
+#: builtin/checkout.c:974
+msgid "--patch is incompatible with all other options"
+msgstr "--patch =C3=A4r inkompatibel med alla andra flaggor"
+
+#: builtin/checkout.c:977
+#, fuzzy
+msgid "--detach cannot be used with -b/-B/--orphan"
+msgstr "--cached kan inte anv=C3=A4ndas med --no-index."
+
+#: builtin/checkout.c:979
+#, fuzzy
+msgid "--detach cannot be used with -t"
+msgstr "--orphan kan inte anv=C3=A4ndas med -t"
+
+#: builtin/checkout.c:985
+msgid "--track needs a branch name"
+msgstr "--track beh=C3=B6ver ett namn p=C3=A5 en gren"
+
+#: builtin/checkout.c:992
+msgid "Missing branch name; try -b"
+msgstr "Grennamn saknas; f=C3=B6rs=C3=B6k med -b"
+
+#: builtin/checkout.c:998
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr "--orphan och --b|-B kan inte anv=C3=A4ndas samtidigt"
+
+#: builtin/checkout.c:1000
+msgid "--orphan cannot be used with -t"
+msgstr "--orphan kan inte anv=C3=A4ndas med -t"
+
+#: builtin/checkout.c:1010
+msgid "git checkout: -f and -m are incompatible"
+msgstr "git checkout: -f och -m =C3=A4r inkompatibla"
+
+#: builtin/checkout.c:1044
+msgid "invalid path specification"
+msgstr "felaktig s=C3=B6kv=C3=A4gsangivelse"
+
+#: builtin/checkout.c:1052
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+"git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibelt med =
att v=C3=A4xla gren.\n"
+"Ville du checka ut \"%s\" som inte kan l=C3=B6sas som en sammanslanin=
g?"
+
+#: builtin/checkout.c:1054
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibe=
lt med att v=C3=A4xla gren."
+
+#: builtin/checkout.c:1059
+#, fuzzy
+msgid "git checkout: --detach does not take a path argument"
+msgstr "fetch --all tar inte namnet p=C3=A5 ett arkiv som argument"
+
+#: builtin/checkout.c:1062
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+"git checkout: --ours/--theirs, --force och --merge =C3=A4r inkompatib=
la n=C3=A4r\n"
+"du checkar ut fr=C3=A5n indexet."
+
+#: builtin/checkout.c:1073
+#, c-format
+msgid "git checkout: we do not like '%s' as a branch name."
+msgstr "git checkout: vi tycker inte om \"%s\" som namn p=C3=A5 en gre=
n."
+
+#: builtin/checkout.c:1078
+#, c-format
+msgid "git checkout: branch %s already exists"
+msgstr "git checkout: grenen %s finns redan"
+
+#: builtin/checkout.c:1085
+msgid "Cannot switch branch to a non-commit."
+msgstr "Kan inte v=C3=A4xla gren p=C3=A5 en icke-incheckning."
+
+#: builtin/checkout.c:1088
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr "--ours/--theirs =C3=A4r inkompatibla n=C3=A4r du v=C3=A4xlar g=
ren."
+
+#: builtin/clean.c:78
+msgid "-x and -X cannot be used together"
+msgstr "-x och -X kan inte anv=C3=A4ndas samtidigt"
+
+#: builtin/clean.c:82
+msgid ""
+"clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
+msgstr ""
+"clean.requireForce satt till true, men varken -n eller -f angavs; v=C3=
=A4grar "
+"st=C3=A4da"
+
+#: builtin/clean.c:85
+msgid ""
+"clean.requireForce defaults to true and neither -n nor -f given; refu=
sing to "
+"clean"
+msgstr ""
+"clean.requireForce har standardv=C3=A4rdet true, men varken -n eller =
-f angavs; "
+"v=C3=A4grar st=C3=A4da"
+
+#: builtin/clean.c:154 builtin/clean.c:175
+#, c-format
+msgid "Would remove %s\n"
+msgstr "Skulle ta bort %s\n"
+
+#: builtin/clean.c:158 builtin/clean.c:178
+#, c-format
+msgid "Removing %s\n"
+msgstr "Tar bort %s\n"
+
+#: builtin/clean.c:161 builtin/clean.c:181
+#, fuzzy, c-format
+msgid "failed to remove %s"
+msgstr "kunde inte ta bort \"%s\""
+
+#: builtin/clean.c:165
+#, c-format
+msgid "Would not remove %s\n"
+msgstr "Skulle inte ta bort %s\n"
+
+#: builtin/clean.c:167
+#, c-format
+msgid "Not removing %s\n"
+msgstr "Tar inte bort %s\n"
+
+#: builtin/clone.c:214
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr "referensarkivet \"%s\" =C3=A4r inte en lokal katalog."
+
+#: builtin/clone.c:241
+#, c-format
+msgid "failed to open '%s'"
+msgstr "misslyckades =C3=B6ppna \"%s\""
+
+#: builtin/clone.c:245
+#, c-format
+msgid "failed to create directory '%s'"
+msgstr "misslyckades skapa katalogen \"%s\""
+
+#: builtin/clone.c:247 builtin/diff.c:74
+#, c-format
+msgid "failed to stat '%s'"
+msgstr "misslyckades ta status p=C3=A5 \"%s\""
+
+#: builtin/clone.c:249
+#, c-format
+msgid "%s exists and is not a directory"
+msgstr "%s finns och =C3=A4r ingen katalog"
+
+#: builtin/clone.c:263
+#, c-format
+msgid "failed to stat %s\n"
+msgstr "misslyckades ta status p=C3=A5 %s\n"
+
+#: builtin/clone.c:273
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr "misslyckades ta bort l=C3=A4nken \"%s\""
+
+#: builtin/clone.c:278
+#, c-format
+msgid "failed to create link '%s'"
+msgstr "misslyckades skapa l=C3=A4nken \"%s\""
+
+#: builtin/clone.c:282
+#, c-format
+msgid "failed to copy file to '%s'"
+msgstr "misslyckades kopiera filen till \"%s\""
+
+#: builtin/clone.c:311
+#, c-format
+msgid "done.\n"
+msgstr "klart.\n"
+
+#: builtin/clone.c:394
+msgid "Too many arguments."
+msgstr "F=C3=B6r m=C3=A5nga argument."
+
+#: builtin/clone.c:398
+msgid "You must specify a repository to clone."
+msgstr "Du m=C3=A5ste ange ett arkiv att klona."
+
+#: builtin/clone.c:406
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr "flaggorna --bare och --origin %s =C3=A4r inkompatibla."
+
+#: builtin/clone.c:420
+#, fuzzy, c-format
+msgid "repository '%s' does not exist"
+msgstr "felaktigt arkiv \"%s\""
+
+#: builtin/clone.c:425
+msgid "--depth is ignored in local clones; use file:// instead."
+msgstr ""
+
+#: builtin/clone.c:435
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr "destinationss=C3=B6kv=C3=A4gen \"%s\" finns redan och =C3=A4r =
inte en tom katalog."
+
+#: builtin/clone.c:445
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr "arbetstr=C3=A4det \"%s\" finns redan."
+
+#: builtin/clone.c:458 builtin/clone.c:472
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr "kunde inte skapa inledande kataloger f=C3=B6r \"%s\""
+
+#: builtin/clone.c:461
+#, c-format
+msgid "could not create work tree dir '%s'."
+msgstr "kunde inte skapa arbetskatalogen \"%s\""
+
+#: builtin/clone.c:480
+#, fuzzy, c-format
+msgid "Cloning into bare repository %s...\n"
+msgstr "Klonar till ett naket arkiv %s\n"
+
+#: builtin/clone.c:482
+#, fuzzy, c-format
+msgid "Cloning into %s...\n"
+msgstr "Klonar till %s\n"
+
+#: builtin/clone.c:540
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr "Vet inte hur man klonar %s"
+
+#: builtin/clone.c:579
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr ""
+"Fj=C3=A4rrgrenen %s hittades inte i uppstr=C3=B6msarkivet %s, anv=C3=A4=
nder HEAD ist=C3=A4llet"
+
+#: builtin/clone.c:589
+msgid "You appear to have cloned an empty repository."
+msgstr "Du verkar ha klonat ett tomt arkiv."
+
+#: builtin/clone.c:631
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr ""
+"HEAD hos fj=C3=A4rren pekar p=C3=A5 en obefintlig referens, kan inte =
checka ut.\n"
+
+#: builtin/commit.c:41
+#, fuzzy
+msgid ""
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n=
"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:=
\n"
+"\n"
+"    git commit --amend --reset-author\n"
+msgstr ""
+"Ditt namn och e-postadress konfigurerades automatiskt baserat p=C3=A5=
\n"
+"ditt anv=C3=A4ndar-id och v=C3=A4rdnamn. Kontrollera att de =C3=A4r r=
iktiga. Du\n"
+"kan f=C3=B6rhindra det h=C3=A4r meddelandet genom att st=C3=A4lla dem=
 explicit:\n"
+"\n"
+"    git config --global user.name \"Ditt namn\"\n"
+"    git config --global user.email du@example.com\n"
+"\n"
+"Om identiteten som anv=C3=A4ndes f=C3=B6r incheckningen =C3=A4r felak=
tig kan du\n"
+"r=C3=A4tta den med:\n"
+"\n"
+"    git commit --amend --author=3D'Ditt namn <du@example.com>'\n"
+
+#: builtin/commit.c:53
+msgid ""
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\=
n"
+"remove the commit entirely with \"git reset HEAD^\".\n"
+msgstr ""
+"Du bad om att ut=C3=B6ka den senaste incheckningen, men om du g=C3=B6=
r det\n"
+"blir den tom. Du kan k=C3=B6ra kommandot p=C3=A5 nytt med --allow-emp=
ty, eller\n"
+"s=C3=A5 kan du ta bort incheckningen helt med \"git reset HEAD^\".\n"
+
+#: builtin/commit.c:58
+msgid ""
+"The previous cherry-pick is now empty, possibly due to conflict resol=
ution.\n"
+"If you wish to commit it anyway, use:\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"Otherwise, please use 'git reset'\n"
+msgstr ""
+
+#: builtin/commit.c:318
+msgid "failed to unpack HEAD tree object"
+msgstr "misslyckades packa upp HEAD:s tr=C3=A4dobjekt"
+
+#: builtin/commit.c:359
+#, fuzzy
+msgid "unable to create temporary index"
+msgstr "kunde inte skriva tempor=C3=A4r indexfil"
+
+#: builtin/commit.c:365
+msgid "interactive add failed"
+msgstr "interaktiv till=C3=A4ggning misslyckades"
+
+#: builtin/commit.c:397 builtin/commit.c:417 builtin/commit.c:463
+msgid "unable to write new_index file"
+msgstr "kunde inte skriva filen new_index"
+
+#: builtin/commit.c:447
+#, fuzzy, c-format
+msgid "cannot do a partial commit during a %s."
+msgstr "kan inte utf=C3=B6ra en delvis incheckning under en sammanslag=
ning."
+
+#: builtin/commit.c:456
+msgid "cannot read the index"
+msgstr "kan inte l=C3=A4sa indexet"
+
+#: builtin/commit.c:476
+msgid "unable to write temporary index file"
+msgstr "kunde inte skriva tempor=C3=A4r indexfil"
+
+#: builtin/commit.c:523 builtin/commit.c:1428
+msgid "could not parse HEAD commit"
+msgstr "kunde inte tolka HEAD:s incheckning"
+
+#: builtin/commit.c:542 builtin/commit.c:548
+#, c-format
+msgid "invalid commit: %s"
+msgstr "felaktig incheckning: %s"
+
+#: builtin/commit.c:566
+msgid "malformed --author parameter"
+msgstr "felformad \"--author\"-flagga"
+
+#: builtin/commit.c:622
+#, fuzzy, c-format
+msgid "Malformed ident string: '%s'"
+msgstr "Felaktig indatarad: \"%s\"."
+
+#: builtin/commit.c:656 builtin/commit.c:689 builtin/commit.c:989
+#, c-format
+msgid "could not lookup commit %s"
+msgstr "kunde inte sl=C3=A5 upp incheckningen %s"
+
+#: builtin/commit.c:668 builtin/shortlog.c:296
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr "(l=C3=A4ser loggmeddelande fr=C3=A5n standard in)\n"
+
+#: builtin/commit.c:670
+msgid "could not read log from standard input"
+msgstr "kunde inte l=C3=A4sa logg fr=C3=A5n standard in"
+
+#: builtin/commit.c:674
+#, c-format
+msgid "could not read log file '%s'"
+msgstr "kunde inte l=C3=A4sa loggfilen \"%s\""
+
+#: builtin/commit.c:680
+msgid "commit has empty message"
+msgstr "incheckningen har ett tomt meddelande"
+
+#: builtin/commit.c:696
+msgid "could not read MERGE_MSG"
+msgstr "kunde inte l=C3=A4sa MERGE_MSG"
+
+#: builtin/commit.c:700
+msgid "could not read SQUASH_MSG"
+msgstr "kunde inte l=C3=A4sa SQUASH_MSG"
+
+#: builtin/commit.c:704
+#, c-format
+msgid "could not read '%s'"
+msgstr "kunde inte l=C3=A4sa \"%s\""
+
+#: builtin/commit.c:732
+#, c-format
+msgid "could not open '%s'"
+msgstr "kunde inte =C3=B6ppna \"%s\""
+
+#: builtin/commit.c:756
+msgid "could not write commit template"
+msgstr "kunde inte skriva incheckningsmall"
+
+#: builtin/commit.c:769
+#, fuzzy, c-format
+msgid ""
+"\n"
+"It looks like you may be committing a %s.\n"
+"If this is not correct, please remove the file\n"
+"\t%s\n"
+"and try again.\n"
+msgstr ""
+"#\n"
+"# Det verkar som du checkar in en SAMMANSLAGNING.\n"
+"# Om det inte st=C3=A4mmer tar du bort filen\n"
+"#\t%s\n"
+"# och f=C3=B6rs=C3=B6ker igen.\n"
+"#\n"
+
+#: builtin/commit.c:782
+#, fuzzy
+msgid "Please enter the commit message for your changes."
+msgstr ""
+"\n"
+"# Ange ett incheckningsmeddelande f=C3=B6r dina =C3=A4ndringar."
+
+#: builtin/commit.c:785
+#, fuzzy
+msgid ""
+" Lines starting\n"
+"with '#' will be ignored, and an empty message aborts the commit.\n"
+msgstr ""
+" Rader som inleds\n"
+"# med \"#\" kommer ignoreras, och ett tomt meddelande avbryter "
+"incheckningen.\n"
+
+#: builtin/commit.c:790
+#, fuzzy
+msgid ""
+" Lines starting\n"
+"with '#' will be kept; you may remove them yourself if you want to.\n=
"
+"An empty message aborts the commit.\n"
+msgstr ""
+" Rader som inleds\n"
+"# med \"#\" kommer beh=C3=A5llas; du kan sj=C3=A4lv ta bort dem om du=
 vill.\n"
+"# Ett tomt meddelande avbryter incheckningen.\n"
+
+#: builtin/commit.c:802
+#, fuzzy, c-format
+msgid "%sAuthor:    %s"
+msgstr "%s# F=C3=B6rfattare: %s\n"
+
+#: builtin/commit.c:809
+#, fuzzy, c-format
+msgid "%sCommitter: %s"
+msgstr "%s# Incheckare: %s\n"
+
+#: builtin/commit.c:829
+msgid "Cannot read index"
+msgstr "Kan inte l=C3=A4sa indexet"
+
+#: builtin/commit.c:869
+msgid "Error building trees"
+msgstr "Fel vid byggande av tr=C3=A4d"
+
+#: builtin/commit.c:884 builtin/tag.c:313
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr "Ange meddelandet en av flaggorna -m eller -F.\n"
+
+#: builtin/commit.c:964
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr "Hittade ingen befintlig f=C3=B6rfattare med \"%s\""
+
+#: builtin/commit.c:979 builtin/commit.c:1173
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr "Ogiltigt l=C3=A4ge f=C3=B6r osp=C3=A5rade filer: \"%s\""
+
+#: builtin/commit.c:1018
+msgid "Using both --reset-author and --author does not make sense"
+msgstr "Kan inte anv=C3=A4nda b=C3=A5de --reset-author och --author"
+
+#: builtin/commit.c:1032
+msgid "You have nothing to amend."
+msgstr "Du har inget att ut=C3=B6ka."
+
+#: builtin/commit.c:1034
+#, fuzzy, c-format
+msgid "You are in the middle of a %s -- cannot amend."
+msgstr "Du =C3=A4r i mitten av en incheckning -- kan inte ut=C3=B6ka."
+
+#: builtin/commit.c:1036
+#, fuzzy
+msgid "Options --squash and --fixup cannot be used together"
+msgstr "-x och -X kan inte anv=C3=A4ndas samtidigt"
+
+#: builtin/commit.c:1046
+#, fuzzy
+msgid "Only one of -c/-C/-F/--fixup can be used."
+msgstr "Kan endast anv=C3=A4nda en av -c/-C/-F."
+
+#: builtin/commit.c:1048
+#, fuzzy
+msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
+msgstr "Flaggan -m kan inte kombineras med -c/-C/-F."
+
+#: builtin/commit.c:1054
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr "--reset-author kan endast anv=C3=A4ndas med -C, -c eller --ame=
nd."
+
+#: builtin/commit.c:1071
+#, fuzzy
+msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
+msgstr "Endast en av --include/--only/--all/--interactive kan anv=C3=A4=
ndas."
+
+#: builtin/commit.c:1073
+msgid "No paths with --include/--only does not make sense."
+msgstr "Du m=C3=A5ste ange s=C3=B6kv=C3=A4gar tillsammans med --includ=
e/--only."
+
+#: builtin/commit.c:1075
+msgid "Clever... amending the last one with dirty index."
+msgstr "Smart... ut=C3=B6ka den senaste med smutsigt index."
+
+#: builtin/commit.c:1077
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr "Explicita s=C3=B6kv=C3=A4gar angavs utan -i eller -o; antar --=
only-paths..."
+
+#: builtin/commit.c:1087
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr "Felaktigt st=C3=A4dningsl=C3=A4ge %s"
+
+#: builtin/commit.c:1092
+msgid "Paths with -a does not make sense."
+msgstr "Kan inte ange s=C3=B6kv=C3=A4gar med -a."
+
+#: builtin/commit.c:1274
+msgid "couldn't look up newly created commit"
+msgstr "kunde inte sl=C3=A5 upp en precis skapad incheckning"
+
+#: builtin/commit.c:1276
+msgid "could not parse newly created commit"
+msgstr "kunde inte tolka en precis skapad incheckning"
+
+#: builtin/commit.c:1316
+msgid "detached HEAD"
+msgstr "fr=C3=A5nkopplad HEAD"
+
+#: builtin/commit.c:1318
+msgid " (root-commit)"
+msgstr " (rotincheckning)"
+
+#: builtin/commit.c:1441 builtin/merge.c:490
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr "kunde inte =C3=B6ppna \"%s\" f=C3=B6r l=C3=A4sning"
+
+#: builtin/commit.c:1446
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr "Trasig MERGE_HEAD-fil (%s)"
+
+#: builtin/commit.c:1453
+msgid "could not read MERGE_MODE"
+msgstr "kunde inte l=C3=A4sa MERGE_MODE"
+
+#: builtin/commit.c:1472
+#, c-format
+msgid "could not read commit message: %s"
+msgstr "kunde inte l=C3=A4sa incheckningsmeddelande: %s"
+
+#: builtin/commit.c:1486
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr "Avbryter p=C3=A5 grund av tomt incheckningsmeddelande.\n"
+
+#: builtin/commit.c:1493
+msgid "failed to write commit object"
+msgstr "kunde inte skriva incheckningsobjekt"
+
+#: builtin/commit.c:1511
+msgid "cannot lock HEAD ref"
+msgstr "kunde inte l=C3=A5sa HEAD-referens"
+
+#: builtin/commit.c:1515
+msgid "cannot update HEAD ref"
+msgstr "kunde inte uppdatera HEAD-referens"
+
+#: builtin/commit.c:1525
+msgid ""
+"Repository has been updated, but unable to write\n"
+"new_index file. Check that disk is not full or quota is\n"
+"not exceeded, and then \"git reset HEAD\" to recover."
+msgstr ""
+"Arkivet har uppdaterats, men kunde inte skriva filen\n"
+"new_index. Kontrollera att disken inte =C3=A4r full och\n"
+"att kvoten inte har =C3=B6verskridits, och k=C3=B6r sedan\n"
+"\"git reset HEAD\" f=C3=B6r att =C3=A5terst=C3=A4lla."
+
+#: builtin/describe.c:234
+#, c-format
+msgid "annotated tag %s not available"
+msgstr "den dekorerade taggen %s inte tillg=C3=A4nglig"
+
+#: builtin/describe.c:238
+#, c-format
+msgid "annotated tag %s has no embedded name"
+msgstr "den dekorerade taggen %s har inget inb=C3=A4ddat namn"
+
+#: builtin/describe.c:240
+#, c-format
+msgid "tag '%s' is really '%s' here"
+msgstr "taggen \"%s\" =C3=A4r i verkligheten \"%s\" h=C3=A4r"
+
+#: builtin/describe.c:267
+#, c-format
+msgid "Not a valid object name %s"
+msgstr "Objektnamnet =C3=A4r inte giltigt: %s"
+
+#: builtin/describe.c:270
+#, c-format
+msgid "%s is not a valid '%s' object"
+msgstr "%s =C3=A4r inte ett giltigt \"%s\"-objekt"
+
+#: builtin/describe.c:287
+#, c-format
+msgid "no tag exactly matches '%s'"
+msgstr "ingen tagg motsvarar \"%s\" exakt"
+
+#: builtin/describe.c:289
+#, c-format
+msgid "searching to describe %s\n"
+msgstr "s=C3=B6ker f=C3=B6r att beskriva %s\n"
+
+#: builtin/describe.c:329
+#, c-format
+msgid "finished search at %s\n"
+msgstr "avslutade s=C3=B6kning p=C3=A5 %s\n"
+
+#: builtin/describe.c:353
+#, c-format
+msgid ""
+"No annotated tags can describe '%s'.\n"
+"However, there were unannotated tags: try --tags."
+msgstr ""
+"Inga dekorerade taggar kan beskriva \"%s\".\n"
+"Det finns dock odekorerade taggar: testa --tags."
+
+#: builtin/describe.c:357
+#, c-format
+msgid ""
+"No tags can describe '%s'.\n"
+"Try --always, or create some tags."
+msgstr ""
+"Inga taggar kan beskriva \"%s\".\n"
+"Testa --always, eller skapa n=C3=A5gra taggar."
+
+#: builtin/describe.c:378
+#, c-format
+msgid "traversed %lu commits\n"
+msgstr "traverserade %lu incheckningar\n"
+
+#: builtin/describe.c:381
+#, c-format
+msgid ""
+"more than %i tags found; listed %i most recent\n"
+"gave up search at %s\n"
+msgstr ""
+"mer =C3=A4n %i taggar hittades; listar de %i senaste\n"
+"gav upp s=C3=B6kningen vid %s\n"
+
+#: builtin/describe.c:436
+msgid "--long is incompatible with --abbrev=3D0"
+msgstr "--long =C3=A4r inkompatibel med --abbrev=3D0"
+
+#: builtin/describe.c:462
+msgid "No names found, cannot describe anything."
+msgstr "Inga namn hittades, kan inte beskriva n=C3=A5got."
+
+#: builtin/describe.c:469
+msgid "--dirty is incompatible with committishes"
+msgstr "--dirty =C3=A4r inkompatibelt med \"committish\"-v=C3=A4rden"
+
+#: builtin/diff.c:76
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr "\"%s\": inte en normal fil eller symbolisk l=C3=A4nk"
+
+#: builtin/diff.c:220
+#, c-format
+msgid "invalid option: %s"
+msgstr "ogiltig flagga: %s"
+
+#: builtin/diff.c:296
+msgid "Not a git repository"
+msgstr "Inte ett git-arkiv"
+
+#: builtin/diff.c:346
+#, c-format
+msgid "invalid object '%s' given."
+msgstr "objektet \"%s\" som angavs =C3=A4r felaktigt."
+
+#: builtin/diff.c:351
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr "mer =C3=A4n %d tr=C3=A4d angavs: \"%s\""
+
+#: builtin/diff.c:361
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr "mer =C3=A4n tv=C3=A5 blobbar angavs: \"%s\""
+
+#: builtin/diff.c:369
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr "ej hanterat objekt \"%s\" angavs."
+
+#: builtin/fetch.c:199
+msgid "Couldn't find remote ref HEAD"
+msgstr "Kunde inte hitta fj=C3=A4rr-referensen HEAD"
+
+#: builtin/fetch.c:252
+#, c-format
+msgid "object %s not found"
+msgstr "objektet %s hittades inte"
+
+#: builtin/fetch.c:257
+msgid "[up to date]"
+msgstr "[=C3=A0jour]"
+
+#.
+#. * If this is the head, and it's not okay to update
+#. * the head, and the old value of the head isn't empty...
+#.
+#: builtin/fetch.c:270
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr "! %-*s %-*s -> %s  (kan inte h=C3=A4mta i aktuell gren)"
+
+#: builtin/fetch.c:271 builtin/fetch.c:342
+msgid "[rejected]"
+msgstr "[refuserad]"
+
+#: builtin/fetch.c:281
+msgid "[tag update]"
+msgstr "[uppdaterad tagg]"
+
+#: builtin/fetch.c:282 builtin/fetch.c:307 builtin/fetch.c:323
+msgid "  (unable to update local ref)"
+msgstr "  (kunde inte uppdatera lokal ref)"
+
+#: builtin/fetch.c:294
+msgid "[new tag]"
+msgstr "[ny tagg]"
+
+#: builtin/fetch.c:298
+msgid "[new branch]"
+msgstr "[ny gren]"
+
+#: builtin/fetch.c:338
+msgid "unable to update local ref"
+msgstr "kunde inte uppdatera lokal ref"
+
+#: builtin/fetch.c:338
+msgid "forced update"
+msgstr "tvingad uppdatering"
+
+#: builtin/fetch.c:343
+msgid "(non-fast-forward)"
+msgstr "(ej snabbspolad)"
+
+#: builtin/fetch.c:361 builtin/fetch.c:684
+#, c-format
+msgid "cannot open %s: %s\n"
+msgstr "kan inte =C3=B6ppna %s. %s\n"
+
+#: builtin/fetch.c:439
+#, c-format
+msgid "From %.*s\n"
+msgstr "Fr=C3=A5n %.*s\n"
+
+#: builtin/fetch.c:450
+#, c-format
+msgid ""
+"some local refs could not be updated; try running\n"
+" 'git remote prune %s' to remove any old, conflicting branches"
+msgstr ""
+"n=C3=A5gra lokala referenser kunde inte uppdateras; testa att k=C3=B6=
ra\n"
+" \"git remote prune %s\" f=C3=B6r att ta bort gamla grenar som st=C3=A5=
r i konflikt"
+
+#: builtin/fetch.c:500
+msgid "could not run rev-list"
+msgstr "kunde inte k=C3=B6ra rev-list"
+
+#: builtin/fetch.c:514
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr "kunde inte skriva till rev-list: %s"
+
+#: builtin/fetch.c:521
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr "kunde inte st=C3=A4nga rev-list:s standard in: %s"
+
+#: builtin/fetch.c:548
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr "   (%s kommer bli dinglande)\n"
+
+#: builtin/fetch.c:549
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr "   (%s har blivit dinglande)\n"
+
+#: builtin/fetch.c:556
+msgid "[deleted]"
+msgstr "[borttagen]"
+
+#: builtin/fetch.c:557
+msgid "(none)"
+msgstr "(ingen)"
+
+#: builtin/fetch.c:674
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr "V=C3=A4grar h=C3=A4mta till aktuell gren %s i ett icke-naket a=
rkiv"
+
+#: builtin/fetch.c:708
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr "Vet inte hur man h=C3=A4mtar fr=C3=A5n %s"
+
+#: builtin/fetch.c:762
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr "Flaggan \"%s\" och v=C3=A4rdet \"%s\" =C3=A4r inte giltigt f=C3=
=B6r %s"
+
+#: builtin/fetch.c:765
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr "Flaggan \"%s\" ignoreras f=C3=B6r %s\n"
+
+#: builtin/fetch.c:864
+#, c-format
+msgid "Fetching %s\n"
+msgstr "H=C3=A4mtar %s\n"
+
+#: builtin/fetch.c:866
+#, c-format
+msgid "Could not fetch %s"
+msgstr "Kunde inte h=C3=A4mta %s"
+
+#: builtin/fetch.c:883
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr ""
+"Inget fj=C3=A4rrarkiv angavs. Ange antingen en URL eller namnet p=C3=A5=
 ett\n"
+"fj=C3=A4rrarkiv som nya incheckningar skall h=C3=A4mtas fr=C3=A5n."
+
+#: builtin/fetch.c:903
+msgid "You need to specify a tag name."
+msgstr "Du m=C3=A5ste ange namnet p=C3=A5 en tagg."
+
+#: builtin/fetch.c:946
+msgid "fetch --all does not take a repository argument"
+msgstr "fetch --all tar inte namnet p=C3=A5 ett arkiv som argument"
+
+#: builtin/fetch.c:948
+msgid "fetch --all does not make sense with refspecs"
+msgstr "fetch --all kan inte anges med referensspecifikationer"
+
+#: builtin/fetch.c:959
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr "Fj=C3=A4rren eller fj=C3=A4rrgruppen finns inte: %s"
+
+#: builtin/fetch.c:967
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr "Kan inte h=C3=A4mta fr=C3=A5n grupp och ange referensspecifika=
tioner"
+
+#: builtin/gc.c:63
+#, c-format
+msgid "Invalid %s: '%s'"
+msgstr "Felaktigt %s: \"%s\""
+
+#: builtin/gc.c:78
+msgid "Too many options specified"
+msgstr "F=C3=B6r m=C3=A5nga flaggor angavs"
+
+#: builtin/gc.c:103
+#, c-format
+msgid "insanely long object directory %.*s"
+msgstr "tokigt l=C3=A5ng objektkatalog %.*s"
+
+#: builtin/gc.c:223
+#, c-format
+msgid "Auto packing the repository for optimum performance.\n"
+msgstr "Packar arkivet automatiskt f=C3=B6r optimal prestanda.\n"
+
+#: builtin/gc.c:226
+#, fuzzy, c-format
+msgid ""
+"Auto packing the repository for optimum performance. You may also\n"
+"run \"git gc\" manually. See \"git help gc\" for more information.\n"
+msgstr ""
+"Packar arkivet automatiskt f=C3=B6r optimal prestanda. Du kan =C3=A4v=
en\n"
+"k=C3=B6ra \"git gc\" manuellt. Se \"git help gc\" f=C3=B6r mer inform=
ation."
+
+#: builtin/gc.c:254
+msgid ""
+"There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
+msgstr ""
+"Det finns f=C3=B6r m=C3=A5nga on=C3=A5bara l=C3=B6sa objekt; k=C3=B6r=
 \"git prune\" f=C3=B6r att ta bort "
+"dem."
+
+#: builtin/grep.c:256
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr "grep: misslyckades skapa tr=C3=A5d. %s"
+
+#: builtin/grep.c:374
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr "\"%s\" kunde inte l=C3=A4sa %s"
+
+#: builtin/grep.c:425
+#, c-format
+msgid "'%s': %s"
+msgstr "\"%s\": %s"
+
+#: builtin/grep.c:436
+#, c-format
+msgid "'%s': short read %s"
+msgstr "\"%s\": kort l=C3=A4sning %s"
+
+#: builtin/grep.c:498
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr "Kunde inte byta katalog (chdir): %s"
+
+#: builtin/grep.c:573 builtin/grep.c:604
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr "kunde inte l=C3=A4sa tr=C3=A4d (%s)"
+
+#: builtin/grep.c:618
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr "Kunde inte \"grep\" fr=C3=A5n objekt av typen %s"
+
+#: builtin/grep.c:674
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr "flaggan \"%c\" antar ett numeriskt v=C3=A4rde"
+
+#: builtin/grep.c:691
+#, c-format
+msgid "cannot open '%s'"
+msgstr "kan inte =C3=B6ppna \"%s\""
+
+#: builtin/grep.c:974
+msgid "no pattern given."
+msgstr "inget m=C3=B6nster angavs."
+
+#: builtin/grep.c:1001
+#, c-format
+msgid "bad object %s"
+msgstr "felaktigt objekt %s"
+
+#: builtin/grep.c:1025
+msgid "--open-files-in-pager only works on the worktree"
+msgstr "--open-files-in-pager fungerar endast i arbetskatalogen"
+
+#: builtin/grep.c:1050
+msgid "--cached cannot be used with --no-index."
+msgstr "--cached kan inte anv=C3=A4ndas med --no-index."
+
+#: builtin/grep.c:1052
+msgid "--no-index cannot be used with revs."
+msgstr "--no-index kan inte anv=C3=A4ndas med revisioner."
+
+#: builtin/grep.c:1061
+msgid "both --cached and trees are given."
+msgstr "b=C3=A5de --cached och tr=C3=A4d angavs."
+
+#: builtin/init-db.c:35
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Kunde inte g=C3=B6ra %s skrivbar f=C3=B6r grubben"
+
+#: builtin/init-db.c:62
+#, c-format
+msgid "insanely long template name %s"
+msgstr "tokigt l=C3=A5ngt namn p=C3=A5 mallen %s"
+
+#: builtin/init-db.c:67
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "kan inte ta status p=C3=A5 \"%s\""
+
+#: builtin/init-db.c:73
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "kan inte ta status p=C3=A5 mallen \"%s\""
+
+#: builtin/init-db.c:80
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "kan inte =C3=B6ppna katalogen (opendir) \"%s\""
+
+#: builtin/init-db.c:97
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "kan inte l=C3=A4sa l=C3=A4nk (readlink) \"%s\""
+
+#: builtin/init-db.c:99
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "tokigt l=C3=A5ng symbolisk l=C3=A4nk %s"
+
+#: builtin/init-db.c:102
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "kan inte skapa symbolisk l=C3=A4nk \"%s\" \"%s\""
+
+#: builtin/init-db.c:106
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "kan inte kopiera \"%s\" till \"%s\""
+
+#: builtin/init-db.c:110
+#, c-format
+msgid "ignoring template %s"
+msgstr "ignorerar mallen %s"
+
+#: builtin/init-db.c:133
+#, c-format
+msgid "insanely long template path %s"
+msgstr "tokigt l=C3=A5ng malls=C3=B6kv=C3=A4g %s"
+
+#: builtin/init-db.c:141
+#, c-format
+msgid "templates not found %s"
+msgstr "mallarna hittades inte %s"
+
+#: builtin/init-db.c:154
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "kopierade inte mallar fr=C3=A5n felaktig formatversion %d fr=C3=
=A5n \"%s\""
+
+#: builtin/init-db.c:192
+#, c-format
+msgid "insane git directory %s"
+msgstr "tokig git-katalog %s"
+
+#: builtin/init-db.c:322 builtin/init-db.c:325
+#, fuzzy, c-format
+msgid "%s already exists"
+msgstr "taggen \"%s\" finns redan"
+
+#: builtin/init-db.c:354
+#, fuzzy, c-format
+msgid "unable to handle file type %d"
+msgstr "kunde inte l=C3=A4sa tr=C3=A4d (%s)"
+
+#: builtin/init-db.c:357
+#, fuzzy, c-format
+msgid "unable to move %s to %s"
+msgstr "kunde inte skriva %s"
+
+#: builtin/init-db.c:362
+#, fuzzy, c-format
+msgid "Could not create git link %s"
+msgstr "kunde inte skapa filen \"%s\""
+
+#.
+#. * TRANSLATORS: The first '%s' is either "Reinitialized
+#. * existing" or "Initialized empty", the second " shared" or
+#. * "", and the last '%s%s' is the verbatim directory name.
+#.
+#: builtin/init-db.c:419
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git-arkiv i %s%s\n"
+
+#: builtin/init-db.c:420
+msgid "Reinitialized existing"
+msgstr "Ominitierade befintligt"
+
+#: builtin/init-db.c:420
+msgid "Initialized empty"
+msgstr "Initierade tomt"
+
+#: builtin/init-db.c:421
+msgid " shared"
+msgstr " delat"
+
+#: builtin/init-db.c:440
+msgid "cannot tell cwd"
+msgstr "kan inte l=C3=A4sa aktuell katalog (cwd)"
+
+#: builtin/init-db.c:521 builtin/init-db.c:528
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "kan inte skapa katalogen (mkdir) %s"
+
+#: builtin/init-db.c:532
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "kan inte byta katalog (chdir) till %s"
+
+#: builtin/init-db.c:554
+#, c-format
+msgid ""
+"%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
+"dir=3D<directory>)"
+msgstr ""
+"%s (eller --work-tree=3D<katalog>) inte till=C3=A5tet utan att ange %=
s (eller --git-"
+"dir=3D<katalog>)"
+
+#: builtin/init-db.c:578
+msgid "Cannot access current working directory"
+msgstr "Kan inte komma =C3=A5t aktuell arbetskatalog"
+
+#: builtin/init-db.c:585
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Kan inte komma =C3=A5t arbetskatalogen \"%s\""
+
+#: builtin/log.c:186
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr "Slututdata: %d %s\n"
+
+#: builtin/log.c:287 builtin/log.c:721 builtin/log.c:1274 builtin/log.=
c:1492
+#: builtin/merge.c:338 builtin/revert.c:539 builtin/shortlog.c:181
+msgid "revision walk setup failed"
+msgstr "misslyckades skapa revisionstraversering"
+
+#: builtin/log.c:397 builtin/log.c:486
+#, c-format
+msgid "Could not read object %s"
+msgstr "Kunde inte l=C3=A4sa objektet %s"
+
+#: builtin/log.c:510
+#, c-format
+msgid "Unknown type: %d"
+msgstr "Ok=C3=A4nd typ: %d"
+
+#: builtin/log.c:605
+msgid "format.headers without value"
+msgstr "format.headers utan v=C3=A4rde"
+
+#: builtin/log.c:677
+msgid "name of output directory is too long"
+msgstr "namn p=C3=A5 utdatakatalogen =C3=A4r f=C3=B6r l=C3=A5ng"
+
+#: builtin/log.c:688
+#, c-format
+msgid "Cannot open patch file %s"
+msgstr "Kan inte =C3=B6ppna patchfilen %s"
+
+#: builtin/log.c:702
+msgid "Need exactly one range."
+msgstr "Beh=C3=B6ver precis ett intervall."
+
+#: builtin/log.c:710
+msgid "Not a range."
+msgstr "Inte ett intervall."
+
+#: builtin/log.c:747
+msgid "Could not extract email from committer identity."
+msgstr "Kunde inte extrahera e-postadress fr=C3=A5n incheckarens ident=
itet."
+
+#: builtin/log.c:779
+msgid "Cover letter needs email format"
+msgstr "Omslagsbrevet beh=C3=B6ver e-postformat"
+
+#: builtin/log.c:872
+#, c-format
+msgid "insane in-reply-to: %s"
+msgstr "tokigt in-reply-to: %s"
+
+#: builtin/log.c:945
+msgid "Two output directories?"
+msgstr "Tv=C3=A5 utdatakataloger?"
+
+#: builtin/log.c:1136
+#, c-format
+msgid "bogus committer info %s"
+msgstr "felaktig incheckarinformation %s"
+
+#: builtin/log.c:1181
+msgid "-n and -k are mutually exclusive."
+msgstr "-n och -k kan inte anv=C3=A4ndas samtidigt."
+
+#: builtin/log.c:1183
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr "--subject-prefix och -k kan inte anv=C3=A4ndas samtidigt."
+
+#: builtin/log.c:1188 builtin/shortlog.c:284
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "ok=C3=A4nt argument: %s"
+
+#: builtin/log.c:1191
+msgid "--name-only does not make sense"
+msgstr "kan inte anv=C3=A4nda --name-only"
+
+#: builtin/log.c:1193
+msgid "--name-status does not make sense"
+msgstr "kan inte anv=C3=A4nda --name-status"
+
+#: builtin/log.c:1195
+msgid "--check does not make sense"
+msgstr "kan inte anv=C3=A4nda --check"
+
+#: builtin/log.c:1218
+msgid "standard output, or directory, which one?"
+msgstr "standard ut, eller katalog, vilken skall det vara?"
+
+#: builtin/log.c:1220
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr "Kunde inte skapa katalogen \"%s\""
+
+#: builtin/log.c:1355
+msgid "Failed to create output files"
+msgstr "Misslyckades skapa utdatafiler"
+
+#: builtin/log.c:1458
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr "Kunde inte hitta en sp=C3=A5rad fj=C3=A4rrgren, ange <uppstr=C3=
=B6m> manuellt.\n"
+
+#: builtin/log.c:1474 builtin/log.c:1476 builtin/log.c:1488
+#, c-format
+msgid "Unknown commit %s"
+msgstr "Ok=C3=A4nd incheckning %s"
+
+#: builtin/merge.c:88
+msgid "switch `m' requires a value"
+msgstr "flaggan \"m\" beh=C3=B6ver ett v=C3=A4rde"
+
+#: builtin/merge.c:125
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr "Kunde inte hitta sammanslagningsstrategin \"%s\".\n"
+
+#: builtin/merge.c:126
+#, c-format
+msgid "Available strategies are:"
+msgstr "Tillg=C3=A4ngliga strategier =C3=A4r:"
+
+#: builtin/merge.c:131
+#, c-format
+msgid "Available custom strategies are:"
+msgstr "Tillg=C3=A4ngliga skr=C3=A4ddarsydda strategier =C3=A4r:"
+
+#: builtin/merge.c:233
+msgid "could not run stash."
+msgstr "kunde k=C3=B6ra stash."
+
+#: builtin/merge.c:238
+msgid "stash failed"
+msgstr "stash misslyckades"
+
+#: builtin/merge.c:243
+#, c-format
+msgid "not a valid object: %s"
+msgstr "inte ett giltigt objekt: %s"
+
+#: builtin/merge.c:261 builtin/merge.c:278
+msgid "read-tree failed"
+msgstr "read-tree misslyckades"
+
+#: builtin/merge.c:307
+msgid " (nothing to squash)"
+msgstr " (inget att platta till)"
+
+#: builtin/merge.c:320
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr "Tillplattningsincheckning -- uppdaterar inte HEAD\n"
+
+#: builtin/merge.c:323 builtin/merge.c:844 builtin/merge.c:1430
+#: builtin/merge.c:1442 builtin/revert.c:213
+#, c-format
+msgid "Could not write to '%s'"
+msgstr "Kunde inte skriva till \"%s\""
+
+#: builtin/merge.c:352
+msgid "Writing SQUASH_MSG"
+msgstr "Skriver SQUASH_MSG"
+
+#: builtin/merge.c:354
+msgid "Finishing SQUASH_MSG"
+msgstr "Avslutar SQUASH_MSG"
+
+#: builtin/merge.c:374
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr "Inget sammanslagningsmeddelande -- uppdaterar inte HEAD\n"
+
+#: builtin/merge.c:425
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr "\"%s\" verkar inte peka p=C3=A5 en incheckning"
+
+#: builtin/merge.c:517
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr "Felaktig branch.%s.mergeoptions-str=C3=A4ng: %s"
+
+#: builtin/merge.c:550
+#, c-format
+msgid "%s: negative length %s"
+msgstr ""
+
+#: builtin/merge.c:609
+msgid "git write-tree failed to write a tree"
+msgstr "git write--tree misslyckades skriva ett tr=C3=A4d"
+
+#: builtin/merge.c:659
+msgid "failed to read the cache"
+msgstr "misslyckads l=C3=A4sa cachen"
+
+#: builtin/merge.c:676
+msgid "Unable to write index."
+msgstr "Kunde inte skriva indexet."
+
+#: builtin/merge.c:689
+msgid "Not handling anything other than two heads merge."
+msgstr "Hanterar inte n=C3=A5got annat =C3=A4n en sammanslagning av tv=
=C3=A5 huvuden."
+
+#: builtin/merge.c:703
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr "Felaktig flagga f=C3=B6r merge-recursive: -X%s"
+
+#: builtin/merge.c:717
+#, c-format
+msgid "unable to write %s"
+msgstr "kunde inte skriva %s"
+
+#: builtin/merge.c:841 builtin/merge.c:920 builtin/merge.c:1427
+#: builtin/merge.c:1436 builtin/revert.c:210
+#, c-format
+msgid "Could not open '%s' for writing"
+msgstr "Kunde inte =C3=B6ppna \"%s\" f=C3=B6r skrivning"
+
+#: builtin/merge.c:852
+#, fuzzy, c-format
+msgid "Could not read from '%s'"
+msgstr "kunde inte l=C3=A4sa \"%s\""
+
+#: builtin/merge.c:869
+#, c-format
+msgid "Wonderful.\n"
+msgstr "Underbart.\n"
+
+#: builtin/merge.c:936
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr ""
+"Kunde inte sl=C3=A5 ihop automatiskt; fixa konflikter och checka in r=
esultatet.\n"
+
+#: builtin/merge.c:951
+#, c-format
+msgid "'%s' is not a commit"
+msgstr "\"%s\" =C3=A4r inte en incheckning"
+
+#: builtin/merge.c:992
+#, fuzzy
+msgid "No current branch."
+msgstr "Inte p=C3=A5 n=C3=A5gon gren f=C3=B6r n=C3=A4rvarande."
+
+#: builtin/merge.c:994
+#, fuzzy
+msgid "No remote for the current branch."
+msgstr "Du =C3=A4r inte p=C3=A5 n=C3=A5gon gren f=C3=B6r n=C3=A4rvaran=
de."
+
+#: builtin/merge.c:996
+msgid "No default upstream defined for the current branch."
+msgstr ""
+
+#: builtin/merge.c:1001
+#, c-format
+msgid "No remote tracking branch for %s from %s"
+msgstr ""
+
+#: builtin/merge.c:1053
+msgid "There is no merge to abort (MERGE_HEAD missing)."
+msgstr ""
+
+#: builtin/merge.c:1068 git-pull.sh:31
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"Du har inte avslutat sammanslagningen (MERGE_HEAD finns).\n"
+"Checka in dina =C3=A4ndringar innan du kan sl=C3=A5 ihop."
+
+#: builtin/merge.c:1071 git-pull.sh:34
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr "Du har inte avslutat sammanslagningen (MERGE_HEAD finns)."
+
+#: builtin/merge.c:1075
+#, fuzzy
+msgid ""
+"You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"Du har inte avslutat sammanslagningen (MERGE_HEAD finns).\n"
+"Checka in dina =C3=A4ndringar innan du kan sl=C3=A5 ihop."
+
+#: builtin/merge.c:1078
+#, fuzzy
+msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
+msgstr "Du har inte avslutat sammanslagningen (MERGE_HEAD finns)."
+
+#: builtin/merge.c:1087
+msgid "You cannot combine --squash with --no-ff."
+msgstr "Du kan inte kombinera --squash med --no-ff."
+
+#: builtin/merge.c:1092
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr "Du kan inte kombinera --no-ff med --ff-only."
+
+#: builtin/merge.c:1126
+msgid "Can merge only exactly one commit into empty head"
+msgstr "Kan endast sl=C3=A5 ihop en enda incheckning i ett tomt huvud.=
"
+
+#: builtin/merge.c:1129
+msgid "Squash commit into empty head not supported yet"
+msgstr "St=C3=B6der inte en tillplattningsincheckning p=C3=A5 ett tomt=
 huvud =C3=A4nnu"
+
+#: builtin/merge.c:1131
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr "Icke-snabbspolad incheckning kan inte anv=C3=A4ndas med ett to=
mt huvud"
+
+#: builtin/merge.c:1135 builtin/merge.c:1181
+#, c-format
+msgid "%s - not something we can merge"
+msgstr "%s - inte n=C3=A5got vi kan sl=C3=A5 ihop"
+
+#: builtin/merge.c:1239
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr "Uppdaterar %s..%s\n"
+
+#: builtin/merge.c:1273
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr "F=C3=B6rs=C3=B6ker riktigt enkel sammanslagning i indexet...\n=
"
+
+#: builtin/merge.c:1277
+#, c-format
+msgid "Nope.\n"
+msgstr "Nej.\n"
+
+#: builtin/merge.c:1310
+msgid "Not possible to fast-forward, aborting."
+msgstr "Kan inte snabbspola, avbryter."
+
+#: builtin/merge.c:1336 builtin/merge.c:1409
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr "=C3=85terspolar tr=C3=A4det till of=C3=B6rd=C3=A4rvat...\n"
+
+#: builtin/merge.c:1340
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr "F=C3=B6rs=C3=B6ker sammanslagninsstrategin %s...\n"
+
+#: builtin/merge.c:1401
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr "Ingen sammanslagningsstrategi hanterade sammanslagningen.\n"
+
+#: builtin/merge.c:1403
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr "Sammanslaning med strategin %s misslyckades.\n"
+
+#: builtin/merge.c:1411
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr "Anv=C3=A4nder %s f=C3=B6r att f=C3=B6rbereda l=C3=B6sning f=C3=
=B6r hand.\n"
+
+#: builtin/merge.c:1447
+#, c-format
+msgid "Automatic merge went well; stopped before committing as request=
ed\n"
+msgstr ""
+"Automatisk sammanslagning lyckades; stoppar f=C3=B6re incheckning som=
 =C3=B6nskat\n"
+
+#: builtin/mv.c:103
+#, c-format
+msgid "Checking rename of '%s' to '%s'\n"
+msgstr "Kontrollerar namnbyte av \"%s\" till \"%s\"\n"
+
+#: builtin/mv.c:107
+msgid "bad source"
+msgstr "felaktig k=C3=A4lla"
+
+#: builtin/mv.c:110
+msgid "can not move directory into itself"
+msgstr "kan inte flytta katalog till sig sj=C3=A4lv"
+
+#: builtin/mv.c:113
+msgid "cannot move directory over file"
+msgstr "kan inte flytta katalog =C3=B6ver fil"
+
+#: builtin/mv.c:123
+#, c-format
+msgid "Huh? %.*s is in index?"
+msgstr "Vad? %.*s =C3=A4r i indexet?"
+
+#: builtin/mv.c:135
+msgid "source directory is empty"
+msgstr "k=C3=A4llkatalogen =C3=A4r tom"
+
+#: builtin/mv.c:166
+msgid "not under version control"
+msgstr "inte versionshanterad"
+
+#: builtin/mv.c:168
+msgid "destination exists"
+msgstr "destinationen finns"
+
+#: builtin/mv.c:175
+#, c-format
+msgid "%s; will overwrite!"
+msgstr "%s; kommer skriva =C3=B6ver!"
+
+#: builtin/mv.c:178
+msgid "Cannot overwrite"
+msgstr "Kan inte skriva =C3=B6ver"
+
+#: builtin/mv.c:181
+msgid "multiple sources for the same target"
+msgstr "flera k=C3=A4llor f=C3=B6r samma m=C3=A5l"
+
+#: builtin/mv.c:196
+#, c-format
+msgid "%s, source=3D%s, destination=3D%s"
+msgstr "%s, k=C3=A4lla=3D%s, m=C3=A5l=3D%s"
+
+#: builtin/mv.c:206
+#, c-format
+msgid "Renaming %s to %s\n"
+msgstr "Byter namn p=C3=A5 %s till %s\n"
+
+#: builtin/mv.c:209
+#, c-format
+msgid "renaming '%s' failed"
+msgstr "misslyckades byta namn p=C3=A5 \"%s\""
+
+#: builtin/notes.c:139
+#, c-format
+msgid "unable to start 'show' for object '%s'"
+msgstr "kunde int estarta \"show\" f=C3=B6r objektet \"%s\""
+
+#: builtin/notes.c:145
+msgid "can't fdopen 'show' output fd"
+msgstr "kunde inte =C3=B6ppna (fdopen) \"show\"-utdata-filhandtag"
+
+#: builtin/notes.c:155
+#, c-format
+msgid "failed to close pipe to 'show' for object '%s'"
+msgstr "kunde inte st=C3=A4nga r=C3=B6ret till \"show\" f=C3=B6r objek=
tet \"%s\""
+
+#: builtin/notes.c:158
+#, c-format
+msgid "failed to finish 'show' for object '%s'"
+msgstr "kunde inte avsluta \"show\" f=C3=B6r objektet \"%s\""
+
+#: builtin/notes.c:175 builtin/tag.c:303
+#, c-format
+msgid "could not create file '%s'"
+msgstr "kunde inte skapa filen \"%s\""
+
+#: builtin/notes.c:189
+msgid "Please supply the note contents using either -m or -F option"
+msgstr "Ange inneh=C3=A5ll f=C3=B6r anteckningen med antingen -m eller=
 -F"
+
+#: builtin/notes.c:210 builtin/notes.c:968
+#, c-format
+msgid "Removing note for object %s\n"
+msgstr "Tar bort anteckning f=C3=B6r objektet %s\n"
+
+#: builtin/notes.c:215
+msgid "unable to write note object"
+msgstr "kunde inte skriva anteckningsobjekt"
+
+#: builtin/notes.c:217
+#, c-format
+msgid "The note contents has been left in %s"
+msgstr "Anteckningens inneh=C3=A5ll har l=C3=A4mnats kvar i %s"
+
+#: builtin/notes.c:251 builtin/tag.c:448
+#, c-format
+msgid "cannot read '%s'"
+msgstr "kunde inte l=C3=A4sa \"%s\""
+
+#: builtin/notes.c:253 builtin/tag.c:451
+#, c-format
+msgid "could not open or read '%s'"
+msgstr "kunde inte =C3=B6ppna eller l=C3=A4sa \"%s\""
+
+#: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
+#: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
+#: builtin/notes.c:649 builtin/notes.c:724 builtin/notes.c:766
+#: builtin/notes.c:963 builtin/reset.c:303 builtin/tag.c:464
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr "Kunde inte sl=C3=A5 upp \"%s\" som en giltig referens."
+
+#: builtin/notes.c:275
+#, c-format
+msgid "Failed to read object '%s'."
+msgstr "Kunde inte l=C3=A4sa objektet \"%s\"."
+
+#: builtin/notes.c:299
+msgid "Cannot commit uninitialized/unreferenced notes tree"
+msgstr "Kan inte checka in oinitierat/orefererat anteckningstr=C3=A4d"
+
+#: builtin/notes.c:340
+#, c-format
+msgid "Bad notes.rewriteMode value: '%s'"
+msgstr "Felaktigt v=C3=A4rde f=C3=B6r notes.rewriteMode: '%s'"
+
+#: builtin/notes.c:350
+#, c-format
+msgid "Refusing to rewrite notes in %s (outside of refs/notes/)"
+msgstr "V=C3=A4grar skriva =C3=B6ver anteckningar i %s (utanf=C3=B6r r=
efs/notes/)"
+
+#. TRANSLATORS: The first %s is the name of the
+#. environment variable, the second %s is its value
+#: builtin/notes.c:377
+#, c-format
+msgid "Bad %s value: '%s'"
+msgstr "Felaktigt v=C3=A4rde p=C3=A5 %s: \"%s\""
+
+#: builtin/notes.c:441
+#, c-format
+msgid "Malformed input line: '%s'."
+msgstr "Felaktig indatarad: \"%s\"."
+
+#: builtin/notes.c:456
+#, c-format
+msgid "Failed to copy notes from '%s' to '%s'"
+msgstr "Misslyckades kopiera anteckningar fr=C3=A5n \"%s\" till \"%s\"=
"
+
+#: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
+#: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
+#: builtin/notes.c:1028
+msgid "too many parameters"
+msgstr "f=C3=B6r m=C3=A5nga parametrar"
+
+#: builtin/notes.c:513 builtin/notes.c:772
+#, c-format
+msgid "No note found for object %s."
+msgstr "Inga anteckningar hittades f=C3=B6r objektet %s."
+
+#: builtin/notes.c:580
+#, c-format
+msgid ""
+"Cannot add notes. Found existing notes for object %s. Use '-f' to ove=
rwrite "
+"existing notes"
+msgstr ""
+"Kan inte l=C3=A4gga till anteckningar. Hittade befintliga anteckninga=
r f=C3=B6r "
+"objektet %s. Anv=C3=A4nd \"-f\" f=C3=B6r att skriva =C3=B6ver befintl=
iga anteckningar"
+
+#: builtin/notes.c:585 builtin/notes.c:662
+#, c-format
+msgid "Overwriting existing notes for object %s\n"
+msgstr "Skriver =C3=B6ver befintliga anteckningar f=C3=B6r objektet %s=
\n"
+
+#: builtin/notes.c:635
+msgid "too few parameters"
+msgstr "f=C3=B6r f=C3=A5 parametrar"
+
+#: builtin/notes.c:656
+#, c-format
+msgid ""
+"Cannot copy notes. Found existing notes for object %s. Use '-f' to ov=
erwrite "
+"existing notes"
+msgstr ""
+"Kan inte kopiera anteckningar. Hittade befintliga anteckningar f=C3=B6=
r objektet "
+"%s. Anv=C3=A4nd \"-f\" f=C3=B6r att skriva =C3=B6ver befintliga antec=
kningar"
+
+#: builtin/notes.c:668
+#, c-format
+msgid "Missing notes on source object %s. Cannot copy."
+msgstr "Anteckningar p=C3=A5 k=C3=A4llobjektet %s saknas. Kan inte kop=
iera."
+
+#: builtin/notes.c:717
+#, c-format
+msgid ""
+"The -m/-F/-c/-C options have been deprecated for the 'edit' subcomman=
d.\n"
+"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
+msgstr ""
+"Flaggorna -m/-F/-c/-C rekommenderas inte f=C3=B6r underkommandot \"ed=
it\".\n"
+"Anv=C3=A4nd \"git notes add -f -m/-F/-c/-C\" ist=C3=A4llet.\n"
+
+#: builtin/notes.c:966
+#, c-format
+msgid "Object %s has no note\n"
+msgstr "Objektet %s har ingen anteckning\n"
+
+#: builtin/notes.c:1098
+#, c-format
+msgid "Unknown subcommand: %s"
+msgstr "Ok=C3=A4nt underkommando: %s"
+
+#: builtin/push.c:43
+msgid "tag shorthand without <tag>"
+msgstr "taggf=C3=B6rkortning utan <tagg>"
+
+#: builtin/push.c:62
+msgid "--delete only accepts plain target ref names"
+msgstr "--delete godtar endast enkla m=C3=A5lreferensnamn"
+
+#: builtin/push.c:72
+#, c-format
+msgid ""
+"You are not currently on a branch.\n"
+"To push the history leading to the current (detached HEAD)\n"
+"state now, use\n"
+"\n"
+"    git push %s HEAD:<name-of-remote-branch>\n"
+msgstr ""
+
+#: builtin/push.c:79
+#, c-format
+msgid ""
+"The current branch %s has no upstream branch.\n"
+"To push the current branch and set the remote as upstream, use\n"
+"\n"
+"    git push --set-upstream %s %s\n"
+msgstr ""
+
+#: builtin/push.c:87
+#, fuzzy, c-format
+msgid "The current branch %s has multiple upstream branches, refusing =
to push."
+msgstr "Den aktuella grenen %s sp=C3=A5rar flera grenar, v=C3=A4grar s=
=C3=A4nda."
+
+#: builtin/push.c:110
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr ""
+"Du angav inga referensspecifikationer att s=C3=A4nda, och push.defaul=
t =C3=A4r "
+"\"nothing\"."
+
+#: builtin/push.c:130
+#, c-format
+msgid "Pushing to %s\n"
+msgstr "S=C3=A4nder till %s\n"
+
+#: builtin/push.c:134
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr "misslyckades s=C3=A4nda n=C3=A5gra referenser till \"%s\""
+
+#: builtin/push.c:142
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+"F=C3=B6r att f=C3=B6rhindra att du tappar historik har icke snabbspol=
ande "
+"uppdateringar\n"
+"avvisats. Sl=C3=A5 ihop fj=C3=A4rr=C3=A4ndringarna (t.ex \"git pull\"=
) innan du s=C3=A4nder "
+"igen.\n"
+"Se avsnittet \"Note about fast-forward\" i \"git push --help\" f=C3=B6=
r "
+"detaljer.\n"
+
+#: builtin/push.c:159
+#, c-format
+msgid "bad repository '%s'"
+msgstr "felaktigt arkiv \"%s\""
+
+#: builtin/push.c:160
+msgid ""
+"No configured push destination.\n"
+"Either specify the URL from the command-line or configure a remote "
+"repository using\n"
+"\n"
+"    git remote add <name> <url>\n"
+"\n"
+"and then push using the remote name\n"
+"\n"
+"    git push <name>\n"
+msgstr ""
+
+#: builtin/push.c:175
+msgid "--all and --tags are incompatible"
+msgstr "--all och --tags =C3=A4r inkompatibla"
+
+#: builtin/push.c:176
+msgid "--all can't be combined with refspecs"
+msgstr "--all kan inte kombineras med referensspecifikationer"
+
+#: builtin/push.c:181
+msgid "--mirror and --tags are incompatible"
+msgstr "--mirror och --tags =C3=A4r inkompatibla"
+
+#: builtin/push.c:182
+msgid "--mirror can't be combined with refspecs"
+msgstr "--mirror kan inte kombineras med referensspecifikationer"
+
+#: builtin/push.c:187
+msgid "--all and --mirror are incompatible"
+msgstr "--all och --mirror =C3=A4r inkompatibla"
+
+#: builtin/push.c:253
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr "--delete =C3=A4r imkompatibel med --all, --mirror och --tags"
+
+#: builtin/push.c:255
+msgid "--delete doesn't make sense without any refs"
+msgstr "--delete kan inte anv=C3=A4ndas utan referenser"
+
+#: builtin/reset.c:33
+msgid "mixed"
+msgstr "blandad"
+
+#: builtin/reset.c:33
+msgid "soft"
+msgstr "mjuk"
+
+#: builtin/reset.c:33
+msgid "hard"
+msgstr "h=C3=A5rd"
+
+#: builtin/reset.c:33
+msgid "merge"
+msgstr "sammanslagning"
+
+#: builtin/reset.c:33
+msgid "keep"
+msgstr "beh=C3=A5ll"
+
+#: builtin/reset.c:95
+msgid "You do not have a valid HEAD."
+msgstr "Du har inte en giltig HEAD."
+
+#: builtin/reset.c:97
+msgid "Failed to find tree of HEAD."
+msgstr "Kunde inte hitta tr=C3=A4der f=C3=B6r HEAD."
+
+#: builtin/reset.c:103
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr "Kunde inte hitta tr=C3=A4der f=C3=B6r %s."
+
+#: builtin/reset.c:108
+msgid "Could not write new index file."
+msgstr "Kunde inte skriva ny indexfil."
+
+#: builtin/reset.c:118
+#, c-format
+msgid "HEAD is now at %s"
+msgstr "HEAD =C3=A4r nu p=C3=A5 %s"
+
+#: builtin/reset.c:142
+msgid "Could not read index"
+msgstr "Kunde inte l=C3=A4sa indexet"
+
+#: builtin/reset.c:145
+msgid "Unstaged changes after reset:"
+msgstr "Ok=C3=B6ade =C3=A4ndringar efter =C3=A5terst=C3=A4llning:"
+
+#: builtin/reset.c:225
+#, c-format
+msgid "Reflog action message too long: %.*s..."
+msgstr "Reflog-h=C3=A4ndelsemeddelande f=C3=B6r l=C3=A5ngt: %.*s..."
+
+#: builtin/reset.c:231
+#, c-format
+msgid "Cannot do a %s reset in the middle of a merge."
+msgstr "Kan inte utf=C3=B6ra en %s =C3=A5terst=C3=A4llning mitt i en s=
ammanslagning."
+
+#: builtin/reset.c:307
+#, c-format
+msgid "Could not parse object '%s'."
+msgstr "Kan inte tolka objektet \"%s\""
+
+#: builtin/reset.c:312
+msgid "--patch is incompatible with --{hard,mixed,soft}"
+msgstr "--patch =C3=A4r inkompatibel med --{hard,mixed,soft}"
+
+#: builtin/reset.c:321
+msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
+msgstr ""
+"--mixed rekommenderas inte med s=C3=B6kv=C3=A4gar; anv=C3=A4nd \"git =
reset -- <s=C3=B6kv=C3=A4gar>\"."
+
+#: builtin/reset.c:323
+#, c-format
+msgid "Cannot do %s reset with paths."
+msgstr "Kan inte g=C3=B6ra %s =C3=A5terst=C3=A4llning med s=C3=B6kv=C3=
=A4gar."
+
+#: builtin/reset.c:335
+#, c-format
+msgid "%s reset is not allowed in a bare repository"
+msgstr "%s =C3=A5terst=C3=A4llning till=C3=A5ts inte i ett naket arkiv=
"
+
+#: builtin/reset.c:351
+#, c-format
+msgid "Could not reset index file to revision '%s'."
+msgstr "Kunde inte =C3=A5terst=C3=A4lla indexfilen till versionen \"%s=
\"."
+
+#: builtin/revert.c:99
+msgid "program error"
+msgstr "programfel"
+
+#: builtin/revert.c:171
+#, c-format
+msgid "Could not read commit message of %s"
+msgstr "Kunde inte l=C3=A4sa incheckningsmeddelandet f=C3=B6r %s"
+
+#: builtin/revert.c:253
+#, c-format
+msgid "Could not write to %s."
+msgstr "Kunde inte skriva till %s."
+
+#: builtin/revert.c:256
+#, c-format
+msgid "Error wrapping up %s"
+msgstr "Fel vid ombrytning av %s"
+
+#: builtin/revert.c:276
+msgid ""
+"Your local changes would be overwritten by revert.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"revert\".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r at=
t forts=C3=A4tta."
+
+#: builtin/revert.c:279
+msgid ""
+"Your local changes would be overwritten by cherry-pick.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"cherry-pick\=
".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r at=
t forts=C3=A4tta."
+
+#: builtin/revert.c:283
+#, fuzzy
+msgid "Your local changes would be overwritten by revert.\n"
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"revert\".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r at=
t forts=C3=A4tta."
+
+#: builtin/revert.c:285
+#, fuzzy
+msgid "Your local changes would be overwritten by cherry-pick.\n"
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"cherry-pick\=
".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r at=
t forts=C3=A4tta."
+
+#. TRANSLATORS: %s will be "revert" or "cherry-pick"
+#: builtin/revert.c:335
+#, c-format
+msgid "%s: Unable to write new index file"
+msgstr "%s: Kunde inte skriva ny indexfil"
+
+#: builtin/revert.c:401
+msgid "Your index file is unmerged."
+msgstr "Din indexfil har inte slagits ihop."
+
+#: builtin/revert.c:404
+msgid "You do not have a valid HEAD"
+msgstr "Du har ingen giltig HEAD"
+
+#: builtin/revert.c:419
+#, c-format
+msgid "Commit %s is a merge but no -m option was given."
+msgstr "Incheckning %s =C3=A4r en sammanslagning, men flaggan -m angav=
s inte."
+
+#: builtin/revert.c:427
+#, c-format
+msgid "Commit %s does not have parent %d"
+msgstr "Incheckning %s har inte f=C3=B6r=C3=A4lder %d"
+
+#: builtin/revert.c:431
+#, c-format
+msgid "Mainline was specified but commit %s is not a merge."
+msgstr "Huvudlinje angavs, men incheckningen %s =C3=A4r inte en samman=
slagning"
+
+#. TRANSLATORS: The first %s will be "revert" or
+#. "cherry-pick", the second %s a SHA1
+#: builtin/revert.c:442
+#, c-format
+msgid "%s: cannot parse parent commit %s"
+msgstr "%s: kan inte tolka f=C3=B6r=C3=A4ldraincheckningen %s"
+
+#: builtin/revert.c:446
+#, c-format
+msgid "Cannot get commit message for %s"
+msgstr "Kan inte h=C3=A4mta incheckningsmeddelande f=C3=B6r %s"
+
+#: builtin/revert.c:508
+#, c-format
+msgid "could not revert %s... %s"
+msgstr "kunde inte =C3=A5ngra %s... %s"
+
+#: builtin/revert.c:509
+#, c-format
+msgid "could not apply %s... %s"
+msgstr "kunde inte applicera %s... %s"
+
+#: builtin/revert.c:542
+msgid "empty commit set passed"
+msgstr "den angivna upps=C3=A4ttningen incheckningar =C3=A4r tom"
+
+#: builtin/revert.c:550
+#, c-format
+msgid "git %s: failed to read the index"
+msgstr "git %s: misslyckades l=C3=A4sa indexet"
+
+#: builtin/revert.c:555
+#, fuzzy, c-format
+msgid "git %s: failed to refresh the index"
+msgstr "git %s: misslyckades l=C3=A4sa indexet"
+
+#: builtin/revert.c:571
+msgid "cherry-pick --ff cannot be used with --signoff"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --signoff"
+
+#: builtin/revert.c:573
+msgid "cherry-pick --ff cannot be used with --no-commit"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --no-commit"
+
+#: builtin/revert.c:575
+msgid "cherry-pick --ff cannot be used with -x"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med -x"
+
+#: builtin/revert.c:577
+msgid "cherry-pick --ff cannot be used with --edit"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --edit"
+
+#: builtin/rm.c:109
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+"\"%s\" har k=C3=B6at =C3=A4ndringar som skiljer sig b=C3=A5de fr=C3=A5=
n filen och HEAD\n"
+"(anv=C3=A4nd -f f=C3=B6r att tvinga borttagning)"
+
+#: builtin/rm.c:115
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"\"%s\" har k=C3=B6ade =C3=A4ndringar i indexet\n"
+"(anv=C3=A4nd --cached f=C3=B6r att beh=C3=A5lla filen eller -f f=C3=B6=
r att tvinga borttagning)"
+
+#: builtin/rm.c:119
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"\"%s\" har lokala =C3=A4ndringar\n"
+"(anv=C3=A4nd --cached f=C3=B6r att beh=C3=A5lla filen eller -f f=C3=B6=
r att tvinga borttagning)"
+
+#: builtin/rm.c:194
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr "tar inte bort \"%s\" rekursivt utan -r"
+
+#: builtin/rm.c:230
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr "git rm: kan inte ta bort %s"
+
+#: builtin/shortlog.c:157
+#, c-format
+msgid "Missing author: %s"
+msgstr "Saknad f=C3=B6rfattare: %s"
+
+#: builtin/tag.c:121
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr "taggnamnet f=C3=B6r l=C3=A5ngt: %.*s..."
+
+#: builtin/tag.c:126
+#, c-format
+msgid "tag '%s' not found."
+msgstr "taggen \"%s\" hittades inte."
+
+#: builtin/tag.c:141
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr "Tog bort tagg \"%s\" (var %s)\n"
+
+#: builtin/tag.c:153
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr "kunde inte bekr=C3=A4fta taggen \"%s\""
+
+#: builtin/tag.c:168
+msgid "committer info too long."
+msgstr "incheckarinformation f=C3=B6r l=C3=A5ng."
+
+#: builtin/tag.c:188
+msgid "could not run gpg."
+msgstr "kunde inte k=C3=B6ra gpg."
+
+#: builtin/tag.c:194
+msgid "gpg did not accept the tag data"
+msgstr "gpg godtog inte taggdata"
+
+#: builtin/tag.c:201
+msgid "gpg failed to sign the tag"
+msgstr "gpg misslyckades signera taggen"
+
+#: builtin/tag.c:216
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"#\n"
+msgstr ""
+"\n"
+"#\n"
+"# Skriv ett taggmeddelande\n"
+"#\n"
+
+#: builtin/tag.c:224
+#, c-format
+msgid "signing key value too long (%.10s...)"
+msgstr "signeringsnyckelv=C3=A4rdet f=C3=B6r l=C3=A5ngt (%.10s...)"
+
+#: builtin/tag.c:264
+msgid "unable to sign the tag"
+msgstr "kunde inte signera taggen"
+
+#: builtin/tag.c:266
+msgid "unable to write tag file"
+msgstr "kunde inte skriva tagg-filen"
+
+#: builtin/tag.c:281
+msgid "bad object type."
+msgstr "felaktig objekttyp"
+
+#: builtin/tag.c:294
+msgid "tag header too big."
+msgstr "tagghuvud f=C3=B6r stort."
+
+#: builtin/tag.c:321
+msgid "no tag message?"
+msgstr "inget taggmeddelande?"
+
+#: builtin/tag.c:327
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr "Taggmeddelandet har l=C3=A4mnats i %s\n"
+
+#: builtin/tag.c:431
+msgid "-n option is only allowed with -l."
+msgstr "Flaggan -n =C3=A4r endast till=C3=A5ten tillsammans med -l."
+
+#: builtin/tag.c:433
+msgid "--contains option is only allowed with -l."
+msgstr "Flaggan --contains =C3=A4r endast till=C3=A5ten tillsammans me=
d -l"
+
+#: builtin/tag.c:441
+msgid "only one -F or -m option is allowed."
+msgstr "endast en av flaggorna -F eller -m till=C3=A5ts."
+
+#: builtin/tag.c:461
+msgid "too many params"
+msgstr "f=C3=B6r m=C3=A5nga parametrar"
+
+#: builtin/tag.c:467
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr "\"%s\" =C3=A4r inte ett giltigt taggnamn."
+
+#: builtin/tag.c:472
+#, c-format
+msgid "tag '%s' already exists"
+msgstr "taggen \"%s\" finns redan"
+
+#: builtin/tag.c:480
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr "%s: kan inte l=C3=A5sa referensen"
+
+#: builtin/tag.c:482
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr "%s: kan inte uppdatera referensen"
+
+#: builtin/tag.c:484
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr "Uppdaterad tagg \"%s\" (var %s)\n"
+
+#: git-am.sh:47
+msgid "You need to set your committer info first"
+msgstr "Du m=C3=A5ste st=C3=A4lla in din incheckarinformation f=C3=B6r=
st"
+
+#: git-am.sh:93
+msgid ""
+"You seem to have moved HEAD since the last 'am' failure.\n"
+"Not rewinding to ORIG_HEAD"
+msgstr ""
+
+#: git-am.sh:105
+#, sh-format
+msgid ""
+"When you have resolved this problem run \"$cmdline --resolved\".\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+"N=C3=A4r du har l=C3=B6st problemet k=C3=B6r du \"$cmdline --resolved=
\".\n"
+"Om du vill hoppa =C3=B6ver patchen k=C3=B6r du ist=C3=A4llet \"$cmdli=
ne --skip\".\n"
+"F=C3=B6r att =C3=A5terst=C3=A4lla originalgrenen och avbryta k=C3=B6r=
 du \"$cmdline --abort\"."
+
+#: git-am.sh:121
+msgid "Cannot fall back to three-way merge."
+msgstr "Kan inte falla tillbaka p=C3=A5 trev=C3=A4gssammanslagning."
+
+#: git-am.sh:136
+msgid "Repository lacks necessary blobs to fall back on 3-way merge."
+msgstr ""
+"Arkivet saknar objekt som beh=C3=B6vs f=C3=B6r att falla tillbaka p=C3=
=A5 3-"
+"v=C3=A4gssammanslagning."
+
+#: git-am.sh:145
+msgid ""
+"Did you hand edit your patch?\n"
+"It does not apply to blobs recorded in its index."
+msgstr ""
+"Vill du handredigera din patch?\n"
+"Den kan inte appliceras p=C3=A5 blobbar som antecknats i dess index."
+
+#: git-am.sh:154
+#, fuzzy
+msgid "Falling back to patching base and 3-way merge..."
+msgstr "Kan inte falla tillbaka p=C3=A5 trev=C3=A4gssammanslagning."
+
+#: git-am.sh:261
+msgid "Only one StGIT patch series can be applied at once"
+msgstr "Endast en StGIT-patchserie kan appliceras =C3=A5t g=C3=A5ngen"
+
+#: git-am.sh:313
+#, sh-format
+msgid "Patch format $patch_format is not supported."
+msgstr "Patchformatet $patch_format st=C3=B6ds inte."
+
+#: git-am.sh:315
+msgid "Patch format detection failed."
+msgstr "Misslyckades detektera patchformat."
+
+#: git-am.sh:365
+msgid "-d option is no longer supported.  Do not use."
+msgstr "Flaggan -d st=C3=B6ds inte l=C3=A4gre. Anv=C3=A4nd inte."
+
+#: git-am.sh:428
+#, sh-format
+msgid "previous rebase directory $dotest still exists but mbox given."
+msgstr "tidigare rebase-katalog $dotest finns redan, men mbox angavs."
+
+#: git-am.sh:433
+msgid "Please make up your mind. --skip or --abort?"
+msgstr "Best=C3=A4m dig. --skip eller --abort?"
+
+#: git-am.sh:460
+msgid "Resolve operation not in progress, we are not resuming."
+msgstr "L=C3=B6sningsoperation p=C3=A5g=C3=A5r inte, vi =C3=A5teruppta=
r inte."
+
+#: git-am.sh:525
+#, sh-format
+msgid "Dirty index: cannot apply patches (dirty: $files)"
+msgstr "Smutsigt index: kan inte applicera patchar (smutsiga: $files)"
+
+#: git-am.sh:614
+#, sh-format
+msgid ""
+"Patch is empty.  Was it split wrong?\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+"Patchen =C3=A4r tom. Delades den upp felaktigt?\n"
+"Om du vill hoppa =C3=B6ver patchen k=C3=B6r du ist=C3=A4llet \"$cmdli=
ne --skip\".\n"
+"F=C3=B6r att =C3=A5terst=C3=A4lla originalgrenen och avbryta k=C3=B6r=
 du \"$cmdline --abort\"."
+
+#: git-am.sh:651
+msgid "Patch does not have a valid e-mail address."
+msgstr "Patchen har inte n=C3=A5gon giltig e-postadress."
+
+#: git-am.sh:698
+msgid "cannot be interactive without stdin connected to a terminal."
+msgstr ""
+"kan inte vara interaktiv om standard in inte =C3=A4r ansluten till en=
 terminal."
+
+#: git-am.sh:702
+msgid "Commit Body is:"
+msgstr "Incheckningskroppen =C3=A4r:"
+
+#. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+#. in your translation. The program will only accept English
+#. input at this point.
+#: git-am.sh:709
+msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+msgstr "Applicera? Y=3Dja/N=3Dnej/E=3Dredigera/V=3Dvisa patch/A=3Dgodt=
a alla "
+
+#: git-am.sh:745
+#, sh-format
+msgid "Applying: $FIRSTLINE"
+msgstr "Applicerar: $FIRSTLINE"
+
+#: git-am.sh:766
+msgid ""
+"No changes - did you forget to use 'git add'?\n"
+"If there is nothing left to stage, chances are that something else\n"
+"already introduced the same changes; you might want to skip this patc=
h."
+msgstr ""
+"Inga =C3=A4ndrinar - gl=C3=B6mde du anv=C3=A4nda \"git add\"?\n"
+"Om det inte =C3=A4r n=C3=A5got kvar att k=C3=B6a kan det h=C3=A4nda a=
tt n=C3=A5gon annan redan\n"
+"introducerat samma =C3=A4ndringar; kanske du b=C3=B6r hoppa =C3=B6ver=
 patchen."
+
+#: git-am.sh:774
+msgid ""
+"You still have unmerged paths in your index\n"
+"did you forget to use 'git add'?"
+msgstr ""
+"Du har fortfarande s=C3=B6kv=C3=A4gar som inte slagits samman i ditt =
index\n"
+"gl=C3=B6mde du anv=C3=A4nda \"git add\"?"
+
+#: git-am.sh:790
+msgid "No changes -- Patch already applied."
+msgstr "Inga =C3=A4ndringar -- Patchen har redan applicerats."
+
+#: git-am.sh:800
+#, sh-format
+msgid "Patch failed at $msgnum $FIRSTLINE"
+msgstr "Patchen misslyckades vid $msgnum $FIRSTLINE"
+
+#: git-am.sh:816
+msgid "applying to an empty history"
+msgstr "applicerar p=C3=A5 en tom historik"
+
+#: git-bisect.sh:40
+#, fuzzy
+msgid "You need to start by \"git bisect start\""
+msgstr "Du m=C3=A5ste st=C3=A4lla in din incheckarinformation f=C3=B6r=
st"
+
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:48
+msgid "Do you want me to do it for you [Y/n]? "
+msgstr ""
+
+#: git-bisect.sh:67
+msgid "Bad HEAD - I need a HEAD"
+msgstr ""
+
+#: git-bisect.sh:86
+msgid "won't bisect on seeked tree"
+msgstr ""
+
+#: git-bisect.sh:90
+msgid "Bad HEAD - strange symbolic ref"
+msgstr ""
+
+#: git-bisect.sh:120
+#, sh-format
+msgid "'$arg' does not appear to be a valid revision"
+msgstr ""
+
+#: git-bisect.sh:165
+#, sh-format
+msgid "Bad bisect_write argument: $state"
+msgstr ""
+
+#: git-bisect.sh:193
+#, sh-format
+msgid "Bad rev input: $arg"
+msgstr ""
+
+#: git-bisect.sh:207
+msgid "Please call 'bisect_state' with at least one argument."
+msgstr ""
+
+#: git-bisect.sh:210
+msgid "Bad rev input: HEAD"
+msgstr ""
+
+#: git-bisect.sh:219
+#, sh-format
+msgid "Bad rev input: $rev"
+msgstr ""
+
+#: git-bisect.sh:225
+msgid "'git bisect bad' can take only one argument."
+msgstr ""
+
+#. have bad but not good.  we could bisect although
+#. this is less optimum.
+#: git-bisect.sh:249
+msgid "Warning: bisecting only with a bad commit."
+msgstr ""
+
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:257
+msgid "Are you sure [Y/n]? "
+msgstr ""
+
+#: git-bisect.sh:268
+msgid ""
+"You need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+
+#: git-bisect.sh:274
+msgid ""
+"You need to start by \"git bisect start\".\n"
+"You then need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+
+#: git-bisect.sh:330 git-bisect.sh:457
+msgid "We are not bisecting."
+msgstr ""
+
+#: git-bisect.sh:337
+#, fuzzy, sh-format
+msgid "'$invalid' is not a valid commit"
+msgstr "\"%s\" =C3=A4r inte en incheckning"
+
+#: git-bisect.sh:346
+#, sh-format
+msgid ""
+"Could not check out original HEAD '$branch'.\n"
+"Try 'git bisect reset <commit>'."
+msgstr ""
+
+#: git-bisect.sh:371
+msgid "No logfile given"
+msgstr ""
+
+#: git-bisect.sh:372
+#, fuzzy, sh-format
+msgid "cannot read $file for replaying"
+msgstr "kan inte l=C3=A4sa indexet"
+
+#: git-bisect.sh:388
+msgid "?? what are you talking about?"
+msgstr ""
+
+#: git-bisect.sh:400
+#, sh-format
+msgid "running $command"
+msgstr ""
+
+#: git-bisect.sh:407
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"exit code $res from '$command' is < 0 or >=3D 128"
+msgstr ""
+
+#: git-bisect.sh:433
+msgid "bisect run cannot continue any more"
+msgstr ""
+
+#: git-bisect.sh:441
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"'bisect_state $state' exited with error code $res"
+msgstr ""
+
+#: git-bisect.sh:449
+msgid "bisect run success"
+msgstr ""
+
+#: git-pull.sh:21
+msgid ""
+"Pull is not possible because you have unmerged files.\n"
+"Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
+"as appropriate to mark resolution, or use 'git commit -a'."
+msgstr ""
+
+#: git-pull.sh:25
+msgid "Pull is not possible because you have unmerged files."
+msgstr ""
+
+#: git-pull.sh:189
+msgid "updating an unborn branch with changes added to the index"
+msgstr ""
+
+#. The fetch involved updating the current branch.
+#. The working tree and the index file is still based on the
+#. $orig_head commit, but we are merging into $curr_head.
+#. First update the working tree to match $curr_head.
+#: git-pull.sh:221
+#, sh-format
+msgid ""
+"Warning: fetch updated the current branch head.\n"
+"Warning: fast-forwarding your working tree from\n"
+"Warning: commit $orig_head."
+msgstr ""
+
+#: git-pull.sh:248
+#, fuzzy
+msgid "Cannot merge multiple branches into empty head"
+msgstr "Kan endast sl=C3=A5 ihop en enda incheckning i ett tomt huvud.=
"
+
+#: git-pull.sh:252
+msgid "Cannot rebase onto multiple branches"
+msgstr ""
+
+#: git-stash.sh:43
+msgid "git stash clear with parameters is unimplemented"
+msgstr ""
+
+#: git-stash.sh:65
+#, fuzzy
+msgid "You do not have the initial commit yet"
+msgstr "Du har ingen giltig HEAD"
+
+#: git-stash.sh:80
+#, fuzzy
+msgid "Cannot save the current index state"
+msgstr "Kan inte komma =C3=A5t aktuell arbetskatalog"
+
+#: git-stash.sh:94 git-stash.sh:107
+#, fuzzy
+msgid "Cannot save the current worktree state"
+msgstr "Kan inte komma =C3=A5t aktuell arbetskatalog"
+
+#: git-stash.sh:111
+#, fuzzy
+msgid "No changes selected"
+msgstr "# Inga =C3=A4ndringar\n"
+
+#: git-stash.sh:114
+msgid "Cannot remove temporary index (can't happen)"
+msgstr ""
+
+#: git-stash.sh:127
+#, fuzzy
+msgid "Cannot record working tree state"
+msgstr "Kan inte komma =C3=A5t arbetskatalogen \"%s\""
+
+#: git-stash.sh:182
+msgid "No local changes to save"
+msgstr ""
+
+#: git-stash.sh:186
+msgid "Cannot initialize stash"
+msgstr ""
+
+#: git-stash.sh:194
+msgid "Cannot save the current status"
+msgstr ""
+
+#: git-stash.sh:207
+#, fuzzy
+msgid "Cannot remove worktree changes"
+msgstr "Kan inte komma =C3=A5t arbetskatalogen \"%s\""
+
+#: git-stash.sh:302
+msgid "No stash found."
+msgstr ""
+
+#: git-stash.sh:309
+#, fuzzy, sh-format
+msgid "Too many revisions specified: $REV"
+msgstr "F=C3=B6r m=C3=A5nga flaggor angavs"
+
+#: git-stash.sh:315
+#, fuzzy, sh-format
+msgid "$reference is not valid reference"
+msgstr "referensen =C3=A4r inte ett tr=C3=A4d: %s"
+
+#: git-stash.sh:340
+#, fuzzy, sh-format
+msgid "'$args' is not a stash-like commit"
+msgstr "\"%s\" =C3=A4r inte en incheckning"
+
+#: git-stash.sh:351
+#, sh-format
+msgid "'$args' is not a stash reference"
+msgstr ""
+
+#: git-stash.sh:359
+#, fuzzy
+msgid "unable to refresh index"
+msgstr "Kunde inte skriva indexet."
+
+#: git-stash.sh:363
+#, fuzzy
+msgid "Cannot apply a stash in the middle of a merge"
+msgstr "Kan inte utf=C3=B6ra en %s =C3=A5terst=C3=A4llning mitt i en s=
ammanslagning."
+
+#: git-stash.sh:371
+msgid "Conflicts in index. Try without --index."
+msgstr ""
+
+#: git-stash.sh:373
+#, fuzzy
+msgid "Could not save index tree"
+msgstr "Kunde inte l=C3=A4sa indexet"
+
+#: git-stash.sh:399
+msgid "Cannot unstage modified files"
+msgstr ""
+
+#: git-stash.sh:414
+#, fuzzy
+msgid "Index was not unstashed."
+msgstr "kunde k=C3=B6ra stash."
+
+#: git-stash.sh:433
+#, sh-format
+msgid "Dropped ${REV} ($s)"
+msgstr ""
+
+#: git-stash.sh:434
+#, sh-format
+msgid "${REV}: Could not drop stash entry"
+msgstr ""
+
+#: git-stash.sh:441
+#, fuzzy
+msgid "No branch name specified"
+msgstr "Misslyckades byta namn p=C3=A5 gren"
+
+#: git-stash.sh:512
+msgid "(To restore them type \"git stash apply\")"
+msgstr ""
+
+#: git-submodule.sh:38
+#, sh-format
+msgid "remote ($remote) does not have a url defined in .git/config"
+msgstr ""
+
+#: git-submodule.sh:56
+#, sh-format
+msgid "cannot strip one component off url '$remoteurl'"
+msgstr ""
+
+#: git-submodule.sh:108
+#, sh-format
+msgid "No submodule mapping found in .gitmodules for path '$path'"
+msgstr ""
+
+#: git-submodule.sh:132
+#, sh-format
+msgid "Clone of '$url' into submodule path '$path' failed"
+msgstr ""
+
+#: git-submodule.sh:205
+#, sh-format
+msgid "repo URL: '$repo' must be absolute or begin with ./|../"
+msgstr ""
+
+#: git-submodule.sh:222
+#, fuzzy, sh-format
+msgid "'$path' already exists in the index"
+msgstr "kan inte l=C3=A4sa indexet"
+
+#: git-submodule.sh:227
+#, sh-format
+msgid ""
+"The following path is ignored by one of your .gitignore files:\n"
+"$path\n"
+"Use -f if you really want to add it."
+msgstr ""
+
+#: git-submodule.sh:240
+#, sh-format
+msgid "Adding existing repo at '$path' to the index"
+msgstr ""
+
+#: git-submodule.sh:242
+#, fuzzy, sh-format
+msgid "'$path' already exists and is not a valid git repo"
+msgstr "destinationss=C3=B6kv=C3=A4gen \"%s\" finns redan och =C3=A4r =
inte en tom katalog."
+
+#: git-submodule.sh:265
+#, sh-format
+msgid "Unable to checkout submodule '$path'"
+msgstr ""
+
+#: git-submodule.sh:269
+#, fuzzy, sh-format
+msgid "Failed to add submodule '$path'"
+msgstr "Kunde inte l=C3=A4sa objektet \"%s\"."
+
+#: git-submodule.sh:274
+#, sh-format
+msgid "Failed to register submodule '$path'"
+msgstr ""
+
+#: git-submodule.sh:312
+#, sh-format
+msgid "Entering '$prefix$path'"
+msgstr ""
+
+#: git-submodule.sh:324
+#, sh-format
+msgid "Stopping at '$path'; script returned non-zero status."
+msgstr ""
+
+#: git-submodule.sh:367
+#, sh-format
+msgid "No url found for submodule path '$path' in .gitmodules"
+msgstr ""
+
+#: git-submodule.sh:377
+#, sh-format
+msgid "Failed to register url for submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:382
+#, sh-format
+msgid "Failed to register update mode for submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:384
+#, sh-format
+msgid "Submodule '$name' ($url) registered for path '$path'"
+msgstr ""
+
+#: git-submodule.sh:467
+#, sh-format
+msgid ""
+"Submodule path '$path' not initialized\n"
+"Maybe you want to use 'update --init'?"
+msgstr ""
+
+#: git-submodule.sh:480
+#, sh-format
+msgid "Unable to find current revision in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:504
+#, sh-format
+msgid "Unable to fetch in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:517
+#, sh-format
+msgid "Unable to rebase '$sha1' in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:518
+#, sh-format
+msgid "Submodule path '$path': rebased into '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:522
+#, fuzzy, sh-format
+msgid "Unable to merge '$sha1' in submodule path '$path'"
+msgstr "Kunde inte l=C3=A4sa objektet \"%s\"."
+
+#: git-submodule.sh:523
+#, sh-format
+msgid "Submodule path '$path': merged in '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:527
+#, fuzzy, sh-format
+msgid "Unable to checkout '$sha1' in submodule path '$path'"
+msgstr "Kunde inte l=C3=A4sa objektet \"%s\"."
+
+#: git-submodule.sh:528
+#, sh-format
+msgid "Submodule path '$path': checked out '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:539 git-submodule.sh:841
+#, sh-format
+msgid "Failed to recurse into submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:623
+msgid "--"
+msgstr ""
+
+#. unexpected type
+#: git-submodule.sh:664
+#, fuzzy, sh-format
+msgid "unexpected mode $mod_dst"
+msgstr "diff-status %c f=C3=B6rv=C3=A4ntades inte"
+
+#: git-submodule.sh:684
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_src"
+msgstr ""
+
+#: git-submodule.sh:687
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_dst"
+msgstr ""
+
+#: git-submodule.sh:690
+#, sh-format
+msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
+msgstr ""
+
+#: git-submodule.sh:715
+msgid "blob"
+msgstr ""
+
+#: git-submodule.sh:716
+msgid "submodule"
+msgstr ""
+
+#: git-submodule.sh:753
+#, fuzzy
+msgid "# Submodules changed but not updated:"
+msgstr "# =C3=84ndrade men inte uppdaterade:"
+
+#: git-submodule.sh:755
+#, fuzzy
+msgid "# Submodule changes to be committed:"
+msgstr "# =C3=84ndringar att checka in:"
+
+#: git-submodule.sh:885
+#, sh-format
+msgid "Synchronizing submodule url for '$name'"
+msgstr ""
+
+#~ msgid "# Changed but not updated:"
+#~ msgstr "# =C3=84ndrade men inte uppdaterade:"
+
+#~ msgid "could not parse commit %s"
+#~ msgstr "kunde inte tolka incheckningen %s"
+
+#~ msgid "Paths with --interactive does not make sense."
+#~ msgstr "Kan inte ange s=C3=B6kv=C3=A4gar med --interactive."
+
+#~ msgid "No HEAD commit to compare with (yet)"
+#~ msgstr "Ingen HEAD-incheckning att j=C3=A4mf=C3=B6ra med (=C3=A4nnu=
)"
+
+#~ msgid "cannot mix --fixed-strings and regexp"
+#~ msgstr "kan inte blanda --fixed-strings och regulj=C3=A4ra uttryck"
+
+#~ msgid "invalid --decorate option: %s"
+#~ msgstr "felaktigt v=C3=A4rde till --decorate: %s"
+
+#~ msgid "Failed to write current notes tree to database"
+#~ msgstr "Kunde inte skriva aktuellt anteckningstr=C3=A4d till databa=
sen"
+
+#~ msgid "Failed to commit notes tree to database"
+#~ msgstr "Kunde inte checka in anteckningstr=C3=A4d i databasen"
+
+# FIXME: Untranslatable!
+#
+#~ msgid "Refusing to %s notes in %s (outside of refs/notes/)"
+#~ msgstr "V=C3=A4grar %s anteckningar i %s (utanf=C3=B6r refs/notes/)=
"
+
+#~ msgid "list"
+#~ msgstr "list"
+
+#~ msgid "add"
+#~ msgstr "add"
+
+#~ msgid "copy"
+#~ msgstr "copy"
+
+#~ msgid "show"
+#~ msgstr "show"
+
+#~ msgid "remove"
+#~ msgstr "remove"
+
+#~ msgid "prune"
+#~ msgstr "prune"
+
+#~ msgid "The current branch %s is not tracking anything."
+#~ msgstr "Den aktuella grenen %s sp=C3=A5rar ingenting."
+
+#~ msgid "No destination configured to push to."
+#~ msgstr "Har inte st=C3=A4llt in n=C3=A5gon destination att s=C3=A4n=
da till."
+
+#~ msgid "Could not extract author email from %s"
+#~ msgstr "Kunde inte h=C3=A4mta f=C3=B6rfattarens e-postadress fr=C3=A5=
n %s"
+
+#~ msgid "Could not extract author time from %s"
+#~ msgstr "Kunde inte h=C3=A4mta f=C3=B6rfattartid fr=C3=A5n %s"
+
+#~ msgid "No author information found in %s"
+#~ msgstr "Hittade ingen f=C3=B6rfattarinformation i %s"
+
+#~ msgid "Cannot revert a root commit"
+#~ msgstr "Kan inte =C3=A5ngra en rotincheckning"
--=20
1.7.6.3
