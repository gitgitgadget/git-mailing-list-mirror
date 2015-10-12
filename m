From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] gitk: Update Russian translation
Date: Mon, 12 Oct 2015 14:10:36 +0300
Message-ID: <1444648236-16316-2-git-send-email-dimitriy.ryazantcev@gmail.com>
References: <1444648236-16316-1-git-send-email-dimitriy.ryazantcev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 13:11:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlb0Q-00015Z-4M
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 13:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbbJLLKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2015 07:10:51 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35819 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbJLLKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 07:10:48 -0400
Received: by lbwr8 with SMTP id r8so137811505lbw.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=thTp2prUHuEVDhG0rGruYNn5Y+6xUzooK9u5iiq8y2c=;
        b=ux9OZ26/49KDJs+WA+mZEhKpwXdV7jo5xExmLp5+dxxW4X+wiNb/d2QUISJEKrCUkQ
         8q8nD9dAmtS0XneAi0554cdOnfSHwnGDXHSUg7gcUsjsNjxjPzRFKTuGc2Ga7nH1X1qM
         UGmcqoauID8ybsjohHdOM1anUyYxslDDRNhnsy0sJTqpBB9iIVIe0yAC5EafP2vgmVKq
         jUAHvKWsb+FNVgr6hXAZPOXxE472VGYGlmXPbPYSw3jj5YDIhPSzMxrfcp9NQYw8JHNP
         UdvfmuR2vM6Wc4A2TfwSqXUu91L6RBhS9ept9Q7aNdPAStSYfjVqEnFabWp4PkS7urll
         AChw==
X-Received: by 10.25.81.199 with SMTP id f190mr8013339lfb.93.1444648246456;
        Mon, 12 Oct 2015 04:10:46 -0700 (PDT)
Received: from Prog004.devcubestudio.com (host-46-250-125-121.la.net.ua. [46.250.125.121])
        by smtp.gmail.com with ESMTPSA id g7sm2776895lbs.10.2015.10.12.04.10.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 04:10:45 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1444648236-16316-1-git-send-email-dimitriy.ryazantcev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279373>

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 po/ru.po | 401 +++++++++++++++++++++++++------------------------------=
--------
 1 file changed, 161 insertions(+), 240 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index f1bac87..4bec810 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1,18 +1,24 @@
-#
 # Translation of gitk to Russian.
-#
+#=20
+# Translators:
+# 0xAX <kuleshovmail@gmail.com>, 2014
+# Alex Riesen <raa.lkml@gmail.com>, 2015
+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015
+# Dmitry Potapov <dpotapov@gmail.com>, 2009
+# Skip <bsvskip@rambler.ru>, 2011
 msgid ""
 msgstr ""
-"Project-Id-Version: gitk\n"
+"Project-Id-Version: Git Russian Localization Project\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2009-04-24 16:00+0200\n"
-"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
-"Language-Team: Russian\n"
-"Language: \n"
+"PO-Revision-Date: 2015-10-12 10:14+0000\n"
+"Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
+"Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/lan=
guage/ru/)\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Language: ru\n"
+"Plural-Forms: nplurals=3D4; plural=3D(n%10=3D=3D1 && n%100!=3D11 ? 0 =
: n%10>=3D2 && n%10<=3D4 && (n%100<12 || n%100>14) ? 1 : n%10=3D=3D0 ||=
 (n%10>=3D5 && n%10<=3D9) || (n%100>=3D11 && n%100<=3D14)? 2 : 3);\n"
=20
 #: gitk:140
 msgid "Couldn't get list of unmerged files:"
@@ -20,15 +26,15 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=
=B6=D0=BD=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D1=81=
=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=
=BD=D0=B5=D0=B7=D0=B0
=20
 #: gitk:212 gitk:2381
 msgid "Color words"
-msgstr ""
+msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BD=D1=8B=D0=B5 =D1=81=D0=BB=D0=BE=D0=
=B2=D0=B0"
=20
 #: gitk:217 gitk:2381 gitk:8220 gitk:8253
 msgid "Markup words"
-msgstr ""
+msgstr "=D0=9F=D0=BE=D0=BC=D0=B5=D1=87=D0=B5=D0=BD=D1=8B=D0=B5 =D1=81=D0=
=BB=D0=BE=D0=B2=D0=B0"
=20
 #: gitk:324
 msgid "Error parsing revisions:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=B4=D0=B5=
=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80=D0=B5 =D0=B2=
=D0=B5=D1=80=D1=81=D0=B8=D0=B8:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=80=
=D0=B0=D0=B7=D0=B1=D0=BE=D1=80=D0=B5 =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=
=D0=B8=D0=B8:"
=20
 #: gitk:380
 msgid "Error executing --argscmd command:"
@@ -36,17 +42,13 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=
=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=
=D0=B0=D0=BD=D0=B4=D1=8B =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9=
 --args
=20
 #: gitk:393
 msgid "No files selected: --merge specified but no files are unmerged.=
"
-msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=
=D0=BD=D0=BE =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0 =D0=B3=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 "
-"=D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=
=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=D1=8C =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=
=D1=88=D0=B5=D0=BD=D0=B0."
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=
=D1=80=D0=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge,=
 =D0=BD=D0=BE =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BD=D0=B0=D0=B9=D0=
=B4=D0=B5=D0=BD=D0=BE =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B3=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 =D0=
=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=B6=D0=
=BD=D0=B0 =D0=B1=D1=8B=D1=82=D1=8C =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=
=D0=B5=D0=BD=D0=B0."
=20
 #: gitk:396
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
-msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=B2 =D1=80=D0=B0=D0=BC=D0=BA=D0=B0=D1=85 =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=
=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=B0 "
-"=D0=B8=D0=BC=D0=B5=D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=
=BD=D0=B5=D1=82 =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE =D0=B3=
=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=D1=8C=
 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=
=D1=80=D0=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge,=
 =D0=BD=D0=BE =D0=B2 =D1=80=D0=B0=D0=BC=D0=BA=D0=B0=D1=85 =D1=83=D0=BA=D0=
=B0=D0=B7=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BE=D0=B3=D1=80=D0=B0=D0=
=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D0=BC=D0=B5=
=D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=BD=D0=B5=D1=82 =D0=
=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE =D0=B3=D0=B4=D0=B5 =D1=8D=
=D1=82=D0=B0 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=B4=D0=
=BE=D0=BB=D0=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=D1=8C =D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
=20
 #: gitk:418 gitk:566
 msgid "Error executing git log:"
@@ -58,7 +60,7 @@ msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5"
=20
 #: gitk:496 gitk:4525
 msgid "Reading commits..."
-msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D0=B9..."
+msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D0=BE=D0=B2..."
=20
 #: gitk:499 gitk:1637 gitk:4528
 msgid "No commits selected"
@@ -74,7 +76,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B2=D1=8B=D0=B2=D0=BE=D0=
=B4=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B git log:"
=20
 #: gitk:1740
 msgid "No commit information available"
-msgstr "=D0=9D=D0=B5=D1=82 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=86=D0=B8=D0=B8 =D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B8"
+msgstr "=D0=9D=D0=B5=D1=82 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=86=D0=B8=D0=B8 =D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5"
=20
 #: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
 msgid "OK"
@@ -167,7 +169,7 @@ msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
=20
 #: gitk:2295
 msgid "commit"
-msgstr "=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82"
=20
 #: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:68=
27
 #: gitk:6912
@@ -184,7 +186,7 @@ msgstr "=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D0=B2/=
=D1=83=D0=B4=D0=B0=D0=BB=D0=B8=D0=B2 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83=
:"
=20
 #: gitk:2304 gitk:4779
 msgid "changing lines matching:"
-msgstr ""
+msgstr "=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=8F =D1=81=D0=BE=D0=B2=D0=
=BF=D0=B0=D0=B4=D0=B0=D1=8E=D1=89=D0=B8=D0=B5 =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D0=B8:"
=20
 #: gitk:2313 gitk:2315 gitk:4766
 msgid "Exact"
@@ -217,7 +219,7 @@ msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
=20
 #: gitk:2319 gitk:4871 gitk:6786 gitk:7326
 msgid "Committer"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=B2=D1=88=D0=B8=D0=
=B9 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5=D1=80"
=20
 #: gitk:2350
 msgid "Search"
@@ -245,7 +247,7 @@ msgstr "=D0=98=D0=B3=D0=BD=D0=BE=D1=80=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=B1=D0=B5=D0=BB=D1=8B"
=20
 #: gitk:2378 gitk:2380 gitk:7959 gitk:8206
 msgid "Line diff"
-msgstr ""
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D1=
=82=D1=80=D0=BE=D0=BA"
=20
 #: gitk:2445
 msgid "Patch"
@@ -257,11 +259,11 @@ msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B"
=20
 #: gitk:2617 gitk:2637
 msgid "Diff this -> selected"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=
=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE=D1=82 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D1=81 =D0=B2=D1=8B=D0=B4=
=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
=20
 #: gitk:2618 gitk:2638
 msgid "Diff selected -> this"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=
=D0=BC =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9 =D1=81 =D1=8D=D1=82=D0=B8=
=D0=BC =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=BC"
=20
 #: gitk:2619 gitk:2639
 msgid "Make patch"
@@ -273,63 +275,59 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C=
 =D0=BC=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: gitk:2621 gitk:9371
 msgid "Write commit to file"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=
=D0=BB"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB"
=20
 #: gitk:2622 gitk:9428
 msgid "Create new branch"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=BA=D1=83"
=20
 #: gitk:2623
 msgid "Cherry-pick this commit"
-msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5"
+msgstr "=D0=9E=D1=82=D0=B1=D0=BE=D1=80 =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=
=B3=D0=BE =D0=B4=D0=BB=D1=8F =D1=8D=D1=82=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=
=D0=BC=D0=BC=D0=B8=D1=82=D0=B0"
=20
 #: gitk:2624
 msgid "Reset HEAD branch to here"
-msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C H=
EAD =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C H=
EAD =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE=D1=82 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=
=D1=82"
=20
 #: gitk:2625
-#, fuzzy
 msgid "Mark this commit"
-msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5"
+msgstr "=D0=9F=D0=BE=D0=BC=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE=D1=82 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82"
=20
 #: gitk:2626
 msgid "Return to mark"
-msgstr ""
+msgstr "=D0=92=D0=B5=D1=80=D0=BD=D1=83=D1=82=D1=8C=D1=81=D1=8F =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=BC=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: gitk:2627
 msgid "Find descendant of this and mark"
-msgstr ""
+msgstr "=D0=9D=D0=B0=D0=B9=D1=82=D0=B8 =D0=B8 =D0=BF=D0=BE=D0=BC=D0=B5=
=D1=82=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D1=82=D0=BE=D0=BC=D0=BA=D0=B0 =D1=
=8D=D1=82=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0"
=20
 #: gitk:2628
 msgid "Compare with marked commit"
-msgstr ""
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=81 =D0=BF=
=D0=BE=D0=BC=D0=B5=D1=87=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC =D0=BA=D0=BE=D0=BC=
=D0=BC=D0=B8=D1=82=D0=BE=D0=BC"
=20
 #: gitk:2629 gitk:2640
-#, fuzzy
 msgid "Diff this -> marked commit"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=
=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81 =D0=BF=D0=BE=D0=BC=
=D0=B5=D1=87=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=
=D1=82=D0=BE=D0=BC"
=20
 #: gitk:2630 gitk:2641
-#, fuzzy
 msgid "Diff marked commit -> this"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=
=D0=BC =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=
=BC=D0=B5=D1=87=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9 =D1=81 =D1=8D=D1=82=D0=B8=
=D0=BC =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=BC"
=20
 #: gitk:2631
-#, fuzzy
 msgid "Revert this commit"
-msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5"
+msgstr "=D0=92=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=82 =D1=8D=D1=82=D0=BE=D0=
=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0"
=20
 #: gitk:2647
 msgid "Check out this branch"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D1=8D=
=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D1=8D=
=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: gitk:2648
 msgid "Remove this branch"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D1=83 =
=D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D1=83 =
=D0=B2=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: gitk:2649
 msgid "Copy branch name"
-msgstr ""
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B8=D0=BC=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: gitk:2656
 msgid "Highlight this too"
@@ -345,11 +343,11 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=B0 =D1=81=D1=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: gitk:2659
 msgid "Blame parent commit"
-msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D1=81=D0=BA=D0=
=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80=D1=8B =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0"
=20
 #: gitk:2660
 msgid "Copy path"
-msgstr ""
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=BF=D1=83=D1=82=D1=8C"
=20
 #: gitk:2667
 msgid "Show origin of this line"
@@ -360,21 +358,14 @@ msgid "Run git gui blame on this line"
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git gui=
 blame =D0=B4=D0=BB=D1=8F =D1=8D=D1=82=D0=BE=D0=B9 =D1=81=D1=82=D1=80=D0=
=BE=D0=BA=D0=B8"
=20
 #: gitk:3014
-#, fuzzy
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
+"Copyright  2005-2014 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
-msgstr ""
-"\n"
-"Gitk - =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=
=80=D0=B8=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D0=B5=D0=B2 Git\n"
-"\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
-"\n"
-"=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=B8 =D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=B3=D0=BB=D0=B0=D1=81=
=D0=BD=D0=BE =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=D1=8F=D0=BC GNU Gener=
al Public License"
+msgstr "\nGitk - =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0=
 =D0=BF=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B0 =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D0=B5=D0=B2 git\n\n=C2=A9  2005-2014 Paul Mackerras\n\n=
=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=
=D0=B5 =D0=B8 =D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=B3=D0=BB=D0=B0=D1=81=D0=
=BD=D0=BE =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=D1=8F=D0=BC GNU General =
Public License"
=20
 #: gitk:3022 gitk:3089 gitk:9857
 msgid "Close"
@@ -394,87 +385,84 @@ msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\t=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D1=8C=
"
=20
 #: gitk:3049
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "<%s-W>\t\tClose window"
-msgstr "<%s-F>\t\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
+msgstr "<%s-W>\t\t=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D0=BE=D0=
=BA=D0=BD=D0=BE"
=20
 #: gitk:3050
 msgid "<Home>\t\tMove to first commit"
-msgstr "<Home>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<Home>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82=D1=83"
=20
 #: gitk:3051
 msgid "<End>\t\tMove to last commit"
-msgstr "<End>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<End>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=BC=D1=83 =D0=BA=D0=BE=D0=
=BC=D0=BC=D0=B8=D1=82=D1=83"
=20
 #: gitk:3052
-#, fuzzy
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Up>, p, i\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =
=D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<Up>, p, k\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D0=BE=D0=B4=D0=B8=D0=BD =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=B2=
=D0=B2=D0=B5=D1=80=D1=85"
=20
 #: gitk:3053
-#, fuzzy
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Down>, n, k\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA=
 =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<Down>, n, j\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=
=D0=B0 =D0=BE=D0=B4=D0=B8=D0=BD =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=
=B2=D0=BD=D0=B8=D0=B7"
=20
 #: gitk:3054
-#, fuzzy
 msgid "<Left>, z, h\tGo back in history list"
-msgstr "<Left>, z, j\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B0=D0=BD=D0=B5=D0=B5 =D0=BF=D0=BE=D1=81=D0=B5=D1=89=D1=91=D0=
=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B5"
+msgstr "<Left>, z, h\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B0=D0=BD=D0=B5=D0=B5 =D0=BF=D0=BE=D1=81=D0=B5=D1=89=D1=91=D0=
=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B5"
=20
 #: gitk:3055
 msgid "<Right>, x, l\tGo forward in history list"
-msgstr "<Right>, x, l\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=B5 =D0=BF=D0=BE=D1=
=81=D0=B5=D1=89=D1=91=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "<Right>, x, l\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D0=BF=D0=BE=D1=
=81=D0=B5=D1=89=D1=91=D0=BD=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82"
=20
 #: gitk:3056
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr ""
+msgstr "<%s-n>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0=
 n =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8F =D0=BE=D1=82 =D1=82=
=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=
=D1=82=D0=B0"
=20
 #: gitk:3057
 msgid "<PageUp>\tMove up one page in commit list"
-msgstr "<PageUp>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=B2=D1=8B=D1=88=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+msgstr "<PageUp>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=B2=D1=8B=D1=88=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82=D0=BE=D0=B2"
=20
 #: gitk:3058
 msgid "<PageDown>\tMove down one page in commit list"
-msgstr "<PageDown>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=BD=D0=B8=D0=B6=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+msgstr "<PageDown>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=BD=D0=B8=D0=B6=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82=D0=BE=D0=B2"
=20
 #: gitk:3059
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
-msgstr "<%s-Home>\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BE =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+msgstr "<%s-Home>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BE =D1=81=D0=BF=D0=B8=D1=81=D0=BA=
=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2"
=20
 #: gitk:3060
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
-msgstr "<%s-End>\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=
=BA=D0=BE=D0=BD=D0=B5=D1=86 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+msgstr "<%s-End>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D0=BA=D0=BE=D0=BD=D0=B5=D1=86 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0=
 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2"
=20
 #: gitk:3061
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
-msgstr "<%s-Up>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
+msgstr "<%s-Up>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D0=BE=D0=B2 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
=20
 #: gitk:3062
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
-msgstr "<%s-Down>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=B2=D0=BD=D0=B8=D0=B7"
+msgstr "<%s-Down>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=BA=D0=BE=D0=BC=D0=BC=
=D0=B8=D1=82=D0=BE=D0=B2 =D0=B2=D0=BD=D0=B8=D0=B7"
=20
 #: gitk:3063
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
-msgstr "<%s-PageUp>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D1=83 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
+msgstr "<%s-PageUp>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=BA=D0=BE=D0=BC=D0=BC=
=D0=B8=D1=82=D0=BE=D0=B2 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=
=B8=D1=86=D1=83 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
=20
 #: gitk:3064
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
-msgstr "<%s-PageDown>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=
=D1=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=
=D0=BD=D0=B8=D1=86=D1=83 =D0=B2=D0=BD=D0=B8=D0=B7"
+msgstr "<%s-PageDown>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=
=D1=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82=D0=BE=D0=B2 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=
=D0=B8=D1=86=D1=83 =D0=B2=D0=BD=D0=B8=D0=B7"
=20
 #: gitk:3065
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
-msgstr "<Shift-Up>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D0=BE=D0=B1=
=D1=80=D0=B0=D1=82=D0=BD=D0=BE=D0=BC =D0=BF=D0=BE=D1=80=D1=8F=D0=B4=D0=BA=
=D0=B5 (=D0=B2=D0=B2=D0=B5=D1=80=D1=85, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =
=D0=BD=D0=BE=D0=B2=D1=8B=D1=85 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=
=D0=B8=D0=B9)"
+msgstr "<Shift-Up>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D0=BE=D0=B1=
=D1=80=D0=B0=D1=82=D0=BD=D0=BE=D0=BC =D0=BF=D0=BE=D1=80=D1=8F=D0=B4=D0=BA=
=D0=B5 (=D0=B2=D0=B2=D0=B5=D1=80=D1=85, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =
=D0=BD=D0=BE=D0=B2=D1=8B=D1=85 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=
=D0=B2)"
=20
 #: gitk:3066
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
-msgstr "<Shift-Down>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA (=D0=B2=D0=BD=D0=B8=
=D0=B7, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =D1=81=D1=82=D0=B0=D1=80=D1=8B=D1=
=85 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9)"
+msgstr "<Shift-Down>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA (=D0=B2=D0=BD=D0=B8=
=D0=B7, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =D1=81=D1=82=D0=B0=D1=80=D1=8B=D1=
=85 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2)"
=20
 #: gitk:3067
 msgid "<Delete>, b\tScroll diff view up one page"
@@ -504,16 +492,15 @@ msgstr "<%s-F>\t\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
 #: gitk:3073
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
-msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D1=83"
=20
 #: gitk:3074
 msgid "<Return>\tMove to next find hit"
-msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D1=83"
=20
 #: gitk:3075
-#, fuzzy
 msgid "g\t\tGo to commit"
-msgstr "<End>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "g\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D0=
=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82"
=20
 #: gitk:3076
 msgid "/\t\tFocus the search box"
@@ -521,7 +508,7 @@ msgstr "/\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=
=B8 =D0=BA =D0=BF=D0=BE=D0=BB=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=B0=
"
=20
 #: gitk:3077
 msgid "?\t\tMove to previous find hit"
-msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D1=83"
=20
 #: gitk:3078
 msgid "f\t\tScroll diff view to next file"
@@ -569,7 +556,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=8F =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=
=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=
=D0=B0 %s:"
 #: gitk:3572
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F \"%s\" =D0=B8=D0=B7 %s:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F =C2=AB%s=C2=BB =D0=B8=D0=B7 %s:"
=20
 #: gitk:3635
 msgid "command failed:"
@@ -577,7 +564,7 @@ msgstr "=D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=
=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=
=D0=B0=D0=BD=D0=B4=D1=8B:"
=20
 #: gitk:3784
 msgid "No such commit"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=
=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=BD=D0=B5 =D0=BD=D0=B0=
=D0=B9=D0=B4=D0=B5=D0=BD"
=20
 #: gitk:3798
 msgid "git gui blame: command failed:"
@@ -610,8 +597,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=
=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F git blame: %s"
 #: gitk:3925
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
-msgstr ""
-"=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0 =D0=BF=D1=80=D0=
=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E %s, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D0=
=BE=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE=
 =D0=B2 =D1=8D=D1=82=D0=BE=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=
=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B8"
+msgstr "=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =D0=BA=D0=BE=
=D0=BC=D0=BC=D0=B8=D1=82=D1=83 %s, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=
=D0=B9 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D0=B2 =D1=
=8D=D1=82=D0=BE=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=
=BB=D0=B5=D0=BD=D0=B8=D0=B8"
=20
 #: gitk:3939
 msgid "External diff viewer failed:"
@@ -627,103 +613,97 @@ msgstr "=D0=97=D0=B0=D0=BF=D0=BE=D0=BC=D0=BD=D0=B8=
=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=
=D0=BD=D0=B8=D0=B5"
=20
 #: gitk:4075
 msgid "References (space separated list):"
-msgstr ""
+msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B8 (=D1=80=D0=B0=D0=B7=D0=B4=
=D0=B5=D0=BB=D1=91=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BF=D1=80=D0=BE=D0=B1=D0=B5=
=D0=BB=D0=BE=D0=BC):"
=20
 #: gitk:4076
 msgid "Branches & tags:"
-msgstr ""
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B8 =D0=B8 =D0=BC=D0=B5=D1=82=D0=BA=
=D0=B8"
=20
 #: gitk:4077
-#, fuzzy
 msgid "All refs"
-msgstr "=D0=92=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B"
+msgstr "=D0=92=D1=81=D0=B5 =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8"
=20
 #: gitk:4078
 msgid "All (local) branches"
-msgstr ""
+msgstr "=D0=92=D1=81=D0=B5 (=D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=
=D1=8B=D0=B5) =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: gitk:4079
 msgid "All tags"
-msgstr ""
+msgstr "=D0=92=D1=81=D0=B5 =D0=BC=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: gitk:4080
 msgid "All remote-tracking branches"
-msgstr ""
+msgstr "=D0=92=D1=81=D0=B5 =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B5 =
=D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D1=8B=
=D0=B5 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: gitk:4081
 msgid "Commit Info (regular expressions):"
-msgstr ""
+msgstr "=D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5 (=D1=80=D0=B5=D0=B3=D1=83=
=D0=BB=D1=8F=D1=80=D0=BD=D1=8B=D0=B5 =D0=B2=D1=8B=D1=80=D0=B0=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F):"
=20
 #: gitk:4082
-#, fuzzy
 msgid "Author:"
-msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
 #: gitk:4083
-#, fuzzy
 msgid "Committer:"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=B2=D1=88=D0=B8=D0=
=B9 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5=D1=80:"
=20
 #: gitk:4084
 msgid "Commit Message:"
-msgstr ""
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0:"
=20
 #: gitk:4085
 msgid "Matches all Commit Info criteria"
-msgstr ""
+msgstr "=D0=A1=D0=BE=D0=B2=D0=BF=D0=B0=D0=B4=D0=B0=D0=B5=D1=82 =D1=81=D0=
=BE =D0=B2=D1=81=D0=B5=D0=BC=D0=B8 =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=
=D1=8F=D0=BC=D0=B8 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=
=D0=B8 =D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5"
=20
 #: gitk:4086
 msgid "Matches no Commit Info criteria"
-msgstr ""
+msgstr "=D0=9D=D0=B5 =D1=81=D0=BE=D0=B2=D0=BF=D0=B0=D0=B4=D0=B0=D0=B5=D1=
=82 =D1=81 =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=D1=8F=D0=BC=D0=B8 =D0=B8=
=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5"
=20
 #: gitk:4087
 msgid "Changes to Files:"
-msgstr ""
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=84=D0=
=B0=D0=B9=D0=BB=D0=BE=D0=B2:"
=20
 #: gitk:4088
 msgid "Fixed String"
-msgstr ""
+msgstr "=D0=9E=D0=B1=D1=8B=D1=87=D0=BD=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=
=BE=D0=BA=D0=B0"
=20
 #: gitk:4089
 msgid "Regular Expression"
-msgstr ""
+msgstr "=D0=A0=D0=B5=D0=B3=D1=83=D0=BB=D1=8F=D1=80=D0=BD=D0=BE=D0=B5 =D0=
=B2=D1=8B=D1=80=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
=20
 #: gitk:4090
-#, fuzzy
 msgid "Search string:"
-msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
+msgstr "=D0=A1=D1=82=D1=80=D0=BE=D0=BA=D0=B0 =D0=B4=D0=BB=D1=8F =D0=BF=
=D0=BE=D0=B8=D1=81=D0=BA=D0=B0:"
=20
 #: gitk:4091
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
 "15:27:38\"):"
-msgstr ""
+msgstr "=D0=94=D0=B0=D1=82=D1=8B =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0 (=C2=AB2 =D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8 =D0=BD=D0=B0=D0=B7=D0=
=B0=D0=B4=C2=BB, =C2=AB2009-03-17 15:27:38=C2=BB, =C2=AB17 =D0=BC=D0=B0=
=D1=80=D1=82=D0=B0 2009 15:27:38=C2=BB):"
=20
 #: gitk:4092
-#, fuzzy
 msgid "Since:"
 msgstr "=D0=A1 =D0=B4=D0=B0=D1=82=D1=8B:"
=20
 #: gitk:4093
-#, fuzzy
 msgid "Until:"
 msgstr "=D0=9F=D0=BE =D0=B4=D0=B0=D1=82=D1=83:"
=20
 #: gitk:4094
 msgid "Limit and/or skip a number of revisions (positive integer):"
-msgstr ""
+msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D0=
=B8/=D0=B8=D0=BB=D0=B8 =D0=BF=D1=80=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=
=D1=82=D1=8C =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE=
 =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=D0=B8=D0=B9 (=D0=BF=D0=BE=D0=BB=D0=
=BE=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D1=87=D0=B8=D1=
=81=D0=BB=D0=BE):"
=20
 #: gitk:4095
 msgid "Number to show:"
-msgstr ""
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=
=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE:"
=20
 #: gitk:4096
 msgid "Number to skip:"
-msgstr ""
+msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D0=
=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE:"
=20
 #: gitk:4097
 msgid "Miscellaneous options:"
-msgstr ""
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D1=8B=D0=B5 =D0=BE=D0=
=BF=D1=86=D0=B8=D0=B8:"
=20
 #: gitk:4098
 msgid "Strictly sort by date"
@@ -731,7 +711,7 @@ msgstr "=D0=A1=D1=82=D1=80=D0=BE=D0=B3=D0=B0=D1=8F =
=D1=81=D0=BE=D1=80=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D0=BF=D0=BE=
 =D0=B4=D0=B0=D1=82=D0=B5"
=20
 #: gitk:4099
 msgid "Mark branch sides"
-msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=81=D1=82=D0=
=BE=D1=80=D0=BE=D0=BD=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=81=D1=82=D0=
=BE=D1=80=D0=BE=D0=BD=D1=8B =D0=B2=D0=B5=D1=82=D0=BE=D0=BA"
=20
 #: gitk:4100
 msgid "Limit to first parent"
@@ -739,12 +719,11 @@ msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=
=D0=B8=D1=82=D1=8C =D0=BF=D0=B5=D1=80=D0=B2=D1=8B=D0=BC =D0=BF=D1=80=D0=
=B5=D0=B4=D0=BA=D0=BE=D0=BC"
=20
 #: gitk:4101
 msgid "Simple history"
-msgstr ""
+msgstr "=D0=A3=D0=BF=D1=80=D0=BE=D1=89=D0=B5=D0=BD=D0=BD=D0=B0=D1=8F =D0=
=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F"
=20
 #: gitk:4102
-#, fuzzy
 msgid "Additional arguments to git log:"
-msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F (=D0=B0=D1=80=D0=B3=D1=83=D0=BC=
=D0=B5=D0=BD=D1=82=D1=8B =D0=B4=D0=BB=D1=8F git-log):"
+msgstr "=D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D1=8B=D0=B5 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=
=8B =D0=B4=D0=BB=D1=8F git log:"
=20
 #: gitk:4103
 msgid "Enter files and directories to include, one per line:"
@@ -752,21 +731,19 @@ msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8 =D0=
=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B4=D0=BB=D1=8F =D0=BE=
=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D1=81=
=D1=82=D0=BE=D1=80
=20
 #: gitk:4104
 msgid "Command to generate more commits to include:"
-msgstr "=D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B4=
=D0=BB=D1=8F =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9:"
+msgstr "=D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B4=
=D0=BB=D1=8F =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82=D0=BE=D0=B2:"
=20
 #: gitk:4228
 msgid "Gitk: edit view"
-msgstr ""
+msgstr "Gitk: =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=BF=D1=
=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5"
=20
 #: gitk:4236
-#, fuzzy
 msgid "-- criteria for selecting revisions"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=B4=D0=B5=
=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80=D0=B5 =D0=B2=
=D0=B5=D1=80=D1=81=D0=B8=D0=B8:"
+msgstr "=E2=80=94 =D0=BA=D1=80=D0=B8=D1=82=D0=B5=D1=80=D0=B8=D0=B9 =D0=
=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=B0 =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=D0=
=B8=D0=B9"
=20
 #: gitk:4241
-#, fuzzy
 msgid "View Name"
-msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5"
+msgstr "=D0=98=D0=BC=D1=8F =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=
=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: gitk:4316
 msgid "Apply (F5)"
@@ -774,7 +751,7 @@ msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=
=82=D1=8C (F5)"
=20
 #: gitk:4354
 msgid "Error in commit selection arguments:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=BF=D0=B0=D1=80=
=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D0=B0=D1=85 =D0=B2=D1=8B=D0=B1=D0=BE=D1=80=
=D0=B0 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=BF=D0=B0=D1=80=
=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D0=B0=D1=85 =D0=B2=D1=8B=D0=B1=D0=BE=D1=80=
=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2:"
=20
 #: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:1=
2374
 msgid "None"
@@ -798,23 +775,23 @@ msgstr "=D0=9D=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=
=D0=BA"
=20
 #: gitk:5324
 msgid "Local changes checked in to index but not committed"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=
=B0=D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=
=D0=B5, =D0=BD=D0=BE =D0=BD=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=
=91=D0=BD=D0=BD=D1=8B=D0=B5"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: gitk:5360
 msgid "Local uncommitted changes, not checked in to index"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =
=D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=
=D0=BE=D0=B3=D0=B5, =D0=BD=D0=B5 =D0=B7=D0=B0=D1=80=D0=B5=D0=B3=D0=B8=D1=
=81=D1=82=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=
=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=BE=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: gitk:7134
 msgid "and many more"
-msgstr ""
+msgstr "=D0=B8 =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D0=B5 =D0=B4=D1=80=D1=83=
=D0=B3=D0=BE=D0=B5"
=20
 #: gitk:7137
 msgid "many"
-msgstr ""
+msgstr "=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
=20
 #: gitk:7328
 msgid "Tags:"
-msgstr "=D0=A2=D0=B0=D0=B3=D0=B8:"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B8:"
=20
 #: gitk:7345 gitk:7351 gitk:8825
 msgid "Parent"
@@ -826,7 +803,7 @@ msgstr "=D0=9F=D0=BE=D1=82=D0=BE=D0=BC=D0=BE=D0=BA"
=20
 #: gitk:7365
 msgid "Branch"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0"
=20
 #: gitk:7368
 msgid "Follows"
@@ -851,9 +828,9 @@ msgid "Short SHA1 id %s is ambiguous"
 msgstr "=D0=A1=D0=BE=D0=BA=D1=80=D0=B0=D1=89=D1=91=D0=BD=D0=BD=D1=8B=D0=
=B9 SHA1 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80 %s =D0=BD=D0=B5=D0=BE=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=
=D1=87=D0=B5=D0=BD"
=20
 #: gitk:8678
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Revision %s is not known"
-msgstr "SHA1 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=
=B0=D1=82=D0=BE=D1=80 %s =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=
=BD"
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=D0=B8=D1=8F %s =D0=BD=D0=B5=
 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=B0"
=20
 #: gitk:8688
 #, tcl-format
@@ -863,7 +840,7 @@ msgstr "SHA1 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=
=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80 %s =D0=BD=D0=B5 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD"
 #: gitk:8690
 #, tcl-format
 msgid "Revision %s is not in the current view"
-msgstr ""
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=D0=B8=D1=8F %s =D0=BD=D0=B5=
 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=B0 =D0=B2 =D1=82=D0=B5=D0=BA=D1=
=83=D1=89=D0=B5=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=
=BB=D0=B5=D0=BD=D0=B8=D0=B8"
=20
 #: gitk:8832 gitk:8847
 msgid "Date"
@@ -876,62 +853,60 @@ msgstr "=D0=9F=D0=BE=D1=82=D0=BE=D0=BC=D0=BA=D0=B8=
"
 #: gitk:8898
 #, tcl-format
 msgid "Reset %s branch to here"
-msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=
=B2=D0=B5=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=
=82=D0=BA=D1=83 %s =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE=D1=82 =D0=BA=D0=BE=D0=
=BC=D0=BC=D0=B8=D1=82"
=20
 #: gitk:8900
 msgid "Detached head: can't reset"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=
=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =
=D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B8, =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B5=D0=B2=D0=BE=
=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=BD=D0=B5 =D0=BF=D1=80=
=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =D0=BD=D0=B8 =D0=
=BE=D0=B4=D0=BD=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B5, =D1=81=D0=B1=
=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=
=D0=BE=D0=B6=D0=BD=D0=BE"
=20
 #: gitk:9005 gitk:9011
 msgid "Skipping merge commit "
-msgstr ""
+msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D1=8E =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82-=D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5"
=20
 #: gitk:9020 gitk:9025
-#, fuzzy
 msgid "Error getting patch ID for "
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D1=82=D1=87=D0=B0:"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=
=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80 =D0=BF=D0=B0=D1=82=D1=87=
=D0=B0 =D0=B4=D0=BB=D1=8F "
=20
 #: gitk:9021 gitk:9026
 msgid " - stopping\n"
-msgstr ""
+msgstr " =E2=80=94 =D0=BE=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2\n"
=20
 #: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
-#, fuzzy
 msgid "Commit "
-msgstr "=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82"
=20
 #: gitk:9035
 msgid ""
 " is the same patch as\n"
 "       "
-msgstr ""
+msgstr " =D1=82=D0=B0=D0=BA=D0=BE=D0=B9 =D0=B6=D0=B5 =D0=BF=D0=B0=D1=82=
=D1=87, =D0=BA=D0=B0=D0=BA =D0=B8\n       "
=20
 #: gitk:9043
 msgid ""
 " differs from\n"
 "       "
-msgstr ""
+msgstr " =D0=BE=D1=82=D0=BB=D0=B8=D1=87=D0=B0=D0=B5=D1=82=D1=81=D1=8F =
=D0=BE=D1=82\n       "
=20
 #: gitk:9045
 msgid ""
 "Diff of commits:\n"
 "\n"
-msgstr ""
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=B8=D1=8F =D0=BA=D0=BE=D0=
=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2:\n\n"
=20
 #: gitk:9057 gitk:9066
 #, tcl-format
 msgid " has %s children - stopping\n"
-msgstr ""
+msgstr " =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F %s =D0=BF=D0=
=BE=D1=82=D0=BE=D0=BC=D0=BA=D0=BE=D0=BC =E2=80=94 =D0=BE=D1=81=D1=82=D0=
=B0=D0=BD=D0=BE=D0=B2\n"
=20
 #: gitk:9085
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Error writing commit to file: %s"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=
=BD=D0=B8=D1=8F:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=D1=88=D0=BB=D0=B0 =D0=BE=D1=
=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B8 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0 =D0=B2 =D1=84=D0=
=B0=D0=B9=D0=BB: %s"
=20
 #: gitk:9091
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Error diffing commits: %s"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=
=BD=D0=B8=D1=8F:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=D1=88=D0=BB=D0=B0 =D0=BE=D1=
=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B2=D1=8B=D0=B2=D0=BE=
=D0=B4=D0=B5 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=B8=D0=B9 =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2: %s"
=20
 #: gitk:9137
 msgid "Top"
@@ -983,12 +958,11 @@ msgstr "=D0=98=D0=BC=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=
=D0=B8:"
=20
 #: gitk:9268
 msgid "Tag message is optional"
-msgstr ""
+msgstr "=D0=9E=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =
=D0=BD=D0=B5 =D0=BE=D0=B1=D1=8F=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=
=D0=BE"
=20
 #: gitk:9270
-#, fuzzy
 msgid "Tag message:"
-msgstr "=D0=98=D0=BC=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=D0=B8:"
+msgstr "=D0=9E=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8:"
=20
 #: gitk:9274 gitk:9439
 msgid "Create"
@@ -1001,7 +975,7 @@ msgstr "=D0=9D=D0=B5 =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=
=D0=BE =D0=B8=D0=BC=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=D0=B8"
 #: gitk:9296
 #, tcl-format
 msgid "Tag \"%s\" already exists"
-msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0 \"%s\" =D1=83=D0=B6=D0=B5 =D1=81=
=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D1=83=D0=B6=D0=B5=
 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
=20
 #: gitk:9306
 msgid "Error creating tag:"
@@ -1017,7 +991,7 @@ msgstr "=D0=97=D0=B0=D0=BF=D0=B8=D1=81=D1=8C"
=20
 #: gitk:9408
 msgid "Error writing commit:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=
=BD=D0=B8=D1=8F:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=D1=88=D0=BB=D0=B0 =D0=BE=D1=
=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B8 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0:"
=20
 #: gitk:9435
 msgid "Name:"
@@ -1025,17 +999,17 @@ msgstr "=D0=98=D0=BC=D1=8F:"
=20
 #: gitk:9458
 msgid "Please specify a name for the new branch"
-msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B8=D0=BC=D1=8F =
=D0=B4=D0=BB=D1=8F =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=
=B2=D0=B8"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B8=D0=BC=D1=8F =
=D0=B4=D0=BB=D1=8F =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=
=BA=D0=B8"
=20
 #: gitk:9463
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82. =D0=9F=D0=B5=D1=80=
=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C?"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D1=83=D0=B6=D0=B5=
 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82. =D0=9F=D0=
=B5=D1=80=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C?"
=20
 #: gitk:9530
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D1=83=
=D0=B6=D0=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=
=D1=82 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=
=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D1=8E?"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 %s =D1=83=D0=B6=D0=B5 =D0=
=B2=D0=BA=D0=BB=D1=8E=D1=87=D1=91=D0=BD =D0=B2 =D0=B2=D0=B5=D1=82=D0=BA=
=D1=83 %s. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E?"
=20
 #: gitk:9535
 msgid "Cherry-picking"
@@ -1046,49 +1020,39 @@ msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9"
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
-msgstr ""
-"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=
=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B5 '%s'.\n"
-"=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=BB=D0=
=B8 =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8 =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=B8=D1=82=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8E."
+msgstr "=D0=9E=D1=82=D0=B1=D0=BE=D1=80 =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=
=B3=D0=BE =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD =
=D0=B8=D0=B7-=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9 =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B5 =C2=AB%s=C2=BB.\n=D0=97=
=D0=B0=D0=BA=D0=BE=D0=BC=D0=B8=D1=82=D1=8C=D1=82=D0=B5, =D1=81=D0=B1=D1=
=80=D0=BE=D1=81=D1=8C=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D1=81=D0=BF=D1=80=
=D1=8F=D1=87=D1=8C=D1=82=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F =D0=B8 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B8=D1=82=D0=
=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E."
=20
 #: gitk:9550
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
-msgstr ""
-"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5=D0=B2=D0=
=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BD=
=D0=B5=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=
=8F=D0=BD=D0=B8=D1=8F.\n"
-"=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git citool =D0=
=B4=D0=BB=D1=8F =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B8=D1=
=8F =D1=8D=D1=82=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8?"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5=
=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=
=B0 =D0=BD=D0=B5=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=
=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=
=B8=D1=82=D1=8C git citool =D0=B4=D0=BB=D1=8F =D0=B7=D0=B0=D0=B2=D0=B5=D1=
=80=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D1=8D=D1=82=D0=BE=D0=B9 =D0=BE=D0=BF=
=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8?"
=20
 #: gitk:9566 gitk:9624
 msgid "No changes committed"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=
=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D1=8B"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=
=B5 =D0=B7=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=87=D0=B5=D0=BD=D1=8B"
=20
 #: gitk:9593
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D1=83=
=D0=B6=D0=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=
=D1=82 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=
=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D1=8E?"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 %s =D0=BD=D0=B5 =D0=B2=D0=
=BA=D0=BB=D1=8E=D1=87=D1=91=D0=BD =D0=B2 =D0=B2=D0=B5=D1=82=D0=BA=D1=83=
 %s. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BE=
=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E?"
=20
 #: gitk:9598
-#, fuzzy
 msgid "Reverting"
-msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BA=D0=B0"
+msgstr "=D0=92=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=82 =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
=20
 #: gitk:9606
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
 "commit, reset or stash  your changes and try again."
-msgstr ""
-"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=
=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B5 '%s'.\n"
-"=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=BB=D0=
=B8 =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8 =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=B8=D1=82=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8E."
+msgstr "=D0=92=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=82 =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D1=81=D1=8F =D0=B8=D0=B7-=D0=B7=
=D0=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D1=85 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 =D1=83=D0=BA=D0=B0=
=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85=
: %s\n=D0=97=D0=B0=D0=BA=D0=BE=D0=BC=D0=B8=D1=82=D1=8C=D1=82=D0=B5, =D1=
=81=D0=B1=D1=80=D0=BE=D1=81=D1=8C=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D1=81=
=D0=BF=D1=80=D1=8F=D1=87=D1=8C=D1=82=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=
=B8=D1=82=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E."
=20
 #: gitk:9610
-#, fuzzy
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
-msgstr ""
-"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5=D0=B2=D0=
=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BD=
=D0=B5=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=
=8F=D0=BD=D0=B8=D1=8F.\n"
-"=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git citool =D0=
=B4=D0=BB=D1=8F =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B8=D1=
=8F =D1=8D=D1=82=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8?"
+msgstr "=D0=92=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=82 =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=
=BE=D0=B6=D0=B5=D0=BD =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BD=D0=B5=D0=B7=D0=B0=
=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=
=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F=
=2E\n=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git citool =
=D0=B4=D0=BB=D1=8F =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B8=
=D1=8F =D1=8D=D1=82=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8?"
=20
 #: gitk:9653
 msgid "Confirm reset"
@@ -1097,7 +1061,7 @@ msgstr "=D0=9F=D0=BE=D0=B4=D1=82=D0=B2=D0=B5=D1=80=
=D0=B4=D0=B8=D1=82=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E=
 =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=B4=D0=B0"
 #: gitk:9655
 #, tcl-format
 msgid "Reset branch %s to %s?"
-msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=
=B2=D0=B5=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B0 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s?"
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=
=82=D0=BA=D1=83 %s =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 %s=
?"
=20
 #: gitk:9657
 msgid "Reset type:"
@@ -1115,13 +1079,11 @@ msgstr "=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D0=
=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=
=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=
=D0=B3 =D0=BD=D0=B5
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
-msgstr ""
-"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
=D0=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3\n"
-"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=B5 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=
=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
+msgstr "=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=
=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=
=D1=81 =D0=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3\n(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=
=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B5 =D0=B1=D1=83=
=D0=B4=D1=83=D1=82 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
=20
 #: gitk:9683
 msgid "Resetting"
-msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BA=D0=B0"
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81"
=20
 #: gitk:9743
 msgid "Checking out"
@@ -1129,21 +1091,19 @@ msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=
=B4"
=20
 #: gitk:9796
 msgid "Cannot delete the currently checked-out branch"
-msgstr "=D0=90=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=B0=D1=8F =D0=B2=D0=B5=D1=
=82=D0=B2=D1=8C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=
=D1=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B0"
+msgstr "=D0=90=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=B0=D1=8F =D0=B2=D0=B5=D1=
=82=D0=BA=D0=B0 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=
=D1=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B0"
=20
 #: gitk:9802
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
-msgstr ""
-"=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 %s =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BD=D0=B5 =D0=
=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B0=D1=82 =D0=BD=D0=
=B8=D0=BA=D0=B0=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8.\n"
-"=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=
=BD=D0=BE =D1=83=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C %s?"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D1=8B =D0=B8=D0=B7 =D0=B2=
=D0=B5=D1=82=D0=BA=D0=B8 %s =D0=BD=D0=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=
=D0=B4=D0=BB=D0=B5=D0=B6=D0=B0=D1=82 =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B5=
 =D0=BD=D0=B8=D0=BA=D0=B0=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3=D0=
=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B5.\n=D0=94=D0=B5=D0=B9=D1=81=D1=82=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =D1=83=D0=B4=D0=B0=D0=BB=
=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=BA=D1=83 %s?"
=20
 #: gitk:9833
 #, tcl-format
 msgid "Tags and heads: %s"
-msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B8 =D0=B8 =D0=B2=D0=B5=D1=82=D0=B2=
=D0=B8: %s"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B8 =D0=B8 =D0=B2=D0=B5=D1=82=D0=BA=
=D0=B8: %s"
=20
 #: gitk:9850
 msgid "Filter"
@@ -1153,9 +1113,7 @@ msgstr "=D0=A4=D0=B8=D0=BB=D1=8C=D1=82=D1=80=D0=BE=
=D0=B2=D0=B0=D1=82=D1=8C"
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
-msgstr ""
-"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=87=D1=82=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D0=B8 =D0=BF=D1=80=D0=BE=D0=B5=
=D0=BA=D1=82=D0=B0; =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D1=8F=D1=85 =D0=B8 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F=D1=85 =D0=B2=D0=BE=D0=BA=D1=80=
=D1=83=D0=B3 =D0=BC=D0=B5=D1=82=D0=BE=D0=BA "
-"(=D0=B4=D0=BE/=D0=BF=D0=BE=D1=81=D0=BB=D0=B5) =D0=BC=D0=BE=D0=B6=D0=B5=
=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=BD=D0=B5=D0=BF=D0=BE=D0=BB=D0=BD=D0=
=BE=D0=B9."
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=87=D1=82=D0=B5=D0=BD=D0=
=B8=D1=8F =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D0=B8 =D0=BF=D1=80=D0=BE=
=D0=B5=D0=BA=D1=82=D0=B0; =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BE =D0=B2=D0=B5=D1=82=D0=BA=D0=B0=D1=85 =D0=B8 =D0=BA=
=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0=D1=85 =D0=B2=D0=BE=D0=BA=D1=80=D1=83=
=D0=B3 =D0=BC=D0=B5=D1=82=D0=BE=D0=BA (=D0=B4=D0=BE/=D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5) =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=BD=
=D0=B5=D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D0=B9."
=20
 #: gitk:11123
 msgid "Tag"
@@ -1179,7 +1137,7 @@ msgstr "=D0=9A"
=20
 #: gitk:11348
 msgid "Commit list display options"
-msgstr "=D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BF=D0=
=BE=D0=BA=D0=B0=D0=B7=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+msgstr "=D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BF=D0=
=BE=D0=BA=D0=B0=D0=B7=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D0=BA=
=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2"
=20
 #: gitk:11351
 msgid "Maximum graph width (lines)"
@@ -1195,13 +1153,12 @@ msgid "Show local changes"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=80=D0=B0=
=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=
=D0=B5"
=20
 #: gitk:11361
-#, fuzzy
 msgid "Auto-select SHA1 (length)"
-msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C SHA1"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=
=81=D0=BA=D0=B8 =D0=B2=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C SHA1 (=
=D0=B4=D0=BB=D0=B8=D0=BD=D0=BD=D0=B0)"
=20
 #: gitk:11365
 msgid "Hide remote refs"
-msgstr ""
+msgstr "=D0=A1=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=
=BD=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8"
=20
 #: gitk:11369
 msgid "Diff display options"
@@ -1212,13 +1169,12 @@ msgid "Tab spacing"
 msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D1=82=D0=B0=D0=B1=D1=83=D0=
=BB=D1=8F=D1=86=D0=B8=D0=B8"
=20
 #: gitk:11374
-#, fuzzy
 msgid "Display nearby tags/heads"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D0=B5 =D0=BC=D0=B5=D1=82=D0=BA=D0=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D0=B5 =D0=BC=D0=B5=D1=82=D0=BA=D0=B8/=
=D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: gitk:11377
 msgid "Maximum # tags/heads to show"
-msgstr ""
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=BC=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=
=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE =D0=BC=D0=B5=D1=
=82=D0=BE=D0=BA/=D0=B2=D0=B5=D1=82=D0=BE=D0=BA"
=20
 #: gitk:11380
 msgid "Limit diffs to listed paths"
@@ -1237,21 +1193,20 @@ msgid "Choose..."
 msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5..."
=20
 #: gitk:11395
-#, fuzzy
 msgid "General options"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D1=82=D1=
=87"
+msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D0=B8"
=20
 #: gitk:11398
 msgid "Use themed widgets"
-msgstr ""
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=81=D1=82=D0=B8=D0=BB=D0=B8 =D0=B2=D0=B8=D0=B4=D0=B6=D0=B5=
=D1=82=D0=BE=D0=B2"
=20
 #: gitk:11400
 msgid "(change requires restart)"
-msgstr ""
+msgstr "(=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=
=D0=BE=D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=
=D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=BA)"
=20
 #: gitk:11402
 msgid "(currently unavailable)"
-msgstr ""
+msgstr "(=D0=BD=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=BE =
=D0=B2 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D0=BC=D0=BE=D0=BC=D0=B5=D0=
=BD=D1=82)"
=20
 #: gitk:11413
 msgid "Colors: press to choose"
@@ -1259,12 +1214,11 @@ msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=B0: =D0=BD=D0=
=B0=D0=B6=D0=BC=D0=B8=D1=82=D0=B5 =D0=B4=D0=BB=D1=8F =D0=B2=D1=8B=D0=B1=
=D0=BE=D1=80=D0=B0"
=20
 #: gitk:11416
 msgid "Interface"
-msgstr ""
+msgstr "=D0=98=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
 #: gitk:11417
-#, fuzzy
 msgid "interface"
-msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
+msgstr "=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
 #: gitk:11420
 msgid "Background"
@@ -1339,17 +1293,16 @@ msgid "Gitk preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 Gitk"
=20
 #: gitk:11494
-#, fuzzy
 msgid "General"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
+msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B5"
=20
 #: gitk:11495
 msgid "Colors"
-msgstr ""
+msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=B0"
=20
 #: gitk:11496
 msgid "Fonts"
-msgstr ""
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D1=8B"
=20
 #: gitk:11546
 #, tcl-format
@@ -1360,9 +1313,7 @@ msgstr "Gitk: =D0=B2=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=
=D1=82=D0=B5 =D1=86=D0=B2=D0=B5=D1=82 =D0=B4=D0=BB=D1=8F %s"
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
-msgstr ""
-"=D0=9A =D1=81=D0=BE=D0=B6=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8E gitk =D0=
=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=B0=D1=82=D1=8C =D1=81 =D1=8D=D1=82=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D0=B9 Tcl/Tk.\n"
-"=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=BA=D0=B0=D0=
=BA =D0=BC=D0=B8=D0=BD=D0=B8=D0=BC=D1=83=D0=BC Tcl/Tk 8.4."
+msgstr "=D0=9A =D1=81=D0=BE=D0=B6=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8E =
gitk =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=
=D1=82=D0=B0=D1=82=D1=8C =D1=81 =D1=8D=D1=82=D0=BE=D0=B9 =D0=B2=D0=B5=D1=
=80=D1=81=D0=B8=D0=B9 Tcl/Tk.\n=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=
=D1=81=D1=8F =D0=BA=D0=B0=D0=BA =D0=BC=D0=B8=D0=BD=D0=B8=D0=BC=D1=83=D0=
=BC Tcl/Tk 8.4."
=20
 #: gitk:12269
 msgid "Cannot find a git repository here."
@@ -1371,38 +1322,8 @@ msgstr "Git-=D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=
=B5=D0=BD =D0=B2 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=BC =D0=BA=D0=B0=
=D1=82=D0=B0
 #: gitk:12316
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
-msgstr "=D0=9D=D0=B5=D0=BE=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=BD=D1=8B=D0=B9 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 '%s': =
=D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D0=BA=D0=B0=
=D0=BA =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B8 =D0=B8=D0=BC=D1=8F =D1=
=84=D0=B0=D0=B9=D0=BB=D0=B0"
+msgstr "=D0=9D=D0=B5=D0=BE=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=BD=D1=8B=D0=B9 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =C2=AB=
%s=C2=BB: =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =
=D0=BA=D0=B0=D0=BA =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=86=D0=B8=D1=8F =D0=
=B8 =D0=BA=D0=B0=D0=BA =D0=B8=D0=BC=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=
"
=20
 #: gitk:12328
 msgid "Bad arguments to gitk:"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D1=
=8B=D0=B5 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B =D0=B4=
=D0=BB=D1=8F gitk:"
-
-#~ msgid "SHA1 ID: "
-#~ msgstr "SHA1:"
-
-#~ msgid "next"
-#~ msgstr "=D0=A1=D0=BB=D0=B5=D0=B4."
-
-#~ msgid "prev"
-#~ msgstr "=D0=9F=D1=80=D0=B5=D0=B4."
-
-#~ msgid "Use all refs"
-#~ msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D1=8C =D0=B2=D1=81=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
-
-#~ msgid "Max count:"
-#~ msgstr "=D0=9C=D0=B0=D0=BA=D1=81. =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=
=B5=D1=81=D1=82=D0=B2=D0=BE:"
-
-#~ msgid "Skip:"
-#~ msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C=
:"
-
-#~ msgid "Name"
-#~ msgstr "=D0=98=D0=BC=D1=8F"
-
-#~ msgid "CDate"
-#~ msgstr "=D0=94=D0=B0=D1=82=D0=B0 =D0=B2=D0=B2=D0=BE=D0=B4=D0=B0"
-
-#~ msgid "Tag/Head %s is not known"
-#~ msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0 =D0=B8=D0=BB=D0=B8 =D0=B2=D0=
=B5=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=
=BD=D0=B0"
-
-#~ msgid "Cannot find the git directory \"%s\"."
-#~ msgstr "Git-=D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=B0=D1=80=D0=
=B8=D0=B9 \"%s\" =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD."
--=20
2.6.0
