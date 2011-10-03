From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] po/pl.po: Eliminate fuzzy translations
Date: Mon, 3 Oct 2011 23:37:09 +0200
Message-ID: <201110032337.09975.jnareb@gmail.com>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com> <m3ipre4dtf.fsf@localhost.localdomain> <CACBZZX7wj=j9Mx-m0HrRoRHP1HOSVpn-7o0YVnY6LsfWzuw8aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FsiiO7Q5pfMtgic"
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcin =?iso-8859-2?q?Cie=B6lak?= <saper@saper.info>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 23:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAqTg-0000uF-Of
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 23:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631Ab1JCVzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 17:55:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48259 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1JCVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 17:55:05 -0400
Received: by eya28 with SMTP id 28so3292935eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        bh=Lo5R6EW1fi9OA/ba0C0PJlrKYclfZa4e5LIoo9cdWf8=;
        b=I+M3L8GpKEQ25SEsHw3jqcZiepehsv0PdiTN54kvU9zs1XuZ3UWnGNoocWxs8Z0DGI
         VseZVZ36ug9Jhff97K2wYZDzzlQ6mzqYlBlIJMOm9EfHaw4SDGjPp6jLkeMm5iaprfUS
         EVTlaJ26fFBH3USX2ZP6c5y46PGO2KbHq/3xY=
Received: by 10.223.60.130 with SMTP id p2mr300149fah.99.1317678903002;
        Mon, 03 Oct 2011 14:55:03 -0700 (PDT)
Received: from [192.168.1.13] (abvr121.neoplus.adsl.tpnet.pl. [83.8.215.121])
        by mx.google.com with ESMTPS id x22sm22860303faa.5.2011.10.03.14.55.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 14:55:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACBZZX7wj=j9Mx-m0HrRoRHP1HOSVpn-7o0YVnY6LsfWzuw8aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182713>

--Boundary-00=_FsiiO7Q5pfMtgic
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2011/7/7 Jakub Narebski <jnareb@gmail.com>:
> > Remove all fuzzy translations by either correcting them where trivial,
> > or removing them altogether.
>
> I was about to try to submit this (better late than never) but I can't
> get git-am to accept this mail which has quoted-printable format.
>
> Can you perchance send this as a git:// URL or as a *.patch file
> attachment?

Sent as attachment, just in case

It is also available as 'i18n-po.pl' branch on both repo.or.cz and GitHub
  http://repo.or.cz/w/git/jnareb-git.git
  https://github.com/jnareb/git

Pull request:
^^^^^^^^^^^^^
The following changes since commit aa8ce2e23754171665ad53d317a97f941407379a:

  po/pl.po: Eliminate fuzzy translations (2011-07-07 11:01:25 +0200)

are available in the git repository at:
  git://repo.or.cz/git/jnareb-git.git i18n-po.pl

=2D-=20
Jakub Narebski
Poland

--Boundary-00=_FsiiO7Q5pfMtgic
Content-Type: text/plain;
  charset="utf-8";
  name="0001-po-pl.po-Eliminate-fuzzy-translations.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-po-pl.po-Eliminate-fuzzy-translations.txt"

>From aa8ce2e23754171665ad53d317a97f941407379a Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Thu, 7 Jul 2011 11:01:25 +0200
Subject: [PATCH] po/pl.po: Eliminate fuzzy translations

Remove all fuzzy translations by either correcting them where trivial,
or removing them altogether.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Only corrected translations that were trivial, trying not to introduce
any new words / phrases, because I don't know what should be Polish
translations of English terminology.

...
The following changes since commit ceb58337358d93caae779b33daf6d7fd58ccdf23:

  en_GB is OK now (2011-07-06 19:24:58 +0000)

are available in the git repository at:
  git@github.com:jnareb/git.git i18n-po.pl

Jakub Narebski (1):
      po/pl.po: Eliminate fuzzy translations

 po/pl.po |  208 ++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/po/pl.po b/po/pl.po
index f7f2129..414c881 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -3,13 +3,45 @@
 # This file is distributed under the same license as the Git package.
 # Marcin Cieślak <saper@saper.info>, 2010.
 #
+# Terminologia dla kluczowych terminów z Subversion:
+# path - ścieżka
+# URL - URL
+# file - plik
+# directory - katalog
+# update - aktualizacja
+# commit - zatwierdzenie, zatwierdzenie zmian
+# version control - zarządzanie wersjami
+# repository - repozytorium
+# branch - odgałęzienie
+# tag - tag
+# merge - łączenie zmian
+# conflict - konflikt
+# property - atrybut
+# revision - wersja
+# log message - opis zmian
+# entry/item - element
+# ancestry - pochodzenie
+# ancestor - przodek
+# working copy - kopia robocza
+# working dir - bieżący katalog
+# usage - wykorzystanie
+# source - źródłowy
+# destination - docelowy
+# hook - skrypt (skrypt repozytorium)
+# exclude - wykluczyć
+# crop - obciąć
+# cache - pamięć podręczna
+# child - obiekt podrzędny
+# obliteration - obliteracja
+# patch - łata
+# notes - adnotacja
 msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2011-07-06 19:20+0000\n"
-"PO-Revision-Date: 2010-08-30 17:02+0200\n"
-"Last-Translator: Marcin Cieślak <saper@saper.info>\n"
+"PO-Revision-Date: 2011-07-07 10:53+0200\n"
+"Last-Translator: Jakub Narębski <jnareb@gmail.com>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: pl\n"
 "MIME-Version: 1.0\n"
@@ -24,9 +56,9 @@ msgid "  Failed to parse dirstat cut-off percentage '%.*s'\n"
 msgstr ""
 
 #: diff.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "  Unknown dirstat parameter '%.*s'\n"
-msgstr "nie mogę tknąć szablonu '%s'"
+msgstr "  Nieznany argument '%.*s' opcji '--dirstat'\n"
 
 #: diff.c:205
 #, c-format
@@ -192,9 +224,8 @@ msgid "Not currently on any branch."
 msgstr ""
 
 #: wt-status.c:731
-#, fuzzy
 msgid "Initial commit"
-msgstr "Utworzyłem puste"
+msgstr ""
 
 #: wt-status.c:745
 msgid "Untracked"
@@ -315,14 +346,13 @@ msgid "Could not open '%s' for writing."
 msgstr ""
 
 #: builtin/add.c:288
-#, fuzzy
 msgid "Could not write patch"
-msgstr "Nie mogę dać prawa zapisu grupie w %s"
+msgstr ""
 
 #: builtin/add.c:293
-#, fuzzy, c-format
+#, c-format
 msgid "Could not stat '%s'"
-msgstr "nie mogę tknąć '%s'"
+msgstr "Nie można wykonać stat na '%s'"
 
 #: builtin/add.c:295
 msgid "Empty patch. Aborted."
@@ -427,9 +457,8 @@ msgid "remote "
 msgstr ""
 
 #: builtin/branch.c:169
-#, fuzzy
 msgid "cannot use -a with -d"
-msgstr "nie wiem w którym katalogu jestem"
+msgstr "nie można użyć opcji -a z opcją -d"
 
 #: builtin/branch.c:175
 msgid "Couldn't look up commit object for HEAD"
@@ -619,9 +648,9 @@ msgid "you need to resolve your current index first"
 msgstr ""
 
 #: builtin/checkout.c:527
-#, fuzzy, c-format
+#, c-format
 msgid "Can not do reflog for '%s'\n"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "Nie można utworzyć reflog dla '%s'\n"
 
 #: builtin/checkout.c:557
 msgid "HEAD is now at"
@@ -720,9 +749,8 @@ msgid "--detach cannot be used with -b/-B/--orphan"
 msgstr ""
 
 #: builtin/checkout.c:979
-#, fuzzy
 msgid "--detach cannot be used with -t"
-msgstr "nie wiem w którym katalogu jestem"
+msgstr "--detach nie może być użyte z -t"
 
 #: builtin/checkout.c:985
 msgid "--track needs a branch name"
@@ -813,9 +841,9 @@ msgid "Removing %s\n"
 msgstr ""
 
 #: builtin/clean.c:161 builtin/clean.c:181
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove %s"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę usunąć '%s'"
 
 #: builtin/clean.c:165
 #, c-format
@@ -833,24 +861,24 @@ msgid "reference repository '%s' is not a local directory."
 msgstr ""
 
 #: builtin/clone.c:241
-#, fuzzy, c-format
+#, c-format
 msgid "failed to open '%s'"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę otworzyć '%s'"
 
 #: builtin/clone.c:245
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create directory '%s'"
-msgstr "beznadziejny katalog gita %s"
+msgstr "nie mogę utworzyć katalogu '%s'"
 
 #: builtin/clone.c:247 builtin/diff.c:74
-#, fuzzy, c-format
+#, c-format
 msgid "failed to stat '%s'"
-msgstr "nie mogę tknąć '%s'"
+msgstr "nie mogę wykonać stat na '%s'"
 
 #: builtin/clone.c:249
-#, fuzzy, c-format
+#, c-format
 msgid "%s exists and is not a directory"
-msgstr "beznadziejny katalog gita %s"
+msgstr "%s istnieje i nie jest katalogiem"
 
 #: builtin/clone.c:263
 #, c-format
@@ -863,14 +891,14 @@ msgid "failed to unlink '%s'"
 msgstr ""
 
 #: builtin/clone.c:278
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create link '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "nie mogę utworzyć dowiązania '%s'"
 
 #: builtin/clone.c:282
-#, fuzzy, c-format
+#, c-format
 msgid "failed to copy file to '%s'"
-msgstr "nie mogę skopiować '%s' to '%s'"
+msgstr "nie mogę skopiować pliku do '%s'"
 
 #: builtin/clone.c:311
 #, c-format
@@ -915,9 +943,9 @@ msgid "could not create leading directories of '%s'"
 msgstr ""
 
 #: builtin/clone.c:461
-#, fuzzy, c-format
+#, c-format
 msgid "could not create work tree dir '%s'."
-msgstr "Nie mogę dostać się do drzewa roboczego '%s'"
+msgstr "nie mogę utworzyć katalogu roboczego '%s'"
 
 #: builtin/clone.c:480
 #, c-format
@@ -983,9 +1011,8 @@ msgid "failed to unpack HEAD tree object"
 msgstr ""
 
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to create temporary index"
-msgstr "beznadziejny katalog gita %s"
+msgstr "nie mogę utworzyć tymczasowego indeksu"
 
 #: builtin/commit.c:365
 msgid "interactive add failed"
@@ -1001,9 +1028,8 @@ msgid "cannot do a partial commit during a %s."
 msgstr ""
 
 #: builtin/commit.c:456
-#, fuzzy
 msgid "cannot read the index"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "nie mogę odczytać indeksu"
 
 #: builtin/commit.c:476
 msgid "unable to write temporary index file"
@@ -1042,9 +1068,9 @@ msgid "could not read log from standard input"
 msgstr ""
 
 #: builtin/commit.c:674
-#, fuzzy, c-format
+#, c-format
 msgid "could not read log file '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr ""
 
 #: builtin/commit.c:680
 msgid "commit has empty message"
@@ -1059,14 +1085,14 @@ msgid "could not read SQUASH_MSG"
 msgstr ""
 
 #: builtin/commit.c:704
-#, fuzzy, c-format
+#, c-format
 msgid "could not read '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "nie można odczytać '%s'"
 
 #: builtin/commit.c:732
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s'"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę otworzyć '%s'"
 
 #: builtin/commit.c:756
 msgid "could not write commit template"
@@ -1110,9 +1136,8 @@ msgid "%sCommitter: %s"
 msgstr ""
 
 #: builtin/commit.c:829
-#, fuzzy
 msgid "Cannot read index"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "Nie mogę odczytać indeksu"
 
 #: builtin/commit.c:869
 msgid "Error building trees"
@@ -1272,9 +1297,9 @@ msgid "%s is not a valid '%s' object"
 msgstr ""
 
 #: builtin/describe.c:287
-#, fuzzy, c-format
+#, c-format
 msgid "no tag exactly matches '%s'"
-msgstr "nie mogę tknąć szablonu '%s'"
+msgstr "nie znaleziono taga który dokładnie pasuje do '%s'"
 
 #: builtin/describe.c:289
 #, c-format
@@ -1363,9 +1388,9 @@ msgid "Couldn't find remote ref HEAD"
 msgstr ""
 
 #: builtin/fetch.c:252
-#, fuzzy, c-format
+#, c-format
 msgid "object %s not found"
-msgstr "nie znaleziono szablonów %s"
+msgstr "nie znaleziono obiektu %s"
 
 #: builtin/fetch.c:257
 msgid "[up to date]"
@@ -1413,9 +1438,9 @@ msgid "(non-fast-forward)"
 msgstr ""
 
 #: builtin/fetch.c:361 builtin/fetch.c:684
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open %s: %s\n"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę otworzyć %s: %s\n"
 
 #: builtin/fetch.c:439
 #, c-format
@@ -1528,9 +1553,9 @@ msgid "Too many options specified"
 msgstr ""
 
 #: builtin/gc.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "insanely long object directory %.*s"
-msgstr "beznadziejny katalog gita %s"
+msgstr ""
 
 #: builtin/gc.c:223
 #, c-format
@@ -1590,9 +1615,9 @@ msgid "switch `%c' expects a numerical value"
 msgstr ""
 
 #: builtin/grep.c:691
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open '%s'"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę otworzyć '%s'"
 
 #: builtin/grep.c:974
 msgid "no pattern given."
@@ -1701,14 +1726,14 @@ msgid "unable to handle file type %d"
 msgstr ""
 
 #: builtin/init-db.c:357
-#, fuzzy, c-format
+#, c-format
 msgid "unable to move %s to %s"
-msgstr "nie mogę skopiować '%s' to '%s'"
+msgstr "nie mogę przenieść %s do %s"
 
 #: builtin/init-db.c:362
-#, fuzzy, c-format
+#, c-format
 msgid "Could not create git link %s"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "Nie mogę utworzyć git-dowiązania %s"
 
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -1793,9 +1818,9 @@ msgid "name of output directory is too long"
 msgstr ""
 
 #: builtin/log.c:688
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot open patch file %s"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "Nie mogę otworzyć pliku łaty %s"
 
 #: builtin/log.c:702
 msgid "Need exactly one range."
@@ -1814,9 +1839,9 @@ msgid "Cover letter needs email format"
 msgstr ""
 
 #: builtin/log.c:872
-#, fuzzy, c-format
+#, c-format
 msgid "insane in-reply-to: %s"
-msgstr "beznadziejny katalog gita %s"
+msgstr "niepoprawne in-reply-to: %s"
 
 #: builtin/log.c:945
 msgid "Two output directories?"
@@ -1983,14 +2008,14 @@ msgstr ""
 
 #: builtin/merge.c:841 builtin/merge.c:920 builtin/merge.c:1427
 #: builtin/merge.c:1436 builtin/revert.c:210
-#, fuzzy, c-format
+#, c-format
 msgid "Could not open '%s' for writing"
-msgstr "Nie mogę dać prawa zapisu grupie w %s"
+msgstr "Nie mogę otworzyć '%s' do zapisu"
 
 #: builtin/merge.c:852
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read from '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "Nie mogę czytać z '%s'"
 
 #: builtin/merge.c:869
 #, c-format
@@ -2123,9 +2148,9 @@ msgid "Automatic merge went well; stopped before committing as requested\n"
 msgstr ""
 
 #: builtin/mv.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "Checking rename of '%s' to '%s'\n"
-msgstr "nie mogę skopiować '%s' to '%s'"
+msgstr "Sprawdzanie zmiany nazwy z '%s' na '%s'\n"
 
 #: builtin/mv.c:107
 msgid "bad source"
@@ -2204,9 +2229,9 @@ msgid "failed to finish 'show' for object '%s'"
 msgstr ""
 
 #: builtin/notes.c:175 builtin/tag.c:303
-#, fuzzy, c-format
+#, c-format
 msgid "could not create file '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "nie mogę utworzyć pliku '%s'"
 
 #: builtin/notes.c:189
 msgid "Please supply the note contents using either -m or -F option"
@@ -2227,14 +2252,14 @@ msgid "The note contents has been left in %s"
 msgstr ""
 
 #: builtin/notes.c:251 builtin/tag.c:448
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read '%s'"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "nie można odczytać '%s'"
 
 #: builtin/notes.c:253 builtin/tag.c:451
-#, fuzzy, c-format
+#, c-format
 msgid "could not open or read '%s'"
-msgstr "nie mogę otworzyć katalogu '%s'"
+msgstr "nie mogę otworzyć ani odczytać '%s'"
 
 #: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
 #: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
@@ -2276,9 +2301,9 @@ msgid "Malformed input line: '%s'."
 msgstr ""
 
 #: builtin/notes.c:456
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
-msgstr "nie mogę skopiować '%s' to '%s'"
+msgstr "Nie udało się skopiować adnotacji z '%s' do '%s'"
 
 #: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
 #: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
@@ -2687,9 +2712,9 @@ msgid "tag name too long: %.*s..."
 msgstr ""
 
 #: builtin/tag.c:126
-#, fuzzy, c-format
+#, c-format
 msgid "tag '%s' not found."
-msgstr "nie znaleziono szablonów %s"
+msgstr "nie znaleziono tagu '%s'."
 
 #: builtin/tag.c:141
 #, c-format
@@ -3027,9 +3052,9 @@ msgid "No logfile given"
 msgstr ""
 
 #: git-bisect.sh:372
-#, fuzzy, sh-format
+#, sh-format
 msgid "cannot read $file for replaying"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr ""
 
 #: git-bisect.sh:388
 msgid "?? what are you talking about?"
@@ -3106,14 +3131,12 @@ msgid "You do not have the initial commit yet"
 msgstr ""
 
 #: git-stash.sh:80
-#, fuzzy
 msgid "Cannot save the current index state"
-msgstr "Nie mogę dobrać się do bieżącego katalogu"
+msgstr "Nie mogę zapisać bieżącego stanu indeksu"
 
 #: git-stash.sh:94 git-stash.sh:107
-#, fuzzy
 msgid "Cannot save the current worktree state"
-msgstr "Nie mogę dobrać się do bieżącego katalogu"
+msgstr "Nie mogę zapisać bieżącego stanu katalogu roboczego"
 
 #: git-stash.sh:111
 msgid "No changes selected"
@@ -3124,9 +3147,8 @@ msgid "Cannot remove temporary index (can't happen)"
 msgstr ""
 
 #: git-stash.sh:127
-#, fuzzy
 msgid "Cannot record working tree state"
-msgstr "Nie mogę dostać się do drzewa roboczego '%s'"
+msgstr ""
 
 #: git-stash.sh:182
 msgid "No local changes to save"
@@ -3141,9 +3163,8 @@ msgid "Cannot save the current status"
 msgstr ""
 
 #: git-stash.sh:207
-#, fuzzy
 msgid "Cannot remove worktree changes"
-msgstr "Nie mogę dostać się do drzewa roboczego '%s'"
+msgstr "Nie mogę usunąć zmian w katalogu roboczym"
 
 #: git-stash.sh:302
 msgid "No stash found."
@@ -3182,9 +3203,8 @@ msgid "Conflicts in index. Try without --index."
 msgstr ""
 
 #: git-stash.sh:373
-#, fuzzy
 msgid "Could not save index tree"
-msgstr "Nie mogę dać prawa zapisu grupie w %s"
+msgstr ""
 
 #: git-stash.sh:399
 msgid "Cannot unstage modified files"
@@ -3238,9 +3258,9 @@ msgid "repo URL: '$repo' must be absolute or begin with ./|../"
 msgstr ""
 
 #: git-submodule.sh:222
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists in the index"
-msgstr "readlink nie zadziałało dla '%s'"
+msgstr "'$path' już jest w indeksie"
 
 #: git-submodule.sh:227
 #, sh-format
@@ -3256,9 +3276,9 @@ msgid "Adding existing repo at '$path' to the index"
 msgstr ""
 
 #: git-submodule.sh:242
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists and is not a valid git repo"
-msgstr "beznadziejny katalog gita %s"
+msgstr "'$path' juz istnieje i nie jest poprawnym repozytorium Gita"
 
 #: git-submodule.sh:265
 #, sh-format
-- 
1.7.5


--Boundary-00=_FsiiO7Q5pfMtgic--
