From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 3 messages
Date: Mon, 19 Jan 2015 07:22:07 +0100
Message-ID: <1421648527-3878-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 07:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YD5j5-0004Jj-HV
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 07:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbASGWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2015 01:22:12 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:61082 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbASGWL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 01:22:11 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so14358040wib.0
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=BAHDiUDKAr7rercBPXzOWNNZq7urN5xVP5l7RVx+wCM=;
        b=EXnwgUyiBUd8ClUbjarDAaUW5067Qh7ahrzTbG+9WNEFnRQhm5xpw/upUAvH1Ai2ma
         v4LEDNeSpypHN1k8iPWCUMfnZHs9+aW8eFVtOXAN97ck7WYpZ7v2s9dWTwnyvWpZ1Xsh
         NTNRhBOB1iaJiPN8UMW+GuCvJLbasYacfoQeKyVtw/E4s/7Akst+Ik6+pa83YUARYcCl
         q5qiIGpAqQXI5rZxg8rrWNB01nc3AP0MfVX9N1hljWvwk030PUQbKwzIGtTdmCTeMW8D
         oX31E10jGIcXpBtMpDmIyoT+/I5Iu0Esf8ew3rXMqwML4SEvN+xbrtcQtX8c0738I9mA
         TS3A==
X-Received: by 10.194.203.234 with SMTP id kt10mr87906wjc.88.1421648530139;
        Sun, 18 Jan 2015 22:22:10 -0800 (PST)
Received: from localhost (dslb-088-073-235-175.088.073.pools.vodafone-ip.de. [88.73.235.175])
        by mx.google.com with ESMTPSA id fp2sm12897362wib.8.2015.01.18.22.22.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Jan 2015 22:22:09 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.211.g05e7197
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262611>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index 38183fb..0b93b0f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -6595,14 +6595,12 @@ msgid "trailer(s) to add"
 msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/log.c:41
-#, fuzzy
 msgid "git log [<options>] [<revision range>] [[--] <path>...]"
-msgstr "git log [<Optionen>] [Commitbereich>] [[--] <Pfad>...]\n"
+msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
=20
 #: builtin/log.c:42
-#, fuzzy
 msgid "git show [options] <object>..."
-msgstr "   oder: git show [Optionen] <Objekt>..."
+msgstr "git show [Optionen] <Objekt>..."
=20
 #: builtin/log.c:81
 #, c-format
@@ -9679,17 +9677,16 @@ msgid "Linewrap output"
 msgstr "Ausgabe mit Zeilenumbr=C3=BCchen"
=20
 #: builtin/show-branch.c:9
-#, fuzzy
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
 "\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
 "\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
 "\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
-"current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
-"independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<C=
ommit> "
-"| <glob>)...]"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
+"\t\t       [--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n=
"
+"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t       [--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...=
]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
--=20
2.3.0.rc0.211.g05e7197
