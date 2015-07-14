From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 9 new messages
Date: Tue, 14 Jul 2015 19:59:38 +0200
Message-ID: <1436896778-8159-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 19:59:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF4Uh-0005uC-F0
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 19:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbGNR7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 13:59:46 -0400
Received: from mail-wg0-f67.google.com ([74.125.82.67]:35826 "EHLO
	mail-wg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbGNR7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 13:59:46 -0400
Received: by wgkl9 with SMTP id l9so1311407wgk.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=xnpT/rWoKB2t8aAn6wgyHregR9hmmj0i38RoBS/u0/0=;
        b=ZKJ1ujGCh0o3YgD6/xYutnrSzDKIlrbaUfc994PY7NipGoHFRnaO6zr+GJgRSxQObR
         AqoR/hTPsFmIkta1iCA5WGrT1ZDzJsLjHysPH0U8pbRBw0a+WxVg1T9/7wYAF0bVsb2R
         FEQTIOwNULm+N2QcZ+DGo0MvyfNeBGJxJZQA6QPttoqYJQtgg9QQd3c8vrZkGOiGGmzc
         F4edwrW2dyFVKtOciF0z+Lkl5AWOueWgFtZNfD2GVZmiThTV5Kz74sru/mpwGmbKstxq
         OokzyxVPFmDyNI8a9C9NezyHIi/av/4V31+Jz1WFJ2ua51yIVeP5WwK7hKELO+XukS+q
         66Qg==
X-Received: by 10.180.79.134 with SMTP id j6mr7907561wix.83.1436896784880;
        Tue, 14 Jul 2015 10:59:44 -0700 (PDT)
Received: from localhost (cable-86-56-33-117.cust.telecolumbus.net. [86.56.33.117])
        by smtp.gmail.com with ESMTPSA id x10sm3286610wjr.25.2015.07.14.10.59.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 10:59:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.388.g757bd17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273970>

Translate 9 new messages came from git.pot update in a4156d2
(l10n: git.pot: v2.5.0 round 2 (9 new, 5 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/po/de.po b/po/de.po
index 64070cd..6ed3509 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10463,14 +10463,12 @@ msgid "print tag contents"
 msgstr "Tag-Inhalte ausgeben"
=20
 #: builtin/worktree.c:11
-#, fuzzy
 msgid "git worktree add [<options>] <path> <branch>"
-msgstr "git remote add [<Optionen>] <Name> <URL>"
+msgstr "git worktree add [<Optionen>] <Pfad> <Branch>"
=20
 #: builtin/worktree.c:12
-#, fuzzy
 msgid "git worktree prune [<options>]"
-msgstr "git notes prune [<Optionen>]"
+msgstr "git worktree prune [<Optionen>]"
=20
 #: builtin/worktree.c:27
 #, c-format
@@ -10513,9 +10511,8 @@ msgid "could not create directory of '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/worktree.c:241
-#, fuzzy
 msgid "unable to resolve HEAD"
-msgstr "kann HEAD nicht aufl=C3=B6sen"
+msgstr "Konnte HEAD nicht aufl=C3=B6sen."
=20
 #: builtin/worktree.c:249
 #, c-format
@@ -10523,29 +10520,25 @@ msgid "Enter %s (identifier %s)"
 msgstr "Betrete %s (Identifikation %s)"
=20
 #: builtin/worktree.c:281
-#, fuzzy
 msgid "checkout <branch> even if already checked out in other worktree=
"
-msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
+msgstr "<Branch> auschecken, auch wenn dieser bereits in einem anderen=
 "
+"Arbeitsverzeichnis ausgecheckt ist"
=20
 #: builtin/worktree.c:283
-#, fuzzy
 msgid "create a new branch"
-msgstr "das Reflog f=C3=BCr den neuen Branch erzeugen"
+msgstr "neuen Branch erstellen"
=20
 #: builtin/worktree.c:285
-#, fuzzy
 msgid "create or reset a branch"
-msgstr "Branches anzeigen, erstellen oder entfernen"
+msgstr "Branch erstellen oder umsetzen"
=20
 #: builtin/worktree.c:286
-#, fuzzy
 msgid "detach HEAD at named commit"
-msgstr "HEAD zu benanntem Commit setzen"
+msgstr "HEAD bei benanntem Commit losl=C3=B6sen"
=20
 #: builtin/worktree.c:292
-#, fuzzy
 msgid "-b and -B are mutually exclusive"
-msgstr "Die Optionen -n und -k schlie=C3=9Fen sich gegenseitig aus."
+msgstr "-b und -B schlie=C3=9Fen sich gegenseitig aus"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
@@ -10612,9 +10605,8 @@ msgid "List, create, or delete branches"
 msgstr "Branches anzeigen, erstellen oder entfernen"
=20
 #: common-cmds.h:21
-#, fuzzy
 msgid "Switch branches or restore working tree files"
-msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
+msgstr "Branches wechseln oder Dateien im Arbeitsverzeichnis wiederher=
stellen"
=20
 #: common-cmds.h:22
 msgid "Clone a repository into a new directory"
--=20
2.5.0.rc1.388.g757bd17
