From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 2/2] po/sv.po: Add Swedish translation.
Date: Mon, 20 Sep 2010 09:00:00 +0100
Message-ID: <0002.po.sv.po.Add.Swedish.translation.patch.20100920@softwolves.pp.se>
References: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, avarab@gmail.com, tp-sv@listor.tp-sv.se
X-From: git-owner@vger.kernel.org Mon Sep 20 10:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbJG-0004Qs-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab0ITIAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 04:00:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:61286 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657Ab0ITIAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:00:41 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9100BCSCX22A90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Sep 2010 10:00:38 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A05281EEEE3F_C9714A6B	for <git@vger.kernel.org>; Mon,
 20 Sep 2010 08:00:38 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5B9D71EEEDF7_C9714A6F	for <git@vger.kernel.org>; Mon,
 20 Sep 2010 08:00:38 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9100ISECX1AI40@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Sep 2010 10:00:38 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id 684742FBEE; Mon,
 20 Sep 2010 10:00:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156555>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 po/sv.po | 2967 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 2967 insertions(+), 0 deletions(-)
 create mode 100644 po/sv.po

This incorporates the bulk of the changes suggested by review on the Gi=
t
and TP-SV mailing lists.

diff --git a/po/sv.po b/po/sv.po
new file mode 100644
index 0000000..8c8242d
--- /dev/null
+++ b/po/sv.po
@@ -0,0 +1,2967 @@
+# Swedish translation of git
+# Copyright =C2=A9 2010 Peter krefting <peter@softwolves.pp.se>
+# Peter Krefting <peter@softwolves.pp.se>, 2010.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git 1.7.3\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-09-20 08:50+0100\n"
+"PO-Revision-Date: 2010-09-20 09:00+0100\n"
+"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+#: wt-status.c:56
+msgid "# Unmerged paths:"
+msgstr "# Ej sammanslagna s=C3=B6kv=C3=A4gar:"
+
+#: wt-status.c:62 wt-status.c:79
+#, c-format
+msgid "#   (use \"git reset %s <file>...\" to unstage)"
+msgstr "#   (anv=C3=A4nd \"git reset %s <fil>...\" f=C3=B6r att ta bor=
t fr=C3=A5n k=C3=B6)"
+
+#: wt-status.c:64 wt-status.c:81
+msgid "#   (use \"git rm --cached <file>...\" to unstage)"
+msgstr "#   (anv=C3=A4nd \"git rm --cached <fil>...\" f=C3=B6r att ta =
bort fr=C3=A5n k=C3=B6)"
+
+#: wt-status.c:65
+msgid "#   (use \"git add/rm <file>...\" as appropriate to mark resolu=
tion)"
+msgstr "#   (anv=C3=A4nd \"git add/rm <fil>...\" som l=C3=A4mpligt f=C3=
=B6r att ange l=C3=B6sning)"
+
+#: wt-status.c:73
+msgid "# Changes to be committed:"
+msgstr "# =C3=84ndringar att checka in:"
+
+#: wt-status.c:91
+msgid "# Changed but not updated:"
+msgstr "# =C3=84ndrade men inte uppdaterade:"
+
+#: wt-status.c:95
+msgid "#   (use \"git add <file>...\" to update what will be committed=
)"
+msgstr ""
+"#   (anv=C3=A4nd \"git add <fil>...\" f=C3=B6r att uppdatera vad som =
skall checkas in)"
+
+#: wt-status.c:97
+msgid "#   (use \"git add/rm <file>...\" to update what will be commit=
ted)"
+msgstr ""
+"#   (anv=C3=A4nd \"git add/rm <fil>...\" f=C3=B6r att uppdatera vad s=
om skall checkas "
+"in)"
+
+#: wt-status.c:98
+msgid ""
+"#   (use \"git checkout -- <file>...\" to discard changes in working =
"
+"directory)"
+msgstr ""
+"#   (anv=C3=A4nd \"git checkout -- <fil>...\" f=C3=B6r att f=C3=B6rka=
sta =C3=A4ndringar i "
+"arbetskatalogen)"
+
+#: wt-status.c:100
+msgid "#   (commit or discard the untracked or modified content in sub=
modules)"
+msgstr ""
+"#   (checka in eller f=C3=B6rkasta osp=C3=A5rat eller =C3=A4ndrat inn=
eh=C3=A5ll i undermoduler)"
+
+#: wt-status.c:109
+#, c-format
+msgid "# %s files:"
+msgstr "# %s filer:"
+
+#: wt-status.c:112
+#, c-format
+msgid "#   (use \"git %s <file>...\" to include in what will be commit=
ted)"
+msgstr ""
+"#   (anv=C3=A4nd \"git %s <fil>...\" f=C3=B6r att ta med i vad som sk=
all checkas in)"
+
+#: wt-status.c:129
+msgid "bug"
+msgstr "programfel"
+
+#: wt-status.c:134
+msgid "both deleted:"
+msgstr "borttaget av b=C3=A4gge:"
+
+#: wt-status.c:135
+msgid "added by us:"
+msgstr "tillagt av oss:"
+
+#: wt-status.c:136
+msgid "deleted by them:"
+msgstr "borttaget av dem:"
+
+#: wt-status.c:137
+msgid "added by them:"
+msgstr "tillagt av dem:"
+
+#: wt-status.c:138
+msgid "deleted by us:"
+msgstr "borttaget av oss:"
+
+#: wt-status.c:139
+msgid "both added:"
+msgstr "tillagt av b=C3=A4gge:"
+
+#: wt-status.c:140
+msgid "both modified:"
+msgstr "=C3=A4ndrat av b=C3=A4gge:"
+
+#: wt-status.c:170
+msgid "new commits, "
+msgstr "nya incheckningar, "
+
+#: wt-status.c:172
+msgid "modified content, "
+msgstr "=C3=A4ndrat inneh=C3=A5ll, "
+
+#: wt-status.c:174
+msgid "untracked content, "
+msgstr "osp=C3=A5rat inneh=C3=A5ll, "
+
+#: wt-status.c:188
+#, c-format
+msgid "new file:   %s"
+msgstr "ny fil:     %s"
+
+#: wt-status.c:191
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr "kopierad:   %s -> %s"
+
+#: wt-status.c:194
+#, c-format
+msgid "deleted:    %s"
+msgstr "borttagen:  %s"
+
+#: wt-status.c:197
+#, c-format
+msgid "modified:   %s"
+msgstr "=C3=A4ndrad:     %s"
+
+#: wt-status.c:200
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr "namnbyte:   %s -> %s"
+
+#: wt-status.c:203
+#, c-format
+msgid "typechange: %s"
+msgstr "typbyte:    %s"
+
+#: wt-status.c:206
+#, c-format
+msgid "unknown:    %s"
+msgstr "ok=C3=A4nd:      %s"
+
+#: wt-status.c:209
+#, c-format
+msgid "unmerged:   %s"
+msgstr "osammansl.: %s"
+
+#: wt-status.c:212
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr "programfel: diff-status %c ej hanterad"
+
+#: wt-status.c:635
+msgid "On branch "
+msgstr "P=C3=A5 grenen "
+
+#: wt-status.c:642
+msgid "Not currently on any branch."
+msgstr "Inte p=C3=A5 n=C3=A5gon gren f=C3=B6r n=C3=A4rvarande."
+
+#: wt-status.c:652
+msgid "# Initial commit"
+msgstr "# Grundincheckning"
+
+#: wt-status.c:666
+msgid "Untracked"
+msgstr "Osp=C3=A5rad"
+
+#: wt-status.c:668
+msgid "Ignored"
+msgstr "Ignorerad"
+
+#: wt-status.c:670
+#, c-format
+msgid "# Untracked files not listed%s\n"
+msgstr "# Osp=C3=A5rade filer visas ej%s\n"
+
+#: wt-status.c:672
+msgid " (use -u option to show untracked files)"
+msgstr " (anv=C3=A4nd flaggan -u f=C3=B6r att visa osp=C3=A5rade filer=
)"
+
+#: wt-status.c:678
+#, c-format
+msgid "# No changes\n"
+msgstr "# Inga =C3=A4ndringar\n"
+
+#: wt-status.c:682
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr "inga =C3=A4ndringar att checka in%s\n"
+
+#: wt-status.c:684
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr " (anv=C3=A4nd \"git add\" och/eller \"git commit -a\")"
+
+#: wt-status.c:686
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr "inget k=C3=B6at f=C3=B6r incheckning, men osp=C3=A5rade filer =
finns%s\n"
+
+#: wt-status.c:688
+msgid " (use \"git add\" to track)"
+msgstr " (anv=C3=A4nd \"git add\" f=C3=B6r att sp=C3=A5ra)"
+
+#: wt-status.c:691
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr " (skapa/kopiera filer och anv=C3=A4nd \"git add\" f=C3=B6r att=
 sp=C3=A5ra)"
+
+#: wt-status.c:693 wt-status.c:696
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr "inget att checka in%s\n"
+
+#: wt-status.c:694
+msgid " (use -u to show untracked files)"
+msgstr " (anv=C3=A4nd -u f=C3=B6r att visa osp=C3=A5rade filer)"
+
+#: wt-status.c:697
+msgid " (working directory clean)"
+msgstr " (arbetskatalogen ren)"
+
+#: wt-status.c:795
+msgid "HEAD (no branch)"
+msgstr "HEAD (ingen gren)"
+
+#: wt-status.c:801
+msgid "Initial commit on "
+msgstr "Grundincheckning p=C3=A5 "
+
+#: wt-status.c:816
+msgid "behind "
+msgstr "efter "
+
+#: wt-status.c:819 wt-status.c:822
+msgid "ahead "
+msgstr "f=C3=B6re "
+
+#: wt-status.c:824
+msgid ", behind "
+msgstr ", efter "
+
+#: builtin/add.c:41
+#, c-format
+msgid "unexpected diff status %c"
+msgstr "ov=C3=A4ntad diff-status %c"
+
+#: builtin/add.c:67 builtin/commit.c:244
+msgid "updating files failed"
+msgstr "misslyckades uppdatera filer"
+
+#: builtin/add.c:77
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
+msgstr "Ok=C3=B6ade =C3=A4ndringar efter att ha uppdaterat indexet:"
+
+#: builtin/add.c:194 builtin/add.c:452 builtin/rm.c:194
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
+#: builtin/add.c:349
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr "Anv=C3=A4nd -f om du verkligen vill l=C3=A4gga till dem.\n"
+
+#: builtin/add.c:350
+msgid "no files added"
+msgstr "inga filer har lagts till"
+
+#: builtin/add.c:356
+msgid "adding files failed"
+msgstr "misslyckades l=C3=A4gga till filer"
+
+#: builtin/add.c:388
+msgid "-A and -u are mutually incompatible"
+msgstr "-A och -u =C3=A4r =C3=B6msesidigt inkompatibla"
+
+#: builtin/add.c:390
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr "Flaggan --ignore-missing kan endast anv=C3=A4ndas tillsammans =
med --dry-run"
+
+#: builtin/add.c:410
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr "Inget angivet, inget tillagt.\n"
+
+#: builtin/add.c:411
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr "Kanske menade du att skriva \"git add .\"?\n"
+
+#: builtin/add.c:417 builtin/clean.c:95 builtin/commit.c:301
+#: builtin/commit.c:310 builtin/mv.c:77 builtin/rm.c:171
+msgid "index file corrupt"
+msgstr "indexfilen trasig"
+
+#: builtin/add.c:468 builtin/mv.c:223 builtin/rm.c:268
+msgid "Unable to write new index file"
+msgstr "Kunde inte skriva ny indexfil"
+
+#: builtin/archive.c:17
+#, c-format
+msgid "could not create archive file '%s'"
+msgstr "kunde inte skapa arkivfilen \"%s\""
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
+#, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but it is not yet merged to HEAD."
+msgstr ""
+"tar bort grenen \"%s\" som har slagits ihop med\n"
+"         \"%s\", men som =C3=A4nnu inte slagits ihop med HEAD."
+
+#: builtin/branch.c:140
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+"tar inte bort grenen \"%s\" som =C3=A4nnu inte har slagits ihop med\n=
"
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
+msgstr "Kunde inte sl=C3=A5 upp incheckningsobjektet f=C3=B6r \"%s\""
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
+#: builtin/branch.c:381
+#, c-format
+msgid "behind %d] "
+msgstr "bakom %d] "
+
+#: builtin/branch.c:383
+#, c-format
+msgid "ahead %d] "
+msgstr "f=C3=B6re %d] "
+
+#: builtin/branch.c:385
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr "f=C3=B6re %d, bakom %d] "
+
+#: builtin/branch.c:484
+msgid "(no branch)"
+msgstr "(ingen gren)"
+
+#: builtin/branch.c:544
+msgid "some refs could not be read"
+msgstr "vissa referenser kunde inte l=C3=A4sas"
+
+#: builtin/branch.c:557
+msgid "cannot rename the current branch while not on any."
+msgstr "kan inte byta namn p=C3=A5 aktuell gren n=C3=A4r du inte befin=
ner dig p=C3=A5 n=C3=A5gon."
+
+#: builtin/branch.c:567 builtin/branch.c:571
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr "Felaktigt grennamn: \"%s\""
+
+#: builtin/branch.c:574
+#, c-format
+msgid "A branch named '%s' already exists."
+msgstr "Det finns redan en gren som heter \"%s\"."
+
+#: builtin/branch.c:580
+msgid "Branch rename failed"
+msgstr "Misslyckades byta grennamn"
+
+#: builtin/branch.c:584
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr "Bytte bort namn p=C3=A5 en felaktigt namngiven gren \"%s\""
+
+#: builtin/branch.c:588
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr "Grenen namnbytt till %s, men HEAD har inte uppdaterats!"
+
+#: builtin/branch.c:595
+msgid "Branch is renamed, but update of config-file failed"
+msgstr "Grenen namnbytt, men misslyckades uppdatera konfigurationsfile=
n"
+
+#: builtin/branch.c:610
+#, c-format
+msgid "malformed object name %s"
+msgstr "felformat objektnamn %s"
+
+#: builtin/branch.c:680
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr "Misslyckades sl=C3=A5 upp HEAD som giltig referens"
+
+#: builtin/branch.c:686
+msgid "HEAD not found below refs/heads!"
+msgstr "HEAD hittades inte under refs/heads!"
+
+#: builtin/branch.c:706
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
+#: builtin/checkout.c:107 builtin/checkout.c:135
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte v=C3=A5r version"
+
+#: builtin/checkout.c:109 builtin/checkout.c:137
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte deras version"
+
+#: builtin/checkout.c:120
+#, c-format
+msgid "path '%s' does not have all three versions"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte alla tre versionerna"
+
+#: builtin/checkout.c:155
+#, c-format
+msgid "path '%s' does not have all 3 versions"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte alla 3 versionerna"
+
+#: builtin/checkout.c:172
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr "s=C3=B6kv=C3=A4g \"%s\": kan inte sl=C3=A5 ihop"
+
+#: builtin/checkout.c:189
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr "Kunde inte l=C3=A4gga till sammanslagningsresultat f=C3=B6r \"=
%s\""
+
+#: builtin/checkout.c:194 builtin/reset.c:170
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr "make_cache_entry misslyckades f=C3=B6r s=C3=B6kv=C3=A4gen \"%s=
\""
+
+#: builtin/checkout.c:216 builtin/checkout.c:371
+msgid "corrupt index file"
+msgstr "indexfilen =C3=A4r trasig"
+
+#: builtin/checkout.c:244 builtin/checkout.c:251
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr "s=C3=B6kv=C3=A4gen \"%s\" har inte slagits ihop"
+
+#: builtin/checkout.c:280 builtin/checkout.c:475 builtin/clone.c:658
+#: builtin/merge.c:737
+msgid "unable to write new index file"
+msgstr "kunde inte skriva ny indexfil"
+
+#: builtin/checkout.c:297 builtin/diff.c:307 builtin/merge.c:367
+msgid "diff_setup_done failed"
+msgstr "diff_setup_done misslyckades"
+
+#: builtin/checkout.c:393
+msgid "you need to resolve your current index first"
+msgstr "du m=C3=A5ste l=C3=B6sa ditt befintliga index f=C3=B6rst"
+
+#: builtin/checkout.c:524
+#, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr "Kan inte skapa referenslog f=C3=B6r \"%s\"\n"
+
+#: builtin/checkout.c:550
+#, c-format
+msgid "Already on '%s'\n"
+msgstr "Redan p=C3=A5 \"%s\"\n"
+
+#: builtin/checkout.c:554
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr "Bytte till och nollst=C3=A4llde grenen \"%s\"\n"
+
+#: builtin/checkout.c:556
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr "Bytte till en ny gren \"%s\"\n"
+
+#: builtin/checkout.c:558
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr "Bytte till grenen \"%s\"\n"
+
+#: builtin/checkout.c:575
+msgid "HEAD is now at"
+msgstr "HEAD =C3=A4r nu p=C3=A5"
+
+#: builtin/checkout.c:603
+msgid "You are on a branch yet to be born"
+msgstr "Du =C3=A4r p=C3=A5 en gren som =C3=A4nnu inte finns"
+
+#: builtin/checkout.c:617
+msgid "Previous HEAD position was"
+msgstr "Tidigare position f=C3=B6r HEAD var"
+
+#: builtin/checkout.c:730
+msgid "-B cannot be used with -b"
+msgstr "-B kan inte anv=C3=A4ndas med -b"
+
+#: builtin/checkout.c:738
+msgid "--patch is incompatible with all other options"
+msgstr "--patch =C3=A4r inkompatibel med alla andra flaggor"
+
+#: builtin/checkout.c:744
+msgid "--track needs a branch name"
+msgstr "--track beh=C3=B6ver ett grennamn"
+
+#: builtin/checkout.c:751
+msgid "Missing branch name; try -b"
+msgstr "Grennamn saknas; f=C3=B6rs=C3=B6k med -b"
+
+#: builtin/checkout.c:757
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr "--orphan och -b|-B kan inte anv=C3=A4ndas samtidigt"
+
+#: builtin/checkout.c:759
+msgid "--orphan cannot be used with -t"
+msgstr "--orphan kan inte anv=C3=A4ndas med -t"
+
+#: builtin/checkout.c:769
+msgid "git checkout: -f and -m are incompatible"
+msgstr "git checkout: -f och -m =C3=A4r inkompatibla"
+
+#. case (1)
+#: builtin/checkout.c:815
+#, c-format
+msgid "invalid reference: %s"
+msgstr "felaktig referens: %s"
+
+#. case (1): want a tree
+#: builtin/checkout.c:852
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr "referensen =C3=A4r inte ett tr=C3=A4d: %s"
+
+#: builtin/checkout.c:878
+msgid "invalid path specification"
+msgstr "felaktig s=C3=B6kv=C3=A4gsangivelse"
+
+#: builtin/checkout.c:886
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+"git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibelt med =
att byta gren.\n"
+"Ville du checka ut \"%s\" som inte kan l=C3=B6sas som en sammanslanin=
g?"
+
+#: builtin/checkout.c:888
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibe=
lt med att byta gren."
+
+#: builtin/checkout.c:893
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+"git checkout: --ours/--theirs, --force och --merge =C3=A4r inkompatib=
la n=C3=A4r\n"
+"du checkar ut fr=C3=A5n indexet."
+
+#: builtin/checkout.c:904
+#, c-format
+msgid "git checkout: we do not like '%s' as a branch name."
+msgstr "git checkout: vi tycker inte om \"%s\" som grennamn."
+
+#: builtin/checkout.c:909
+#, c-format
+msgid "git checkout: branch %s already exists"
+msgstr "git checkout: grenen %s finns redan"
+
+#: builtin/checkout.c:916
+msgid "Cannot switch branch to a non-commit."
+msgstr "Kan inte byta gren p=C3=A5 en icke-incheckning."
+
+#: builtin/checkout.c:919
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr "--ours/--theirs =C3=A4r inkompatibla n=C3=A4r du byta gren."
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
+#, c-format
+msgid "failed to remove '%s'"
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
+#: builtin/clone.c:208
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr "referensarkivet \"%s\" =C3=A4r inte en lokal katalog."
+
+#: builtin/clone.c:235
+#, c-format
+msgid "failed to open '%s'"
+msgstr "misslyckades =C3=B6ppna \"%s\""
+
+#: builtin/clone.c:239
+#, c-format
+msgid "failed to create directory '%s'"
+msgstr "misslyckades skapa katalogen \"%s\""
+
+#: builtin/clone.c:241 builtin/diff.c:74
+#, c-format
+msgid "failed to stat '%s'"
+msgstr "misslyckades ta status p=C3=A5 \"%s\""
+
+#: builtin/clone.c:243
+#, c-format
+msgid "%s exists and is not a directory"
+msgstr "%s finns och =C3=A4r ingen katalog"
+
+#: builtin/clone.c:257
+#, c-format
+msgid "failed to stat %s\n"
+msgstr "misslyckades ta status p=C3=A5 %s\n"
+
+#: builtin/clone.c:267
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr "misslyckades ta bort l=C3=A4nken \"%s\""
+
+#: builtin/clone.c:272
+#, c-format
+msgid "failed to create link '%s'"
+msgstr "misslyckades skapa l=C3=A4nken \"%s\""
+
+#: builtin/clone.c:276
+#, c-format
+msgid "failed to copy file to '%s'"
+msgstr "misslyckades kopiera filen till \"%s\""
+
+#: builtin/clone.c:305
+#, c-format
+msgid "done.\n"
+msgstr "klart.\n"
+
+#: builtin/clone.c:387
+msgid "Too many arguments."
+msgstr "F=C3=B6r m=C3=A5nga argument."
+
+#: builtin/clone.c:391
+msgid "You must specify a repository to clone."
+msgstr "Du m=C3=A5ste ange ett arkiv att klona."
+
+#: builtin/clone.c:399
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr "flaggorna --bare och --origin %s =C3=A4r inkompatibla."
+
+#: builtin/clone.c:428
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr "destinationss=C3=B6kv=C3=A4gen \"%s\" finns redan och =C3=A4r =
inte en tom katalog."
+
+#: builtin/clone.c:438
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr "arbetstr=C3=A4det \"%s\" finns redan."
+
+#: builtin/clone.c:451 builtin/clone.c:465
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr "kunde inte skapa inledande kataloger f=C3=B6r \"%s\""
+
+#: builtin/clone.c:454
+#, c-format
+msgid "could not create work tree dir '%s'."
+msgstr "kunde inte skapa arbetskatalogen \"%s\""
+
+#: builtin/clone.c:470
+#, c-format
+msgid "Cloning into bare repository %s"
+msgstr "Klonar till ett naket arkiv %s"
+
+#: builtin/clone.c:472
+#, c-format
+msgid "Cloning into %s"
+msgstr "Klonar till %s"
+
+#: builtin/clone.c:530
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr "Vet inte hur man klonar %s"
+
+#: builtin/clone.c:569
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr ""
+"Fj=C3=A4rrgrenen %s hittades inte i uppstr=C3=B6msarkivet %s, anv=C3=A4=
nder HEAD ist=C3=A4llet"
+
+#: builtin/clone.c:579
+msgid "You appear to have cloned an empty repository."
+msgstr "Du verkar ha klonat ett tomt arkiv."
+
+#: builtin/clone.c:621
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr ""
+"HEAD hos fj=C3=A4rren pekar p=C3=A5 en obefintlig referens, kan inte =
checka ut.\n"
+
+#: builtin/commit.c:41
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
+#: builtin/commit.c:271
+msgid "failed to unpack HEAD tree object"
+msgstr "misslyckades packa upp HEAD-tr=C3=A4dobjektet"
+
+#: builtin/commit.c:299
+msgid "interactive add failed"
+msgstr "interaktiv till=C3=A4ggning misslyckades"
+
+#: builtin/commit.c:330 builtin/commit.c:350 builtin/commit.c:396
+msgid "unable to write new_index file"
+msgstr "kunde inte skriva filen new_index"
+
+#: builtin/commit.c:380
+msgid "cannot do a partial commit during a merge."
+msgstr "kan inte utf=C3=B6ra en partiell incheckning under en sammansl=
agning."
+
+#: builtin/commit.c:389
+msgid "cannot read the index"
+msgstr "kan inte l=C3=A4sa indexet"
+
+#: builtin/commit.c:409
+msgid "unable to write temporary index file"
+msgstr "kunde inte skriva tempor=C3=A4r indexfil"
+
+#: builtin/commit.c:456 builtin/commit.c:1294
+msgid "could not parse HEAD commit"
+msgstr "kunde inte tolka HEAD-incheckningen"
+
+#: builtin/commit.c:475 builtin/commit.c:481
+#, c-format
+msgid "invalid commit: %s"
+msgstr "felaktig incheckning: %s"
+
+#: builtin/commit.c:499
+msgid "malformed --author parameter"
+msgstr "felformad \"--author\"-flagga"
+
+#: builtin/commit.c:573 builtin/shortlog.c:299
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr "(l=C3=A4ser loggmeddelande fr=C3=A5n standard in)\n"
+
+#: builtin/commit.c:575
+msgid "could not read log from standard input"
+msgstr "kunde inte l=C3=A4sa logg fr=C3=A5n standard in"
+
+#: builtin/commit.c:579
+#, c-format
+msgid "could not read log file '%s'"
+msgstr "kunde inte l=C3=A4sa loggfilen \"%s\""
+
+#: builtin/commit.c:585
+msgid "commit has empty message"
+msgstr "incheckningen har ett tomt meddelande"
+
+#: builtin/commit.c:591
+msgid "could not read MERGE_MSG"
+msgstr "kunde inte l=C3=A4sa MERGE_MSG"
+
+#: builtin/commit.c:595
+msgid "could not read SQUASH_MSG"
+msgstr "kunde inte l=C3=A4sa SQUASH_MSG"
+
+#: builtin/commit.c:599
+#, c-format
+msgid "could not read '%s'"
+msgstr "kunde inte l=C3=A4sa \"%s\""
+
+#: builtin/commit.c:612
+#, c-format
+msgid "could not open '%s'"
+msgstr "kunde inte =C3=B6ppna \"%s\""
+
+#: builtin/commit.c:636
+msgid "could not write commit template"
+msgstr "kunde inte skriva incheckningsmall"
+
+#: builtin/commit.c:650
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
+"# Det verkar som du checkar in en SAMMANSLAGNING.\n"
+"# Om det inte st=C3=A4mmer s=C3=A5 ta bort filen\n"
+"#\t%s\n"
+"# och f=C3=B6rs=C3=B6k igen.\n"
+"#\n"
+
+#: builtin/commit.c:659
+#, c-format
+msgid ""
+"\n"
+"# Please enter the commit message for your changes."
+msgstr ""
+"\n"
+"# Ange ett incheckningsmeddelande f=C3=B6r dina =C3=A4ndringar."
+
+#: builtin/commit.c:663
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be ignored, and an empty message aborts the commit.\n=
"
+msgstr ""
+" Rader som inleds\n"
+"# med \"#\" kommer att ignoreras, och ett tomt meddelande avbryter "
+"incheckningen.\n"
+
+#: builtin/commit.c:668
+#, c-format
+msgid ""
+" Lines starting\n"
+"# with '#' will be kept; you may remove them yourself if you want to.=
\n"
+"# An empty message aborts the commit.\n"
+msgstr ""
+" Rader som inleds\n"
+"# med \"#\" kommer att beh=C3=A5llas; du kan sj=C3=A4lv ta bort dem o=
m du vill.\n"
+"# Ett tomt meddelande avbryter incheckningen.\n"
+
+#: builtin/commit.c:680
+#, c-format
+msgid "%s# Author:    %s\n"
+msgstr "%s# F=C3=B6rfattare: %s\n"
+
+#: builtin/commit.c:688
+#, c-format
+msgid "%s# Committer: %s\n"
+msgstr "%s# Incheckare: %s\n"
+
+#: builtin/commit.c:705
+msgid "Cannot read index"
+msgstr "Kan inte l=C3=A4sa indexet"
+
+#: builtin/commit.c:737
+msgid "Error building trees"
+msgstr "Fel vid skapande av tr=C3=A4d"
+
+#: builtin/commit.c:752 builtin/tag.c:321
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr "Ange meddelandet med en av flaggorna -m eller -F.\n"
+
+#: builtin/commit.c:832
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr "Hittade ingen befintlig f=C3=B6rfattare med \"%s\""
+
+#: builtin/commit.c:847 builtin/commit.c:1039
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr "Ogiltigt l=C3=A4ge f=C3=B6r osp=C3=A5rade filer: \"%s\""
+
+#: builtin/commit.c:864
+msgid "Using both --reset-author and --author does not make sense"
+msgstr "Kan inte anv=C3=A4nda b=C3=A5de --reset-author och --author"
+
+#: builtin/commit.c:878
+msgid "You have nothing to amend."
+msgstr "Du har inget att ut=C3=B6ka."
+
+#: builtin/commit.c:880
+msgid "You are in the middle of a merge -- cannot amend."
+msgstr "Du =C3=A4r i mitten av en sammanslagning -- kan inte ut=C3=B6k=
a."
+
+#: builtin/commit.c:889
+msgid "Only one of -c/-C/-F can be used."
+msgstr "Kan endast anv=C3=A4nda en av -c/-C/-F."
+
+#: builtin/commit.c:891
+msgid "Option -m cannot be combined with -c/-C/-F."
+msgstr "Flaggan -m kan inte kombineras med -c/-C/-F."
+
+#: builtin/commit.c:897
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr "--reset-author kan endast anv=C3=A4ndas med -C, -c eller --ame=
nd."
+
+#: builtin/commit.c:906
+#, c-format
+msgid "could not lookup commit %s"
+msgstr "kunde inte sl=C3=A5 upp incheckningen %s"
+
+#: builtin/commit.c:909
+#, c-format
+msgid "could not parse commit %s"
+msgstr "kunde inte tolka incheckningen %s"
+
+#: builtin/commit.c:937
+msgid "Only one of --include/--only/--all/--interactive can be used."
+msgstr "Endast en av --include/--only/--all/--interactive kan anv=C3=A4=
ndas."
+
+#: builtin/commit.c:939
+msgid "No paths with --include/--only does not make sense."
+msgstr "Du m=C3=A5ste ange s=C3=B6kv=C3=A4gar tillsammans med --includ=
e/--only."
+
+#: builtin/commit.c:941
+msgid "Clever... amending the last one with dirty index."
+msgstr "Smart... ut=C3=B6ka den senaste med smutsigt index."
+
+#: builtin/commit.c:943
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr "Explicita s=C3=B6kv=C3=A4gar angavs utan -i eller -o; antar --=
only-s=C3=B6kv=C3=A4gar..."
+
+#: builtin/commit.c:953
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr "Felaktigt st=C3=A4dningsl=C3=A4ge %s"
+
+#: builtin/commit.c:958
+msgid "Paths with -a does not make sense."
+msgstr "Kan inte ange s=C3=B6kv=C3=A4gar med -a."
+
+#: builtin/commit.c:960
+msgid "Paths with --interactive does not make sense."
+msgstr "Kan inte ange s=C3=B6kv=C3=A4gar med --interactive."
+
+#: builtin/commit.c:1142
+msgid "couldn't look up newly created commit"
+msgstr "kunde inte hitta en nyskapad incheckning"
+
+#: builtin/commit.c:1144
+msgid "could not parse newly created commit"
+msgstr "kunde inte tolka en nyskapad incheckning"
+
+#: builtin/commit.c:1185
+msgid "detached HEAD"
+msgstr "fr=C3=A5nkopplad HEAD"
+
+#: builtin/commit.c:1187
+msgid " (root-commit)"
+msgstr " (rotincheckning)"
+
+#: builtin/commit.c:1307 builtin/merge.c:461
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr "kunde inte =C3=B6ppna \"%s\" f=C3=B6r l=C3=A4sning"
+
+#: builtin/commit.c:1312
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr "Trasig MERGE_HEAD-fil (%s)"
+
+#: builtin/commit.c:1319
+msgid "could not read MERGE_MODE"
+msgstr "kunde inte l=C3=A4sa MERGE_MODE"
+
+#: builtin/commit.c:1336
+#, c-format
+msgid "could not read commit message: %s"
+msgstr "kunde inte l=C3=A4sa incheckningsmeddelande: %s"
+
+#: builtin/commit.c:1350
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr "Avbryter p=C3=A5 grund av tomt incheckningsmeddelande.\n"
+
+#: builtin/commit.c:1358
+msgid "failed to write commit object"
+msgstr "kunde inte skriva incheckningsobjekt"
+
+#: builtin/commit.c:1375
+msgid "cannot lock HEAD ref"
+msgstr "kan inte l=C3=A5sa HEAD-referensen"
+
+#: builtin/commit.c:1379
+msgid "cannot update HEAD ref"
+msgstr "kan inte uppdatera HEAD-referensen"
+
+#: builtin/commit.c:1388
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
+#: builtin/describe.c:205
+#, c-format
+msgid "annotated tag %s not available"
+msgstr "den annoterade taggen %s inte tillg=C3=A4nglig"
+
+#: builtin/describe.c:209
+#, c-format
+msgid "annotated tag %s has no embedded name"
+msgstr "den annoterade taggen %s har inget inb=C3=A4ddat namn"
+
+#: builtin/describe.c:211
+#, c-format
+msgid "tag '%s' is really '%s' here"
+msgstr "taggen \"%s\" =C3=A4r i verkligheten \"%s\" h=C3=A4r"
+
+#: builtin/describe.c:238
+#, c-format
+msgid "Not a valid object name %s"
+msgstr "Objektnamnet =C3=A4r inte giltigt: %s"
+
+#: builtin/describe.c:241
+#, c-format
+msgid "%s is not a valid '%s' object"
+msgstr "%s =C3=A4r inte ett giltigt \"%s\"-objekt"
+
+#: builtin/describe.c:258
+#, c-format
+msgid "no tag exactly matches '%s'"
+msgstr "ingen tagg motsvarar \"%s\" exakt"
+
+#: builtin/describe.c:260
+#, c-format
+msgid "searching to describe %s\n"
+msgstr "s=C3=B6ker f=C3=B6r att beskriva %s\n"
+
+#: builtin/describe.c:295
+#, c-format
+msgid "finished search at %s\n"
+msgstr "avslutade s=C3=B6kning p=C3=A5 %s\n"
+
+#: builtin/describe.c:319
+#, c-format
+msgid ""
+"No annotated tags can describe '%s'.\n"
+"However, there were unannotated tags: try --tags."
+msgstr ""
+"Inga annoterade taggar kan beskriva \"%s\".\n"
+"Det finns dock icke-annoterade taggar: testa --tags."
+
+#: builtin/describe.c:323
+#, c-format
+msgid ""
+"No tags can describe '%s'.\n"
+"Try --always, or create some tags."
+msgstr ""
+"Inga taggar kan beskriva \"%s\".\n"
+"Testa --always, eller skapa n=C3=A5gra taggar."
+
+#: builtin/describe.c:344
+#, c-format
+msgid "traversed %lu commits\n"
+msgstr "traverserade %lu incheckningar\n"
+
+#: builtin/describe.c:347
+#, c-format
+msgid ""
+"more than %i tags found; listed %i most recent\n"
+"gave up search at %s\n"
+msgstr ""
+"mer =C3=A4n %i taggar hittades; listar de %i senaste\n"
+"gav upp s=C3=B6kningen vid %s\n"
+
+#: builtin/describe.c:398
+msgid "--long is incompatible with --abbrev=3D0"
+msgstr "--long =C3=A4r inkompatibel med --abbrev=3D0"
+
+#: builtin/describe.c:423
+msgid "No names found, cannot describe anything."
+msgstr "Inga namn hittades, kan inte beskriva n=C3=A5got."
+
+#: builtin/describe.c:430
+msgid "--dirty is incompatible with committishes"
+msgstr "--dirty =C3=A4r inkompatibelt med \"committish\"-v=C3=A4rden"
+
+#: builtin/diff.c:76
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr "\"%s\": inte en normal fil eller symbolisk l=C3=A4nk"
+
+#: builtin/diff.c:225
+#, c-format
+msgid "invalid option: %s"
+msgstr "ogiltig flagga: %s"
+
+#: builtin/diff.c:302
+msgid "Not a git repository"
+msgstr "Inte ett git-arkiv"
+
+#: builtin/diff.c:334
+msgid "No HEAD commit to compare with (yet)"
+msgstr "Ingen HEAD-incheckning att j=C3=A4mf=C3=B6ra med (=C3=A4nnu)"
+
+#: builtin/diff.c:349
+#, c-format
+msgid "invalid object '%s' given."
+msgstr "objektet \"%s\" som angavs =C3=A4r felaktigt."
+
+#: builtin/diff.c:354
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr "mer =C3=A4n %d tr=C3=A4d angavs: \"%s\""
+
+#: builtin/diff.c:364
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr "mer =C3=A4n tv=C3=A5 blobbar angavs: \"%s\""
+
+#: builtin/diff.c:372
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr "ej hanterat objekt \"%s\" angavs."
+
+#: builtin/fetch.c:172
+msgid "Couldn't find remote ref HEAD"
+msgstr "Kunde inte hitta fj=C3=A4rr-referensen HEAD"
+
+#: builtin/fetch.c:225
+#, c-format
+msgid "object %s not found"
+msgstr "objektet %s hittades inte"
+
+#: builtin/fetch.c:230
+msgid "[up to date]"
+msgstr "[=C3=A0 jour]"
+
+#.
+#. * If this is the head, and it's not okay to update
+#. * the head, and the old value of the head isn't empty...
+#.
+#: builtin/fetch.c:243
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr "! %-*s %-*s -> %s  (kan inte h=C3=A4mta i aktuell gren)"
+
+#: builtin/fetch.c:244 builtin/fetch.c:306
+msgid "[rejected]"
+msgstr "[refuserad]"
+
+#: builtin/fetch.c:254
+msgid "[tag update]"
+msgstr "[uppdaterad tagg]"
+
+#: builtin/fetch.c:255 builtin/fetch.c:277 builtin/fetch.c:290
+msgid "  (unable to update local ref)"
+msgstr "  (kunde inte uppdatera lokal ref)"
+
+#: builtin/fetch.c:267
+msgid "[new tag]"
+msgstr "[ny tagg]"
+
+#: builtin/fetch.c:271
+msgid "[new branch]"
+msgstr "[ny gren]"
+
+#: builtin/fetch.c:302
+msgid "unable to update local ref"
+msgstr "kunde inte uppdatera lokal ref"
+
+#: builtin/fetch.c:302
+msgid "forced update"
+msgstr "tvingad uppdatering"
+
+#: builtin/fetch.c:307
+msgid "(non-fast-forward)"
+msgstr "(ej snabbspolad)"
+
+#: builtin/fetch.c:325 builtin/fetch.c:648
+#, c-format
+msgid "cannot open %s: %s\n"
+msgstr "kan inte =C3=B6ppna %s: %s\n"
+
+#: builtin/fetch.c:403
+#, c-format
+msgid "From %.*s\n"
+msgstr "Fr=C3=A5n %.*s\n"
+
+#: builtin/fetch.c:414
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
+#: builtin/fetch.c:464
+msgid "could not run rev-list"
+msgstr "kunde inte k=C3=B6ra rev-list"
+
+#: builtin/fetch.c:478
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr "kunde inte skriva till rev-list: %s"
+
+#: builtin/fetch.c:485
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr "kunde inte st=C3=A4nga rev-list:s standard in: %s"
+
+#: builtin/fetch.c:512
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr "   (%s kommer bli dinglande)\n"
+
+#: builtin/fetch.c:513
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr "   (%s har blivit dinglande)\n"
+
+#: builtin/fetch.c:520
+msgid "[deleted]"
+msgstr "[borttagen]"
+
+#: builtin/fetch.c:521
+msgid "(none)"
+msgstr "(ingen)"
+
+#: builtin/fetch.c:638
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr "V=C3=A4grar h=C3=A4mta till aktuell gren %s i ett icke-naket a=
rkiv"
+
+#: builtin/fetch.c:672
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr "Vet inte hur man h=C3=A4mtar fr=C3=A5n %s"
+
+#: builtin/fetch.c:726
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr "Flaggan \"%s\" och v=C3=A4rdet \"%s\" =C3=A4r inte giltigt f=C3=
=B6r %s"
+
+#: builtin/fetch.c:729
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr "Flaggan \"%s\" ignoreras f=C3=B6r %s\n"
+
+#: builtin/fetch.c:818
+#, c-format
+msgid "Fetching %s\n"
+msgstr "H=C3=A4mtar %s\n"
+
+#: builtin/fetch.c:820
+#, c-format
+msgid "Could not fetch %s"
+msgstr "Kunde inte h=C3=A4mta %s"
+
+#: builtin/fetch.c:836
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr ""
+"Inget fj=C3=A4rrarkiv angavs. Ange antingen en URL eller namnet p=C3=A5=
 ett\n"
+"fj=C3=A4rrarkiv som nya incheckningar skall h=C3=A4mtas fr=C3=A5n."
+
+#: builtin/fetch.c:856
+msgid "You need to specify a tag name."
+msgstr "Du m=C3=A5ste ange namnet p=C3=A5 en tagg."
+
+#: builtin/fetch.c:896
+msgid "fetch --all does not take a repository argument"
+msgstr "fetch --all tar inte namnet p=C3=A5 ett arkiv som argument"
+
+#: builtin/fetch.c:898
+msgid "fetch --all does not make sense with refspecs"
+msgstr "fetch --all kan inte anges med referensspecifikationer"
+
+#: builtin/fetch.c:909
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr "Fj=C3=A4rren eller fj=C3=A4rrgruppen finns inte: %s"
+
+#: builtin/fetch.c:917
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr ""
+"Det =C3=A4r inte m=C3=B6jligt att h=C3=A4mta fr=C3=A5n grupp och samt=
idigt ange ref."
+"specifikationer"
+
+#: builtin/gc.c:63
+#, c-format
+msgid "Invalid %s: '%s'"
+msgstr "Felaktig %s: \"%s\""
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
+#: builtin/gc.c:220
+#, c-format
+msgid "Auto packing the repository for optimum performance.\n"
+msgstr "Packar arkivet automatiskt f=C3=B6r optimal prestanda.\n"
+
+#: builtin/gc.c:223
+#, c-format
+msgid ""
+"Auto packing the repository for optimum performance. You may also\n"
+"run \"git gc\" manually. See \"git help gc\" for more information."
+msgstr ""
+"Packar arkivet automatiskt f=C3=B6r optimal prestanda. Du kan =C3=A4v=
en\n"
+"k=C3=B6ra \"git gc\" manuellt. Se \"git help gc\" f=C3=B6r mer inform=
ation."
+
+#: builtin/gc.c:251
+msgid ""
+"There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
+msgstr ""
+"Det finns f=C3=B6r m=C3=A5nga on=C3=A5bara l=C3=B6sa objekt; k=C3=B6r=
 \"git prune\" f=C3=B6r att ta bort "
+"dem."
+
+#: builtin/grep.c:252
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr "grep: misslyckades skapa tr=C3=A5d: %s"
+
+#: builtin/grep.c:457
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr "\"%s\" kunde inte l=C3=A4sa %s"
+
+#: builtin/grep.c:508
+#, c-format
+msgid "'%s': %s"
+msgstr "\"%s\": %s"
+
+#: builtin/grep.c:519
+#, c-format
+msgid "'%s': short read %s"
+msgstr "\"%s\": kort l=C3=A4sning %s"
+
+#: builtin/grep.c:581
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr "Kunde inte byta katalog (chdir): %s"
+
+#: builtin/grep.c:671 builtin/grep.c:697
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr "kunde inte l=C3=A4sa tr=C3=A4d (%s)"
+
+#: builtin/grep.c:703
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr "Kunde inte utf=C3=B6ra texts=C3=B6kning (grep) fr=C3=A5n objek=
t av typen %s"
+
+#: builtin/grep.c:755
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr "flaggan \"%c\" f=C3=B6rv=C3=A4ntar ett numeriskt v=C3=A4rde"
+
+#: builtin/grep.c:771
+#, c-format
+msgid "cannot open '%s'"
+msgstr "kan inte =C3=B6ppna \"%s\""
+
+#: builtin/grep.c:1012
+msgid "no pattern given."
+msgstr "inget m=C3=B6nster angavs."
+
+#: builtin/grep.c:1016
+msgid "cannot mix --fixed-strings and regexp"
+msgstr "kan inte blanda --fixed-strings och regulj=C3=A4ra uttryck"
+
+#: builtin/grep.c:1041
+#, c-format
+msgid "bad object %s"
+msgstr "felaktigt objekt %s"
+
+#: builtin/grep.c:1068
+msgid "--open-files-in-pager only works on the worktree"
+msgstr "--open-files-in-pager fungerar endast i arbetskatalogen"
+
+#: builtin/grep.c:1093
+msgid "--cached cannot be used with --no-index."
+msgstr "--cached kan inte anv=C3=A4ndas med --no-index."
+
+#: builtin/grep.c:1095
+msgid "--no-index cannot be used with revs."
+msgstr "--no-index kan inte anv=C3=A4ndas med revisioner."
+
+#: builtin/grep.c:1104
+msgid "both --cached and trees are given."
+msgstr "b=C3=A5de --cached och tr=C3=A4d angavs."
+
+#: builtin/init-db.c:34
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Kunde inte g=C3=B6ra %s skrivbar f=C3=B6r gruppen"
+
+#: builtin/init-db.c:61
+#, c-format
+msgid "insanely long template name %s"
+msgstr "tokigt l=C3=A5ngt namn p=C3=A5 mallen %s"
+
+#: builtin/init-db.c:66
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "kan inte ta status p=C3=A5 \"%s\""
+
+#: builtin/init-db.c:72
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "kan inte ta status p=C3=A5 mallen \"%s\""
+
+#: builtin/init-db.c:79
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "kan inte =C3=B6ppna katalogen (opendir) \"%s\""
+
+#: builtin/init-db.c:96
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "kan inte l=C3=A4sa l=C3=A4nken (readlink) \"%s\""
+
+#: builtin/init-db.c:98
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "tokigt l=C3=A5ng symbolisk l=C3=A4nk %s"
+
+#: builtin/init-db.c:101
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "kan inte skapa symbolisk l=C3=A4nk \"%s\" \"%s\""
+
+#: builtin/init-db.c:105
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "kan inte kopiera \"%s\" till \"%s\""
+
+#: builtin/init-db.c:109
+#, c-format
+msgid "ignoring template %s"
+msgstr "ignorerar mallen %s"
+
+#: builtin/init-db.c:132
+#, c-format
+msgid "insanely long template path %s"
+msgstr "tokigt l=C3=A5ng malls=C3=B6kv=C3=A4g %s"
+
+#: builtin/init-db.c:140
+#, c-format
+msgid "templates not found %s"
+msgstr "mallarna hittades inte %s"
+
+#: builtin/init-db.c:153
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "kopierade inte mallar fr=C3=A5n felaktig formatversion %d fr=C3=
=A5n \"%s\""
+
+#: builtin/init-db.c:191
+#, c-format
+msgid "insane git directory %s"
+msgstr "tokig git-katalog %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#: builtin/init-db.c:355
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git-arkiv i %s%s\n"
+
+#: builtin/init-db.c:356
+msgid "Reinitialized existing"
+msgstr "Ominitierade befintligt"
+
+#: builtin/init-db.c:356
+msgid "Initialized empty"
+msgstr "Initierade tomt"
+
+# Adding "och" for readability
+#: builtin/init-db.c:357
+msgid " shared"
+msgstr " och delat"
+
+#: builtin/init-db.c:376
+msgid "cannot tell cwd"
+msgstr "kan inte avg=C3=B6ra aktuell katalog (cwd)"
+
+#: builtin/init-db.c:450 builtin/init-db.c:457
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "kan inte skapa katalogen (mkdir) %s"
+
+#: builtin/init-db.c:461
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "kan inte byta katalog (chdir) till %s"
+
+#: builtin/init-db.c:483
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
+#: builtin/init-db.c:509
+msgid "Cannot access current working directory"
+msgstr "Kan inte komma =C3=A5t aktuell arbetskatalog"
+
+#: builtin/init-db.c:512
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Kan inte komma =C3=A5t arbetskatalogen \"%s\""
+
+#: builtin/log.c:104
+#, c-format
+msgid "invalid --decorate option: %s"
+msgstr "felaktigt v=C3=A4rde till --decorate: %s"
+
+#: builtin/log.c:113 builtin/log.c:1138 builtin/shortlog.c:287
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "ok=C3=A4nt argument: %s"
+
+#: builtin/log.c:156
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr "Slututdata: %d %s\n"
+
+#: builtin/log.c:255 builtin/log.c:674 builtin/log.c:1222 builtin/log.=
c:1428
+#: builtin/merge.c:310 builtin/revert.c:556 builtin/shortlog.c:184
+msgid "revision walk setup failed"
+msgstr "misslyckades skapa revisionstraversering"
+
+#: builtin/log.c:347 builtin/log.c:434
+#, c-format
+msgid "Could not read object %s"
+msgstr "Kunde inte l=C3=A4sa objektet %s"
+
+#: builtin/log.c:458
+#, c-format
+msgid "Unknown type: %d"
+msgstr "Ok=C3=A4nd typ: %d"
+
+#: builtin/log.c:558
+msgid "format.headers without value"
+msgstr "format.headers utan v=C3=A4rde"
+
+#: builtin/log.c:630
+msgid "name of output directory is too long"
+msgstr "namnet p=C3=A5 utdatakatalogen =C3=A4r f=C3=B6r l=C3=A5ngt"
+
+#: builtin/log.c:641
+#, c-format
+msgid "Cannot open patch file %s"
+msgstr "Kan inte =C3=B6ppna patchfilen %s"
+
+#: builtin/log.c:655
+msgid "Need exactly one range."
+msgstr "Beh=C3=B6ver precis ett intervall."
+
+#: builtin/log.c:663
+msgid "Not a range."
+msgstr "Inte ett intervall."
+
+#: builtin/log.c:700
+msgid "Could not extract email from committer identity."
+msgstr "Kunde inte extrahera e-postadress fr=C3=A5n incheckarens ident=
itet."
+
+#: builtin/log.c:732
+msgid "Cover letter needs email format"
+msgstr "Omslagsbrevet beh=C3=B6ver e-postformat"
+
+#: builtin/log.c:825
+#, c-format
+msgid "insane in-reply-to: %s"
+msgstr "tokigt in-reply-to: %s"
+
+#: builtin/log.c:898
+msgid "Two output directories?"
+msgstr "Tv=C3=A5 utdatakataloger?"
+
+#: builtin/log.c:1087
+#, c-format
+msgid "bogus committer info %s"
+msgstr "felaktig incheckarinformation %s"
+
+#: builtin/log.c:1132
+msgid "-n and -k are mutually exclusive."
+msgstr "-n och -k kan inte anv=C3=A4ndas samtidigt."
+
+#: builtin/log.c:1134
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr "--subject-prefix och -k kan inte anv=C3=A4ndas samtidigt."
+
+#: builtin/log.c:1141
+msgid "--name-only does not make sense"
+msgstr "kan inte anv=C3=A4nda --name-only"
+
+#: builtin/log.c:1143
+msgid "--name-status does not make sense"
+msgstr "kan inte anv=C3=A4nda --name-status"
+
+#: builtin/log.c:1145
+msgid "--check does not make sense"
+msgstr "kan inte anv=C3=A4nda --check"
+
+#: builtin/log.c:1166
+msgid "standard output, or directory, which one?"
+msgstr "standard ut, eller katalog, vilket skall det vara?"
+
+#: builtin/log.c:1168
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr "Kunde inte skapa katalogen \"%s\""
+
+#: builtin/log.c:1307
+msgid "Failed to create output files"
+msgstr "Misslyckades skapa utdatafiler"
+
+#: builtin/log.c:1394
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr "Kunde inte hitta en sp=C3=A5rad fj=C3=A4rrgren, ange <uppstr=C3=
=B6m> manuellt.\n"
+
+#: builtin/log.c:1410 builtin/log.c:1412 builtin/log.c:1424
+#, c-format
+msgid "Unknown commit %s"
+msgstr "Ok=C3=A4nd incheckning %s"
+
+#: builtin/merge.c:82
+msgid "switch `m' requires a value"
+msgstr "flaggan \"m\" beh=C3=B6ver ett v=C3=A4rde"
+
+#: builtin/merge.c:119
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr "Kunde inte hitta sammanslagningsstrategin \"%s\".\n"
+
+#: builtin/merge.c:120
+#, c-format
+msgid "Available strategies are:"
+msgstr "Tillg=C3=A4ngliga strategier =C3=A4r:"
+
+#: builtin/merge.c:125
+#, c-format
+msgid "Available custom strategies are:"
+msgstr "Tillg=C3=A4ngliga skr=C3=A4ddarsydda strategier =C3=A4r:"
+
+#: builtin/merge.c:223
+msgid "could not run stash."
+msgstr "kunde inte k=C3=B6ra stash."
+
+#: builtin/merge.c:228
+msgid "stash failed"
+msgstr "stash misslyckades"
+
+#: builtin/merge.c:233
+#, c-format
+msgid "not a valid object: %s"
+msgstr "inte ett giltigt objekt: %s"
+
+#: builtin/merge.c:250
+msgid "read-tree failed"
+msgstr "read-tree misslyckades"
+
+#: builtin/merge.c:279
+msgid " (nothing to squash)"
+msgstr " (inget att platta till)"
+
+#: builtin/merge.c:292
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr "Tillplattningsincheckning -- uppdaterar inte HEAD\n"
+
+#: builtin/merge.c:295 builtin/merge.c:1290 builtin/merge.c:1299
+#: builtin/merge.c:1309
+#, c-format
+msgid "Could not write to '%s'"
+msgstr "Kunde inte skriva till \"%s\""
+
+#: builtin/merge.c:323
+msgid "Writing SQUASH_MSG"
+msgstr "Skriver SQUASH_MSG"
+
+#: builtin/merge.c:325
+msgid "Finishing SQUASH_MSG"
+msgstr "Avslutar SQUASH_MSG"
+
+#: builtin/merge.c:345
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr "Inget sammanslagningsmeddelande -- uppdaterar inte HEAD\n"
+
+#: builtin/merge.c:396
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr "\"%s\" pekar inte p=C3=A5 en incheckning"
+
+#: builtin/merge.c:491
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr "Felaktig branch.%s.mergeoptions-str=C3=A4ng: %s"
+
+#: builtin/merge.c:553
+msgid "git write-tree failed to write a tree"
+msgstr "git write--tree misslyckades skriva ett tr=C3=A4d"
+
+#: builtin/merge.c:594
+msgid "failed to read the cache"
+msgstr "misslyckads l=C3=A4sa cachen"
+
+#: builtin/merge.c:611
+msgid "Unable to write index."
+msgstr "Kunde inte skriva indexet."
+
+#: builtin/merge.c:624
+msgid "Not handling anything other than two heads merge."
+msgstr "Hanterar inte n=C3=A5got annat =C3=A4n en sammanslagning av tv=
=C3=A5 huvuden."
+
+#: builtin/merge.c:651
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr "Felaktig flagga f=C3=B6r \"merge-recursive\": -X%s"
+
+#: builtin/merge.c:666
+#, c-format
+msgid "unable to write %s"
+msgstr "kunde inte skriva %s"
+
+#: builtin/merge.c:791
+#, c-format
+msgid "Wonderful.\n"
+msgstr "Underbart.\n"
+
+#: builtin/merge.c:840 builtin/merge.c:1287 builtin/merge.c:1295
+#: builtin/merge.c:1303
+#, c-format
+msgid "Could not open '%s' for writing"
+msgstr "Kunde inte =C3=B6ppna \"%s\" f=C3=B6r skrivning"
+
+#: builtin/merge.c:856
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr ""
+"Kunde inte sl=C3=A5 ihop automatiskt; fixa konflikter och checka in r=
esultatet.\n"
+
+#: builtin/merge.c:871
+#, c-format
+msgid "'%s' is not a commit"
+msgstr "\"%s\" =C3=A4r inte en incheckning"
+
+#: builtin/merge.c:921
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"Du har inte avslutat sammanslagningen (MERGE_HEAD finns).\n"
+"Checka in dina =C3=A4ndringar innan du kan sl=C3=A5 ihop."
+
+#: builtin/merge.c:924
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr "Du har inte avslutat sammanslagningen (MERGE_HEAD finns)."
+
+#: builtin/merge.c:951
+msgid "You cannot combine --squash with --no-ff."
+msgstr "Du kan inte kombinera --squash med --no-ff."
+
+#: builtin/merge.c:956
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr "Du kan inte kombinera --no-ff med --ff-only."
+
+#: builtin/merge.c:984
+msgid "Can merge only exactly one commit into empty head"
+msgstr "Kan endast sl=C3=A5 ihop en enda incheckning i ett tomt huvud.=
"
+
+#: builtin/merge.c:987
+msgid "Squash commit into empty head not supported yet"
+msgstr "St=C3=B6der inte en tillplattningsincheckning p=C3=A5 ett tomt=
 huvud =C3=A4nnu"
+
+#: builtin/merge.c:989
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr "Icke-snabbspolad incheckning kan inte anv=C3=A4ndas med ett to=
mt huvud"
+
+#: builtin/merge.c:993 builtin/merge.c:1041
+#, c-format
+msgid "%s - not something we can merge"
+msgstr "%s - inte n=C3=A5got vi kan sl=C3=A5 ihop"
+
+#: builtin/merge.c:1099
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr "Uppdaterar %s..%s\n"
+
+#: builtin/merge.c:1133
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr "F=C3=B6rs=C3=B6ker riktigt enkel sammanslagning i indexet...\n=
"
+
+#: builtin/merge.c:1137
+#, c-format
+msgid "Nope.\n"
+msgstr "Nej.\n"
+
+#: builtin/merge.c:1170
+msgid "Not possible to fast-forward, aborting."
+msgstr "Kan inte snabbspola, avbryter."
+
+#: builtin/merge.c:1196 builtin/merge.c:1269
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr "=C3=85terspolar tr=C3=A4det till of=C3=B6rd=C3=A4rvat...\n"
+
+#: builtin/merge.c:1200
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr "F=C3=B6rs=C3=B6ker sammanslagninsstrategin %s...\n"
+
+#: builtin/merge.c:1261
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr "Ingen sammanslagningsstrategi hanterade sammanslagningen.\n"
+
+#: builtin/merge.c:1263
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr "Sammanslaning med strategin %s misslyckades.\n"
+
+#: builtin/merge.c:1271
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr "Anv=C3=A4nder strategin %s f=C3=B6r att f=C3=B6rbereda l=C3=B6=
sning f=C3=B6r hand.\n"
+
+#: builtin/merge.c:1314
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
+msgstr "namnbytet av \"%s\" misslyckades"
+
+#: builtin/notes.c:122
+#, c-format
+msgid "unable to start 'show' for object '%s'"
+msgstr "kunde inte starta \"show\" f=C3=B6r objektet \"%s\""
+
+#: builtin/notes.c:128
+msgid "can't fdopen 'show' output fd"
+msgstr "kunde inte =C3=B6ppna (fdopen) \"show\"-utdata-filhandtag"
+
+#: builtin/notes.c:138
+#, c-format
+msgid "failed to close pipe to 'show' for object '%s'"
+msgstr "kunde inte st=C3=A4nga r=C3=B6ret till \"show\" f=C3=B6r objek=
tet \"%s\""
+
+#: builtin/notes.c:141
+#, c-format
+msgid "failed to finish 'show' for object '%s'"
+msgstr "kunde inte avsluta \"show\" f=C3=B6r objektet \"%s\""
+
+#: builtin/notes.c:158 builtin/tag.c:311
+#, c-format
+msgid "could not create file '%s'"
+msgstr "kunde inte skapa filen \"%s\""
+
+#: builtin/notes.c:172
+msgid "Please supply the note contents using either -m or -F option"
+msgstr "Ange inneh=C3=A5ll f=C3=B6r anteckningen med antingen -m eller=
 -F"
+
+#: builtin/notes.c:193 builtin/notes.c:797
+#, c-format
+msgid "Removing note for object %s\n"
+msgstr "Tar bort anteckning f=C3=B6r objektet %s\n"
+
+#: builtin/notes.c:198
+msgid "unable to write note object"
+msgstr "kunde inte skriva anteckningsobjekt"
+
+#: builtin/notes.c:200
+#, c-format
+msgid "The note contents has been left in %s"
+msgstr "Anteckningens inneh=C3=A5ll har l=C3=A4mnats kvar i %s"
+
+#: builtin/notes.c:234 builtin/tag.c:445
+#, c-format
+msgid "cannot read '%s'"
+msgstr "kan inte l=C3=A4sa \"%s\""
+
+#: builtin/notes.c:236 builtin/tag.c:448
+#, c-format
+msgid "could not open or read '%s'"
+msgstr "kunde inte =C3=B6ppna eller l=C3=A4sa \"%s\""
+
+#: builtin/notes.c:255 builtin/notes.c:444 builtin/notes.c:446
+#: builtin/notes.c:508 builtin/notes.c:560 builtin/notes.c:631
+#: builtin/notes.c:636 builtin/notes.c:710 builtin/notes.c:752
+#: builtin/notes.c:789 builtin/reset.c:303 builtin/tag.c:461
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr "Kunde inte sl=C3=A5 upp \"%s\" som en giltig referens."
+
+#: builtin/notes.c:258
+#, c-format
+msgid "Failed to read object '%s'."
+msgstr "Kunde inte l=C3=A4sa objektet \"%s\"."
+
+#: builtin/notes.c:283
+msgid "Cannot commit uninitialized/unreferenced notes tree"
+msgstr "Kan inte checka in oinitierat/orefererat anteckningstr=C3=A4d"
+
+#: builtin/notes.c:295
+msgid "Failed to write current notes tree to database"
+msgstr "Kunde inte skriva aktuellt anteckningstr=C3=A4d till databasen=
"
+
+#: builtin/notes.c:307
+msgid "Failed to commit notes tree to database"
+msgstr "Kunde inte checka in anteckningstr=C3=A4d i databasen"
+
+#: builtin/notes.c:339
+#, c-format
+msgid "Bad notes.rewriteMode value: '%s'"
+msgstr "Felaktigt v=C3=A4rde f=C3=B6r notes.rewriteMode: '%s'"
+
+#: builtin/notes.c:349
+#, c-format
+msgid "Refusing to rewrite notes in %s (outside of refs/notes/)"
+msgstr "V=C3=A4grar skriva =C3=B6ver anteckningar i %s (utanf=C3=B6r r=
efs/notes/)"
+
+#. TRANSLATORS: The first %s is the name of the
+#. environment variable, the second %s is its value
+#: builtin/notes.c:376
+#, c-format
+msgid "Bad %s value: '%s'"
+msgstr "Felaktigt v=C3=A4rde p=C3=A5 %s: \"%s\""
+
+#: builtin/notes.c:440
+#, c-format
+msgid "Malformed input line: '%s'."
+msgstr "Felaktig indatarad: \"%s\"."
+
+#: builtin/notes.c:455
+#, c-format
+msgid "Failed to copy notes from '%s' to '%s'"
+msgstr "Misslyckades kopiera anteckningar fr=C3=A5n \"%s\" till \"%s\"=
"
+
+# FIXME: Untranslatable!
+#
+#. TRANSLATORS: The first %s is one of "git notes ACTION",
+#. e.g. "add", "copy", "append" etc.
+#: builtin/notes.c:481
+#, c-format
+msgid "Refusing to %s notes in %s (outside of refs/notes/)"
+msgstr "V=C3=A4grar %s anteckningar i %s (utanf=C3=B6r refs/notes/)"
+
+#: builtin/notes.c:501 builtin/notes.c:553 builtin/notes.c:614
+#: builtin/notes.c:626 builtin/notes.c:698 builtin/notes.c:745
+#: builtin/notes.c:782 builtin/notes.c:821
+msgid "too many parameters"
+msgstr "f=C3=B6r m=C3=A5nga parametrar"
+
+#: builtin/notes.c:505
+msgid "list"
+msgstr "lista"
+
+#: builtin/notes.c:514 builtin/notes.c:758
+#, c-format
+msgid "No note found for object %s."
+msgstr "Inga anteckningar hittades f=C3=B6r objektet %s."
+
+#: builtin/notes.c:562
+msgid "add"
+msgstr "l=C3=A4gga till"
+
+#: builtin/notes.c:567
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
+#: builtin/notes.c:572 builtin/notes.c:649
+#, c-format
+msgid "Overwriting existing notes for object %s\n"
+msgstr "Skriver =C3=B6ver befintliga anteckningar f=C3=B6r objektet %s=
\n"
+
+#: builtin/notes.c:622
+msgid "too few parameters"
+msgstr "f=C3=B6r f=C3=A5 parametrar"
+
+#: builtin/notes.c:638
+msgid "copy"
+msgstr "kopiera"
+
+#: builtin/notes.c:643
+#, c-format
+msgid ""
+"Cannot copy notes. Found existing notes for object %s. Use '-f' to ov=
erwrite "
+"existing notes"
+msgstr ""
+"Kan inte kopiera anteckningar. Hittade befintliga anteckningar f=C3=B6=
r objektet %"
+"s. Anv=C3=A4nd \"-f\" f=C3=B6r att skriva =C3=B6ver befintliga anteck=
ningar"
+
+#: builtin/notes.c:655
+#, c-format
+msgid "Missing notes on source object %s. Cannot copy."
+msgstr "Anteckningar p=C3=A5 k=C3=A4llobjektet %s saknas. Kan inte kop=
iera."
+
+#: builtin/notes.c:703
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
+#: builtin/notes.c:754
+msgid "show"
+msgstr "visa"
+
+#: builtin/notes.c:791
+msgid "remove"
+msgstr "ta bort"
+
+#: builtin/notes.c:795
+#, c-format
+msgid "Object %s has no note\n"
+msgstr "Objektet %s har ingen anteckning\n"
+
+#: builtin/notes.c:825
+msgid "prune"
+msgstr "rensa"
+
+#: builtin/notes.c:877
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
+msgid "You are not currently on a branch."
+msgstr "Du =C3=A4r inte p=C3=A5 n=C3=A5gon gren f=C3=B6r n=C3=A4rvaran=
de."
+
+#: builtin/push.c:74
+#, c-format
+msgid "The current branch %s is not tracking anything."
+msgstr "Den aktuella grenen %s sp=C3=A5rar ingenting."
+
+#: builtin/push.c:77
+#, c-format
+msgid "The current branch %s is tracking multiple branches, refusing t=
o push."
+msgstr "Den aktuella grenen %s sp=C3=A5rar flera grenar, v=C3=A4grar s=
=C3=A4nda."
+
+#: builtin/push.c:100
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr ""
+"Du angav inga referensspecifikationer att s=C3=A4nda, och push.defaul=
t =C3=A4r "
+"\"nothing\"."
+
+#: builtin/push.c:120
+#, c-format
+msgid "Pushing to %s\n"
+msgstr "S=C3=A4nder till %s\n"
+
+#: builtin/push.c:124
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr "misslyckades s=C3=A4nda n=C3=A5gra referenser till \"%s\""
+
+#: builtin/push.c:132
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+"F=C3=B6r att f=C3=B6rhindra att du tappar historik har icke-snabbspol=
ande "
+"uppdateringar\n"
+"avvisats. Sl=C3=A5 ihop fj=C3=A4rr=C3=A4ndringarna (t.ex. \"git pull\=
") innan du s=C3=A4nder "
+"igen.\n"
+"Se avsnittet \"Note about fast-forward\" i \"git push --help\" f=C3=B6=
r "
+"detaljer.\n"
+
+#: builtin/push.c:149
+#, c-format
+msgid "bad repository '%s'"
+msgstr "felaktigt arkiv \"%s\""
+
+#: builtin/push.c:150
+msgid "No destination configured to push to."
+msgstr "Har inte st=C3=A4llt in n=C3=A5gon destination att s=C3=A4nda =
till."
+
+#: builtin/push.c:158
+msgid "--all and --tags are incompatible"
+msgstr "--all och --tags =C3=A4r inkompatibla"
+
+#: builtin/push.c:159
+msgid "--all can't be combined with refspecs"
+msgstr "--all kan inte kombineras med referensspecifikationer"
+
+#: builtin/push.c:164
+msgid "--mirror and --tags are incompatible"
+msgstr "--mirror och --tags =C3=A4r inkompatibla"
+
+#: builtin/push.c:165
+msgid "--mirror can't be combined with refspecs"
+msgstr "--mirror kan inte kombineras med referensspecifikationer"
+
+#: builtin/push.c:170
+msgid "--all and --mirror are incompatible"
+msgstr "--all och --mirror =C3=A4r inkompatibla"
+
+#: builtin/push.c:235
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr "--delete =C3=A4r imkompatibel med --all, --mirror och --tags"
+
+#: builtin/push.c:237
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
+msgstr "Kunde inte hitta tr=C3=A4det f=C3=B6r HEAD."
+
+#: builtin/reset.c:103
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr "Kunde inte hitta tr=C3=A4det f=C3=B6r %s."
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
+msgstr "Kunde inte tolka objektet \"%s\""
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
+#: builtin/revert.c:82
+msgid "program error"
+msgstr "programfel"
+
+#: builtin/revert.c:154 builtin/revert.c:188
+#, c-format
+msgid "Could not read commit message of %s"
+msgstr "Kunde inte l=C3=A4sa incheckningsmeddelandet f=C3=B6r %s"
+
+#: builtin/revert.c:202
+#, c-format
+msgid "Could not extract author email from %s"
+msgstr "Kunde inte h=C3=A4mta f=C3=B6rfattarens e-postadress fr=C3=A5n=
 %s"
+
+#: builtin/revert.c:214
+#, c-format
+msgid "Could not extract author time from %s"
+msgstr "Kunde inte h=C3=A4mta f=C3=B6rfattartid fr=C3=A5n %s"
+
+#: builtin/revert.c:230
+#, c-format
+msgid "No author information found in %s"
+msgstr "Hittade ingen f=C3=B6rfattarinformation i %s"
+
+#: builtin/revert.c:267
+#, c-format
+msgid "Could not write to %s."
+msgstr "Kunde inte skriva till %s."
+
+#: builtin/revert.c:270
+#, c-format
+msgid "Error wrapping up %s"
+msgstr "Fel vid avslutandet av %s"
+
+#: builtin/revert.c:290
+msgid ""
+"Your local changes would be overwritten by revert.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"revert\".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"git stash\" f=C3=B6=
r att forts=C3=A4tta."
+
+#: builtin/revert.c:293
+msgid ""
+"Your local changes would be overwritten by cherry-pick.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+"Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"cherry-pick\=
".\n"
+"Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"git stash\" f=C3=B6=
r att forts=C3=A4tta."
+
+#. TRANSLATORS: %s will be "revert" or "cherry-pick"
+#: builtin/revert.c:351
+#, c-format
+msgid "%s: Unable to write new index file"
+msgstr "%s: Kunde inte skriva ny indexfil"
+
+#: builtin/revert.c:417
+msgid "Your index file is unmerged."
+msgstr "Din indexfil har inte slagits ihop."
+
+#: builtin/revert.c:420
+msgid "You do not have a valid HEAD"
+msgstr "Du har ingen giltig HEAD"
+
+#: builtin/revert.c:428
+msgid "Cannot revert a root commit"
+msgstr "Kan inte =C3=A5ngra en rotincheckning"
+
+#: builtin/revert.c:437
+#, c-format
+msgid "Commit %s is a merge but no -m option was given."
+msgstr "Incheckning %s =C3=A4r en sammanslagning, men flaggan -m angav=
s inte."
+
+#: builtin/revert.c:445
+#, c-format
+msgid "Commit %s does not have parent %d"
+msgstr "Incheckning %s har inte f=C3=B6r=C3=A4lder %d"
+
+#: builtin/revert.c:449
+#, c-format
+msgid "Mainline was specified but commit %s is not a merge."
+msgstr "Huvudsp=C3=A5r angavs, men incheckningen %s =C3=A4r inte en sa=
mmanslagning"
+
+#. TRANSLATORS: The first %s will be "revert" or
+#. "cherry-pick", the second %s a SHA1
+#: builtin/revert.c:460
+#, c-format
+msgid "%s: cannot parse parent commit %s"
+msgstr "%s: kan inte tolka f=C3=B6r=C3=A4ldraincheckningen %s"
+
+#: builtin/revert.c:464
+#, c-format
+msgid "Cannot get commit message for %s"
+msgstr "Kan inte h=C3=A4mta incheckningsmeddelande f=C3=B6r %s"
+
+#: builtin/revert.c:525
+#, c-format
+msgid "could not revert %s... %s"
+msgstr "kunde inte =C3=A5ngra %s... %s"
+
+#: builtin/revert.c:526
+#, c-format
+msgid "could not apply %s... %s"
+msgstr "kunde inte applicera %s... %s"
+
+#: builtin/revert.c:559
+msgid "empty commit set passed"
+msgstr "den angivna upps=C3=A4ttningen incheckningar =C3=A4r tom"
+
+#: builtin/revert.c:573
+msgid "cherry-pick --ff cannot be used with --signoff"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --signoff"
+
+#: builtin/revert.c:575
+msgid "cherry-pick --ff cannot be used with --no-commit"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --no-commit"
+
+#: builtin/revert.c:577
+msgid "cherry-pick --ff cannot be used with -x"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med -x"
+
+#: builtin/revert.c:579
+msgid "cherry-pick --ff cannot be used with --edit"
+msgstr "cherry-pick --ff kan inte anv=C3=A4ndas med --edit"
+
+#. TRANSLATORS: %s will be "revert" or "cherry-pick"
+#: builtin/revert.c:584
+#, c-format
+msgid "git %s: failed to read the index"
+msgstr "git %s: misslyckades l=C3=A4sa indexet"
+
+#: builtin/rm.c:118
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+"\"%s\" har k=C3=B6at =C3=A4ndringar som skiljer sig b=C3=A5de fr=C3=A5=
n filen och HEAD\n"
+"(anv=C3=A4nd -f f=C3=B6r att tvinga borttagning)"
+
+#: builtin/rm.c:124
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"\"%s\" har k=C3=B6ade =C3=A4ndringar i indexet\n"
+"(anv=C3=A4nd --cached f=C3=B6r att beh=C3=A5lla filen eller -f f=C3=B6=
r att tvinga borttagning)"
+
+#: builtin/rm.c:128
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"\"%s\" har lokala =C3=A4ndringar\n"
+"(anv=C3=A4nd --cached f=C3=B6r att beh=C3=A5lla filen eller -f f=C3=B6=
r att tvinga borttagning)"
+
+#: builtin/rm.c:202
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr "tar inte bort \"%s\" rekursivt utan -r"
+
+#: builtin/rm.c:238
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr "git rm: kan inte ta bort %s"
+
+#: builtin/shortlog.c:161
+#, c-format
+msgid "Missing author: %s"
+msgstr "F=C3=B6rfattare saknas i: %s"
+
+#: builtin/tag.c:123 builtin/tag.c:464
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr "taggnamnet =C3=A4r f=C3=B6r l=C3=A5ngt: %.*s..."
+
+#: builtin/tag.c:128
+#, c-format
+msgid "tag '%s' not found."
+msgstr "taggen \"%s\" hittades inte."
+
+#: builtin/tag.c:143
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr "Tog bort tagg \"%s\" (var %s)\n"
+
+#: builtin/tag.c:155
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr "kunde inte bekr=C3=A4fta taggen \"%s\""
+
+#: builtin/tag.c:170
+msgid "committer info too long."
+msgstr "incheckarinformation =C3=A4r f=C3=B6r l=C3=A5ng."
+
+#: builtin/tag.c:190
+msgid "could not run gpg."
+msgstr "kunde inte k=C3=B6ra gpg."
+
+#: builtin/tag.c:196
+msgid "gpg did not accept the tag data"
+msgstr "gpg godtog inte tagginformationen"
+
+#: builtin/tag.c:203
+msgid "gpg failed to sign the tag"
+msgstr "gpg misslyckades att signera taggen"
+
+#: builtin/tag.c:218
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
+#: builtin/tag.c:226
+#, c-format
+msgid "signing key value too long (%.10s...)"
+msgstr "signeringsnyckelv=C3=A4rdet =C3=A4r f=C3=B6r l=C3=A5ngt (%.10s=
=2E..)"
+
+#: builtin/tag.c:272
+msgid "unable to sign the tag"
+msgstr "kunde inte signera taggen"
+
+#: builtin/tag.c:274
+msgid "unable to write tag file"
+msgstr "kunde inte skriva tagg-filen"
+
+#: builtin/tag.c:289
+msgid "bad object type."
+msgstr "felaktig objekttyp"
+
+#: builtin/tag.c:302
+msgid "tag header too big."
+msgstr "f=C3=B6r stort tagghuvud."
+
+#: builtin/tag.c:329
+msgid "no tag message?"
+msgstr "inget taggmeddelande?"
+
+#: builtin/tag.c:335
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr "Taggmeddelandet har l=C3=A4mnats kvar i %s\n"
+
+#: builtin/tag.c:428
+msgid "-n option is only allowed with -l."
+msgstr "flaggan -n =C3=A4r endast till=C3=A5ten tillsammans med -l."
+
+#: builtin/tag.c:430
+msgid "--contains option is only allowed with -l."
+msgstr "flaggan --contains =C3=A4r endast till=C3=A5ten tillsammans me=
d -l"
+
+#: builtin/tag.c:438
+msgid "only one -F or -m option is allowed."
+msgstr "endast en av flaggorna -F eller -m till=C3=A5ts."
+
+#: builtin/tag.c:458
+msgid "too many params"
+msgstr "f=C3=B6r m=C3=A5nga parametrar"
+
+#: builtin/tag.c:466
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr "\"%s\" =C3=A4r inte ett giltigt taggnamn."
+
+#: builtin/tag.c:471
+#, c-format
+msgid "tag '%s' already exists"
+msgstr "taggen \"%s\" finns redan"
+
+#: builtin/tag.c:479
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr "%s: kan inte l=C3=A5sa referensen"
+
+#: builtin/tag.c:481
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr "%s: kan inte uppdatera referensen"
+
+#: builtin/tag.c:483
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr "Uppdaterad tagg \"%s\" (var %s)\n"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:5
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr ""
+"Se \"git help KOMMANDO\" f=C3=B6r mer information om ett specifikt ko=
mmando."
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:10
+msgid "TEST: A C test string"
+msgstr "TEST: A C test string"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:13
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr "TEST: A C test string %s"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:16
+#, c-format
+msgid "TEST: Hello World!"
+msgstr "TEST: Hello World!"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:19
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr "TEST: Old English Runes"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:22
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D qu=
otes"
+
+#: git-am.sh:47
+msgid "You need to set your committer info first"
+msgstr "Du m=C3=A5ste st=C3=A4lla in din incheckarinformation f=C3=B6r=
st"
+
+#: git-am.sh:80
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
+#: git-am.sh:96
+msgid "Cannot fall back to three-way merge."
+msgstr "Kan inte falla tillbaka p=C3=A5 trev=C3=A4gssammanslagning."
+
+#: git-am.sh:111
+msgid "Repository lacks necessary blobs to fall back on 3-way merge."
+msgstr ""
+"Arkivet saknar objekt som beh=C3=B6vs f=C3=B6r att falla tillbaka p=C3=
=A5 3-"
+"v=C3=A4gssammanslagning."
+
+#: git-am.sh:120
+msgid ""
+"Did you hand edit your patch?\n"
+"It does not apply to blobs recorded in its index."
+msgstr ""
+"Handredigerade din patch?\n"
+"Den kan inte appliceras p=C3=A5 de blobbar som beskrivs i dess index.=
"
+
+#: git-am.sh:236
+msgid "Only one StGIT patch series can be applied at once"
+msgstr "Endast en StGIT-patchserie kan appliceras =C3=A5t g=C3=A5ngen"
+
+#: git-am.sh:288
+#, sh-format
+msgid "Patch format $patch_format is not supported."
+msgstr "Patchformatet $patch_format st=C3=B6ds inte."
+
+#: git-am.sh:290
+msgid "Patch format detection failed."
+msgstr "Misslyckades detektera patchformat."
+
+#: git-am.sh:340
+msgid "-d option is no longer supported.  Do not use."
+msgstr "Flaggan -d st=C3=B6ds inte l=C3=A4gre. Anv=C3=A4nd inte."
+
+#: git-am.sh:403
+#, sh-format
+msgid "previous rebase directory $dotest still exists but mbox given."
+msgstr "tidigare rebase-katalog $dotest finns redan, men mbox angavs."
+
+#: git-am.sh:408
+msgid "Please make up your mind. --skip or --abort?"
+msgstr "Best=C3=A4m dig. --skip eller --abort?"
+
+#: git-am.sh:434
+msgid "Resolve operation not in progress, we are not resuming."
+msgstr "L=C3=B6sningsoperation p=C3=A5g=C3=A5r inte, vi =C3=A5teruppta=
r inte."
+
+#: git-am.sh:499
+#, sh-format
+msgid "Dirty index: cannot apply patches (dirty: $files)"
+msgstr "Smutsigt index: kan inte applicera patchar (smutsiga: $files)"
+
+#: git-am.sh:595
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
+#: git-am.sh:632
+msgid "Patch does not have a valid e-mail address."
+msgstr "Patchen har inte n=C3=A5gon giltig e-postadress."
+
+#: git-am.sh:679
+msgid "cannot be interactive without stdin connected to a terminal."
+msgstr ""
+"kan inte vara interaktiv om standard in inte =C3=A4r ansluten till en=
 terminal."
+
+#: git-am.sh:683
+msgid "Commit Body is:"
+msgstr "Incheckningskroppen =C3=A4r:"
+
+#. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+#. in your translation. The program will only accept English
+#. input at this point.
+#: git-am.sh:690
+msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+msgstr "Applicera? Y=3Dja/N=3Dnej/E=3Dredigera/V=3Dvisa patch/A=3Dgodt=
a alla "
+
+#: git-am.sh:726
+#, sh-format
+msgid "Applying: $FIRSTLINE"
+msgstr "Applicerar: $FIRSTLINE"
+
+#: git-am.sh:747
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
+#: git-am.sh:755
+msgid ""
+"You still have unmerged paths in your index\n"
+"did you forget to use 'git add'?"
+msgstr ""
+"Du har fortfarande s=C3=B6kv=C3=A4gar som inte slagits samman i ditt =
index\n"
+"gl=C3=B6mde du anv=C3=A4nda \"git add\"?"
+
+#: git-am.sh:771
+msgid "No changes -- Patch already applied."
+msgstr "Inga =C3=A4ndringar -- Patchen har redan applicerats."
+
+#: git-am.sh:781
+#, sh-format
+msgid "Patch failed at $msgnum $FIRSTLINE"
+msgstr "Patchen misslyckades vid $msgnum $FIRSTLINE"
+
+#: git-am.sh:797
+msgid "applying to an empty history"
+msgstr "applicerar p=C3=A5 en tom historik"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:8
+msgid "TEST: A Shell test string"
+msgstr "TEST: A Shell test string"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:11
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr "TEST: A Shell test $variable"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:8
+msgid "TEST: A Perl test string"
+msgstr "TEST: A Perl test string"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:11
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr "TEST: A Perl test variable %s"
--=20
1.7.1
