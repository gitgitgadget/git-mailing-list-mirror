From: ash@kambanaria.org
Subject: [PATCH] gitk: Updated Bulgarian translation (302t,0f,0u)
Date: Sun,  3 Aug 2014 15:36:43 +0300
Message-ID: <1407069403-8495-2-git-send-email-ash@kambanaria.org>
References: <1407069403-8495-1-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 14:37:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDv2F-00056y-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 14:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbaHCMg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2014 08:36:59 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35630 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaHCMg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 08:36:56 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so3603675wiw.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2014 05:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=UxgRMT6JcEShOkD7qRpQAseA7osOefMdcK7L1MbwDsg=;
        b=c6TASrN+wQq1TU4x5fR+xxSHABRjp3QlZnsUlEGHN3qLs+0113QmmZyJqedX/bt7qo
         S8oTyEHSYZNqi5vtGt0WejpCxlHM29MaJztDzYPnl60mKTCj4auC9dyxNRdQ5QICHL0u
         U0TSN0gpfoJ6Nzvzpb9MNex+nHcEn0Pir4n5YLfpmGvIkcwbCdxK4ZVTKBSBEanm1mWL
         cZtE7OCCPK2uWkEBGP7vBiYRWF2Bi15nMBVrBh9DYS9WNbjez0pr4wQ6+lrO0zl07J6A
         9FakMzbPZtXCVmsl0NpPY6A6vo2chbZ62QyQ4hixs1go5QTM4RXfYusjFL4zLX9RVpIw
         Xzhw==
X-Gm-Message-State: ALoCoQnD2DS8e6pcJg4m1mmW3aMYX5y+VJAO0ASd7hCNcyK/d/qexcgdJFQbJyCObpVYW4jnzKd0
X-Received: by 10.194.134.228 with SMTP id pn4mr23121714wjb.111.1407069414704;
        Sun, 03 Aug 2014 05:36:54 -0700 (PDT)
Received: from dalgonosko.lan (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id mw4sm3559619wic.20.2014.08.03.05.36.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2014 05:36:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1407069403-8495-1-git-send-email-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254725>

=46rom: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 652 ++++++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 329 insertions(+), 323 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 782397e..f86a161 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
-"PO-Revision-Date: 2014-01-08 08:03+0200\n"
+"POT-Creation-Date: 2014-08-03 11:17+0300\n"
+"PO-Revision-Date: 2014-07-28 07:32+0300\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -22,11 +22,11 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "=D0=A1=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D1=8A=D1=82 =D1=81 =D0=BD=
=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=
=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=
=B4=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD:"
=20
-#: gitk:212 gitk:2353
+#: gitk:212 gitk:2379
 msgid "Color words"
 msgstr "=D0=9E=D1=86=D0=B2=D0=B5=D1=82=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
=20
-#: gitk:217 gitk:2353 gitk:8103 gitk:8136
+#: gitk:217 gitk:2379 gitk:8155 gitk:8188
 msgid "Markup words"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
=20
@@ -40,13 +40,16 @@ msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =D1=
=81 =E2=80=9E-
=20
 #: gitk:391
 msgid "No files selected: --merge specified but no files are unmerged.=
"
-msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=
=D0=B0=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=
=82=D0=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=
=B0 =D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=D0=B5."
+msgstr ""
+"=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=D0=B0=
=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=82=D0=
=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=B0 =D0=
=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=
=B2=D0=B5."
=20
 #: gitk:394
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
-msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=
=D0=B0=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=
=82=D0=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=
=B0 =D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=D0=B5 =D0=B2 =D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=
=B5=D0=BD=D0=B8=D1=8F=D1=82=D0=B0."
+msgstr ""
+"=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=D0=B0=
=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=82=D0=
=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=B0 =D0=
=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=
=B2=D0=B5 "
+"=D0=B2 =D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=
=8F=D1=82=D0=B0."
=20
 #: gitk:416 gitk:564
 msgid "Error executing git log:"
@@ -56,11 +59,11 @@ msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B0 =E2=80=9Egit log=E2=80=9C:"
 msgid "Reading"
 msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:494 gitk:4429
+#: gitk:494 gitk:4470
 msgid "Reading commits..."
 msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0=E2=
=80=A6"
=20
-#: gitk:497 gitk:1635 gitk:4432
+#: gitk:497 gitk:1635 gitk:4473
 msgid "No commits selected"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
@@ -76,12 +79,12 @@ msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=
=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=
=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
 msgid "mc"
 msgstr "mc"
=20
-#: gitk:1930 gitk:4222 gitk:9552 gitk:11122 gitk:11401
+#: gitk:1930 gitk:4263 gitk:9604 gitk:11174 gitk:11453
 msgid "OK"
 msgstr "=D0=94=D0=BE=D0=B1=D1=80=D0=B5"
=20
-#: gitk:1932 gitk:4224 gitk:9079 gitk:9158 gitk:9274 gitk:9323 gitk:95=
54
-#: gitk:11123 gitk:11402
+#: gitk:1932 gitk:4265 gitk:9131 gitk:9210 gitk:9326 gitk:9375 gitk:96=
06
+#: gitk:11175 gitk:11454
 msgid "Cancel"
 msgstr "=D0=9E=D1=82=D0=BA=D0=B0=D0=B7"
=20
@@ -103,7 +106,7 @@ msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=
=D0=BB=D0=B8=D1=82=D0=B5"
=20
 #: gitk:2072
 msgid "Start git gui"
-msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 git gui"
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui=E2=80=9C"
=20
 #: gitk:2074
 msgid "Quit"
@@ -137,11 +140,11 @@ msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=
=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
 msgid "All files"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2=D0=B5"
=20
-#: gitk:2081 gitk:3975
+#: gitk:2081 gitk:4016
 msgid "View"
 msgstr "=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:2091 gitk:2101 gitk:2945
+#: gitk:2091 gitk:2101 gitk:2976
 msgid "About gitk"
 msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
=20
@@ -153,7 +156,7 @@ msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=
=B8 =D0=BA=D0=BE=D0=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
 msgid "Help"
 msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89"
=20
-#: gitk:2183 gitk:8535
+#: gitk:2183 gitk:8587
 msgid "SHA1 ID:"
 msgstr "SHA1:"
=20
@@ -165,708 +168,706 @@ msgstr "=D0=A0=D0=B5=D0=B4"
 msgid "Find"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:2266
-msgid "next"
-msgstr "=D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=BE"
-
-#: gitk:2267
-msgid "prev"
-msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=BE"
-
-#: gitk:2268
+#: gitk:2293
 msgid "commit"
 msgstr "=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2271 gitk:2273 gitk:4590 gitk:4613 gitk:4637 gitk:6653 gitk:67=
25
-#: gitk:6810
+#: gitk:2297 gitk:2299 gitk:4631 gitk:4654 gitk:4678 gitk:6698 gitk:67=
70
+#: gitk:6855
 msgid "containing:"
 msgstr "=D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D1=89=D0=BE:"
=20
-#: gitk:2274 gitk:3457 gitk:3462 gitk:4666
+#: gitk:2300 gitk:3488 gitk:3493 gitk:4707
 msgid "touching paths:"
 msgstr "=D0=B7=D0=B0=D1=81=D1=8F=D0=B3=D0=B0=D1=89=D0=BE =D0=BF=D1=8A=D1=
=82=D0=B8=D1=89=D0=B0=D1=82=D0=B0:"
=20
-#: gitk:2275 gitk:4680
+#: gitk:2301 gitk:4721
 msgid "adding/removing string:"
 msgstr "=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D1=89=D0=BE/=D0=BF=D1=80=D0=
=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D1=89=D0=BE =D0=BD=D0=B8=D0=B7"
=20
-#: gitk:2276 gitk:4682
+#: gitk:2302 gitk:4723
 msgid "changing lines matching:"
 msgstr "=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D1=8F=D1=89=D0=BE =D1=80=D0=
=B5=D0=B4=D0=BE=D0=B2=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B0=D1=81=D0=B2=D0=B0=D1=
=89=D0=B8:"
=20
-#: gitk:2285 gitk:2287 gitk:4669
+#: gitk:2311 gitk:2313 gitk:4710
 msgid "Exact"
 msgstr "=D0=A2=D0=BE=D1=87=D0=BD=D0=BE"
=20
-#: gitk:2287 gitk:4757 gitk:6621
+#: gitk:2313 gitk:4798 gitk:6666
 msgid "IgnCase"
 msgstr "=D0=91=D0=B5=D0=B7 =D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=8A=D1=
=80"
=20
-#: gitk:2287 gitk:4639 gitk:4755 gitk:6617
+#: gitk:2313 gitk:4680 gitk:4796 gitk:6662
 msgid "Regexp"
-msgstr "=D0=A0=D0=B5=D0=B3. =D0=B8=D0=B7=D1=80."
+msgstr "=D0=A0=D0=B5=D0=B3. =D0=B8=D0=B7=D1=80=D0=B0=D0=B7"
=20
-#: gitk:2289 gitk:2290 gitk:4777 gitk:4807 gitk:4814 gitk:6746 gitk:68=
14
+#: gitk:2315 gitk:2316 gitk:4818 gitk:4848 gitk:4855 gitk:6791 gitk:68=
59
 msgid "All fields"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B5=D1=
=82=D0=B0"
=20
-#: gitk:2290 gitk:4774 gitk:4807 gitk:6684
+#: gitk:2316 gitk:4815 gitk:4848 gitk:6729
 msgid "Headline"
 msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:2291 gitk:4774 gitk:6684 gitk:6814 gitk:7283
+#: gitk:2317 gitk:4815 gitk:6729 gitk:6859 gitk:7332
 msgid "Comments"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8"
=20
-#: gitk:2291 gitk:4774 gitk:4779 gitk:4814 gitk:6684 gitk:7218 gitk:87=
13
-#: gitk:8728
+#: gitk:2317 gitk:4815 gitk:4820 gitk:4855 gitk:6729 gitk:7267 gitk:87=
65
+#: gitk:8780
 msgid "Author"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
=20
-#: gitk:2291 gitk:4774 gitk:6684 gitk:7220
+#: gitk:2317 gitk:4815 gitk:6729 gitk:7269
 msgid "Committer"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D1=89"
=20
-#: gitk:2322
+#: gitk:2348
 msgid "Search"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:2330
+#: gitk:2356
 msgid "Diff"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:2332
+#: gitk:2358
 msgid "Old version"
 msgstr "=D0=A1=D1=82=D0=B0=D1=80=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=
=8F"
=20
-#: gitk:2334
+#: gitk:2360
 msgid "New version"
 msgstr "=D0=9D=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
=20
-#: gitk:2336
+#: gitk:2362
 msgid "Lines of context"
 msgstr "=D0=9A=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B2 =D1=80=
=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:2346
+#: gitk:2372
 msgid "Ignore space change"
 msgstr "=D0=9F=D1=80=D0=B0=D0=B7=D0=BD=D0=B8=D1=82=D0=B5 =D0=B7=D0=BD=D0=
=B0=D1=86=D0=B8 =D0=B1=D0=B5=D0=B7 =D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=
=D0=B8=D0=B5"
=20
-#: gitk:2350 gitk:2352 gitk:7842 gitk:8089
+#: gitk:2376 gitk:2378 gitk:7894 gitk:8141
 msgid "Line diff"
 msgstr "=D0=9F=D0=BE=D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B8 =D1=80=D0=B0=D0=
=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:2417
+#: gitk:2443
 msgid "Patch"
 msgstr "=D0=9A=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:2419
+#: gitk:2445
 msgid "Tree"
 msgstr "=D0=94=D1=8A=D1=80=D0=B2=D0=BE"
=20
-#: gitk:2577 gitk:2597
+#: gitk:2604 gitk:2624
 msgid "Diff this -> selected"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=
=D0=BD=D0=BE=D1=82=D0=BE"
=20
-#: gitk:2578 gitk:2598
+#: gitk:2605 gitk:2625
 msgid "Diff selected -> this"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D1=82=D0=BE =D0=B8=
 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2579 gitk:2599
+#: gitk:2606 gitk:2626
 msgid "Make patch"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:2580 gitk:9137
+#: gitk:2607 gitk:9189
 msgid "Create tag"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:2581 gitk:9254
+#: gitk:2608 gitk:9306
 msgid "Write commit to file"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=
=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:2582 gitk:9311
+#: gitk:2609 gitk:9363
 msgid "Create new branch"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=BE=D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2583
+#: gitk:2610
 msgid "Cherry-pick this commit"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
=20
-#: gitk:2584
+#: gitk:2611
 msgid "Reset HEAD branch to here"
 msgstr "=D0=9F=D1=80=D0=B8=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B2=D1=8A=D1=80=D1=85=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B0 =D0=BA=D1=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2585
+#: gitk:2612
 msgid "Mark this commit"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=
=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2586
+#: gitk:2613
 msgid "Return to mark"
 msgstr "=D0=92=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2587
+#: gitk:2614
 msgid "Find descendant of this and mark"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B8 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=86=D0=B8=D1=82=
=D0=B5"
=20
-#: gitk:2588
+#: gitk:2615
 msgid "Compare with marked commit"
 msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2589 gitk:2600
+#: gitk:2616 gitk:2627
 msgid "Diff this -> marked commit"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE"
=20
-#: gitk:2590 gitk:2601
+#: gitk:2617 gitk:2628
 msgid "Diff marked commit -> this"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=
=82=D0=BE =D0=B8 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2591
+#: gitk:2618
 msgid "Revert this commit"
 msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=82=D0=BE=
=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2607
+#: gitk:2634
 msgid "Check out this branch"
 msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2608
+#: gitk:2635
 msgid "Remove this branch"
 msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2615
+#: gitk:2642
 msgid "Highlight this too"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=B8 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2616
+#: gitk:2643
 msgid "Highlight this only"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D1=81=D0=B0=D0=BC=D0=BE =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2617
+#: gitk:2644
 msgid "External diff"
 msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=
=D0=B8"
=20
-#: gitk:2618
+#: gitk:2645
 msgid "Blame parent commit"
 msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=BE=D1=82=D0=
=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2625
+#: gitk:2652
 msgid "Show origin of this line"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:2626
+#: gitk:2653
 msgid "Run git gui blame on this line"
 msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui blame=E2=80=9C =D0=B2=D1=8A=D1=80=D1=85=D1=83=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:2947
+#: gitk:2978
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2011 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk =E2=80=94 =D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=
=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=B2 Git\n"
 "\n"
-"=D0=90=D0=B2=D1=82=D0=BE=D1=80=D1=81=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=
=B2=D0=B0: =C2=A9 2005-2011 Paul Mackerras\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D1=80=D1=81=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=
=B2=D0=B0: =C2=A9 2005-2014 Paul Mackerras\n"
 "\n"
 "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=
=B8 =D1=80=D0=B0=D0=B7=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=B8 =D1=83=D1=81=D0=BB=
=D0=BE=D0=B2=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 =D0=9E=D0=9F=D0=9B =D0=
=BD=D0=B0 =D0=93=D0=9D=D0=A3"
=20
-#: gitk:2955 gitk:3020 gitk:9738
+#: gitk:2986 gitk:3051 gitk:9790
 msgid "Close"
 msgstr "=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5"
=20
-#: gitk:2976
+#: gitk:3007
 msgid "Gitk key bindings"
 msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
=20
-#: gitk:2979
+#: gitk:3010
 msgid "Gitk key bindings:"
 msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8:"
=20
-#: gitk:2981
+#: gitk:3012
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\t=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
=20
-#: gitk:2982
+#: gitk:3013
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\t=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5=
 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86=D0=B0"
=20
-#: gitk:2983
+#: gitk:3014
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2984
+#: gitk:3015
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=
=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
=20
-#: gitk:2985
+#: gitk:3016
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
=20
-#: gitk:2986
+#: gitk:3017
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
=20
-#: gitk:2987
+#: gitk:3018
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\t=D0=9D=D0=B0=D0=B7=D0=B0=D0=B4 =D0=B2 =D0=B8=D1=81=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:2988
+#: gitk:3019
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\t=D0=9D=D0=B0=D0=BF=D1=80=D0=B5=D0=B4 =D0=B2 =D0=
=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:2989
+#: gitk:3020
 msgid "<PageUp>\tMove up one page in commit list"
-msgstr "<PageUp>\t=D0=95=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
+msgstr "<PageUp>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=
=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=
=8F=D1=82=D0=B0"
=20
-#: gitk:2990
+#: gitk:3021
 msgid "<PageDown>\tMove down one page in commit list"
-msgstr "<PageDown>\t=D0=95=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
+msgstr "<PageDown>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=
=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=
=8F=D1=82=D0=B0"
=20
-#: gitk:2991
+#: gitk:3022
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\t=D0=9A=D1=8A=D0=BC =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BE=D1=82=D0=BE =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0"
=20
-#: gitk:2992
+#: gitk:3023
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\t=D0=9A=D1=8A=D0=BC =D0=BA=D1=80=D0=B0=D1=8F =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:2993
+#: gitk:3024
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
-msgstr "<%s-Up>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=
=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=
=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=B5=
=D0=B4=D0=B8=D0=BD =D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=
=B5"
+msgstr "<%s-Up>\t=D0=A0=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5=
 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=
=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:2994
+#: gitk:3025
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
-msgstr "<%s-Down>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=
=B5=D0=B4=D0=B8=D0=BD =D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=
=D1=83"
+msgstr "<%s-Down>\t=D0=A0=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=
=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:2995
+#: gitk:3026
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
-msgstr "<%s-PageUp>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=
=B5=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
+msgstr "<%s-PageUp>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=
=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=
=D1=8F"
=20
-#: gitk:2996
+#: gitk:3027
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
-msgstr "<%s-PageDown>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=
=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=
=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81=
 =D0=B5=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=
=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
+msgstr "<%s-PageDown>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=
=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=
=D1=8F"
=20
-#: gitk:2997
+#: gitk:3028
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0=D0=B7=D0=B0=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5, =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D0=BE=D1=81=D0=BB=D0=
=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8)"
=20
-#: gitk:2998
+#: gitk:3029
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
-msgstr "<Shift-Down>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=
=D0=B0=D0=BF=D1=80=D0=B5=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=
=BD=D0=BE =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83, =D0=B8=D1=81=D1=82=D0=BE=
=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D1=80=D0=B5=
=D0=B4=D1=85=D0=BE=D0=B6=D0=B4=D0=B0=D1=89=D0=B8)"
+msgstr ""
+"<Shift-Down>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=B0=
=D0=BF=D1=80=D0=B5=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=BD=D0=
=BE =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83, =D0=B8=D1=81=D1=82=D0=BE=D1=80=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D1=80=D0=B5=D0=B4=
=D1=85=D0=BE=D0=B6=D0=B4=D0=B0=D1=89=D0=B8)"
=20
-#: gitk:2999
+#: gitk:3030
 msgid "<Delete>, b\tScroll diff view up one page"
-msgstr "<Delete>, b\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B3=D0=BE=D1=80=D0=B5"
+msgstr "<Delete>, b\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=
=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=
"
=20
-#: gitk:3000
+#: gitk:3031
 msgid "<Backspace>\tScroll diff view up one page"
-msgstr "<Backspace>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B3=D0=BE=D1=80=D0=B5"
+msgstr "<Backspace>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=
=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=
"
=20
-#: gitk:3001
+#: gitk:3032
 msgid "<Space>\t\tScroll diff view down one page"
-msgstr "<Space>\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B4=D0=BE=D0=BB=D1=83"
+msgstr "<Space>\t\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=
=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3002
+#: gitk:3033
 msgid "u\t\tScroll diff view up 18 lines"
-msgstr "u\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 18 =D1=80=D0=B5=D0=B4=
=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
+msgstr "u\t\t18 =D1=80=D0=B5=D0=B4=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=
=D0=B5 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=
=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3003
+#: gitk:3034
 msgid "d\t\tScroll diff view down 18 lines"
-msgstr "d\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 18 =D1=80=D0=B5=D0=B4=
=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
+msgstr "d\t\t18 =D1=80=D0=B5=D0=B4=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=
=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=
=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3004
+#: gitk:3035
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3005
+#: gitk:3036
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3006
+#: gitk:3037
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3007
+#: gitk:3038
 msgid "/\t\tFocus the search box"
 msgstr "/\t\t=D0=A4=D0=BE=D0=BA=D1=83=D1=81 =D0=B2=D1=8A=D1=80=D1=85=D1=
=83 =D0=BF=D0=BE=D0=BB=D0=B5=D1=82=D0=BE =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=
=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3008
+#: gitk:3039
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=
=BD=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3009
+#: gitk:3040
 msgid "f\t\tScroll diff view to next file"
-msgstr "f\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BA=D1=8A=D0=BC =D1=
=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=8F =D1=80=D0=B5=D0=B4"
+msgstr "f\t\t=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89 =D1=84=D0=B0=D0=
=B9=D0=BB =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0=
 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3010
+#: gitk:3041
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3011
+#: gitk:3042
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3012
+#: gitk:3043
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3013
+#: gitk:3044
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3014
+#: gitk:3045
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3015
+#: gitk:3046
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=
=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=
=82=D0=B0"
=20
-#: gitk:3016
+#: gitk:3047
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\t=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=
=D0=B5"
=20
-#: gitk:3471 gitk:3480
+#: gitk:3512 gitk:3521
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=
=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =E2=80=9E%s=E2=80=9C=
:"
=20
-#: gitk:3493
+#: gitk:3534
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BE=D1=82 %s:"
=20
-#: gitk:3556
+#: gitk:3597
 msgid "command failed:"
 msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=
=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:3705
+#: gitk:3746
 msgid "No such commit"
 msgstr "=D0=A2=D0=B0=D0=BA=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D1=8F=D0=BC=D0=B0"
=20
-#: gitk:3719
+#: gitk:3760
 msgid "git gui blame: command failed:"
-msgstr "git gui blame: =D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=
=D0=BE =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+msgstr "=E2=80=9Egit gui blame=E2=80=9C: =D0=BD=D0=B5=D1=83=D1=81=D0=BF=
=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:3750
+#: gitk:3791
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "=D0=92=D1=8A=D1=80=D1=85=D1=8A=D1=82 =D0=B7=D0=B0 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=D1=80=D0=BE=D1=87=D0=B5=D1=82=
=D0=B5=D0=BD: %s"
=20
-#: gitk:3758
+#: gitk:3799
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0: %s"
=20
-#: gitk:3783
+#: gitk:3824
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =E2=80=9E=
git blame=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=
=B1=D1=8A=D0=B4=D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B0: %s"
=20
-#: gitk:3786 gitk:6652
+#: gitk:3827 gitk:6697
 msgid "Searching"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3818
+#: gitk:3859
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9Egit blame=E2=80=9C: %s"
=20
-#: gitk:3846
+#: gitk:3887
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "=D0=A2=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4 =D0=B8=D0=B4=D0=B2=
=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE %s,  =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D0=B5 =D0=B2=
 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
=20
-#: gitk:3860
+#: gitk:3901
 msgid "External diff viewer failed:"
 msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=B2=
=D1=8A=D0=BD=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=
=B8:"
=20
-#: gitk:3978
+#: gitk:4019
 msgid "Gitk view definition"
 msgstr "=D0=94=D0=B5=D1=84=D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D1=8F =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4 =D0=B2 Gitk"
=20
-#: gitk:3982
+#: gitk:4023
 msgid "Remember this view"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:3983
+#: gitk:4024
 msgid "References (space separated list):"
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8 (=D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA =D1=81 =D1=80=D0=B0=D0=B7=D0=B4=D0=B5=D0=
=BB=D0=B8=D1=82=D0=B5=D0=BB =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=B2=D0=B0=D0=
=BB):"
=20
-#: gitk:3984
+#: gitk:4025
 msgid "Branches & tags:"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8 =D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=
=D0=B5=D1=82=D0=B8:"
=20
-#: gitk:3985
+#: gitk:4026
 msgid "All refs"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=
=B0=D1=82=D0=B5=D0=BB=D0=B8"
=20
-#: gitk:3986
+#: gitk:4027
 msgid "All (local) branches"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 (=D0=BB=D0=BE=D0=BA=D0=B0=
=D0=BB=D0=BD=D0=B8) =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
=20
-#: gitk:3987
+#: gitk:4028
 msgid "All tags"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=D0=
=B5=D1=82=D0=B8"
=20
-#: gitk:3988
+#: gitk:4029
 msgid "All remote-tracking branches"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=81=D0=BB=D0=B5=D0=B4=D1=
=8F=D1=89=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
=20
-#: gitk:3989
+#: gitk:4030
 msgid "Commit Info (regular expressions):"
 msgstr "=D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 (=D1=80=D0=B5=
=D0=B3. =D0=B8=D0=B7=D1=80.):"
=20
-#: gitk:3990
+#: gitk:4031
 msgid "Author:"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
-#: gitk:3991
+#: gitk:4032
 msgid "Committer:"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=BB:"
=20
-#: gitk:3992
+#: gitk:4033
 msgid "Commit Message:"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
=20
-#: gitk:3993
+#: gitk:4034
 msgid "Matches all Commit Info criteria"
 msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BA=D0=BE=D1=8F =D0=B4=D0=B0 =D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=
=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:3994
+#: gitk:4035
 msgid "Changes to Files:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BF=D0=BE =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5:"
=20
-#: gitk:3995
+#: gitk:4036
 msgid "Fixed String"
 msgstr "=D0=94=D0=BE=D1=81=D0=BB=D0=BE=D0=B2=D0=B5=D0=BD =D0=BD=D0=B8=D0=
=B7"
=20
-#: gitk:3996
+#: gitk:4037
 msgid "Regular Expression"
 msgstr "=D0=A0=D0=B5=D0=B3=D1=83=D0=BB=D1=8F=D1=80=D0=B5=D0=BD =D0=B8=D0=
=B7=D1=80=D0=B0=D0=B7"
=20
-#: gitk:3997
+#: gitk:4038
 msgid "Search string:"
 msgstr "=D0=9D=D0=B8=D0=B7 =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=D1=81=D0=B5=
=D0=BD=D0=B5:"
=20
-#: gitk:3998
+#: gitk:4039
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
 "15:27:38\"):"
-msgstr "=D0=94=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5 (=E2=80=9E2 weeks ago=E2=80=9C (=D0=BF=D1=80=D0=
=B5=D0=B4=D0=B8 2 =D1=81=D0=B5=D0=B4=D0=BC=D0=B8=D1=86=D0=B8), =E2=80=9E=
2009-03-17 15:27:38=E2=80=9C, =E2=80=9EMarch 17, 2009 15:27:38=E2=80=9C=
):"
+msgstr ""
+"=D0=94=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5 (=E2=80=9E2 weeks ago=E2=80=9C (=D0=BF=D1=80=D0=B5=D0=B4=
=D0=B8 2 =D1=81=D0=B5=D0=B4=D0=BC=D0=B8=D1=86=D0=B8), =E2=80=9E2009-03-=
17 15:27:38=E2=80=9C, "
+"=E2=80=9EMarch 17, 2009 15:27:38=E2=80=9C):"
=20
-#: gitk:3999
+#: gitk:4040
 msgid "Since:"
 msgstr "=D0=9E=D1=82:"
=20
-#: gitk:4000
+#: gitk:4041
 msgid "Until:"
 msgstr "=D0=94=D0=BE:"
=20
-#: gitk:4001
+#: gitk:4042
 msgid "Limit and/or skip a number of revisions (positive integer):"
-msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=B8/=D0=B8=D0=BB=D0=B8 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=B0=
=D1=87=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=
=B5=D0=BB=D0=B5=D0=BD =D0=B1=D1=80=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D0=B8 (=D0=BD=D0=B5=D0=BE=D1=82=D1=80=D0=B8=D1=86=D0=B0=D1=82=D0=
=B5=D0=BB=D0=BD=D0=BE =D1=86=D1=8F=D0=BB=D0=BE =D1=87=D0=B8=D1=81=D0=BB=
=D0=BE):"
+msgstr ""
+"=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=B8/=D0=B8=D0=BB=D0=B8 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=B0=D1=87=
=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=
=BB=D0=B5=D0=BD =D0=B1=D1=80=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=
=D0=B8 (=D0=BD=D0=B5=D0=BE=D1=82=D1=80=D0=B8=D1=86=D0=B0=D1=82=D0=B5=D0=
=BB=D0=BD=D0=BE =D1=86=D1=8F=D0=BB=D0=BE "
+"=D1=87=D0=B8=D1=81=D0=BB=D0=BE):"
=20
-#: gitk:4002
+#: gitk:4043
 msgid "Number to show:"
 msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=B8:"
=20
-#: gitk:4003
+#: gitk:4044
 msgid "Number to skip:"
 msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=BE=D1=
=87=D0=B5=D0=BD=D0=B8:"
=20
-#: gitk:4004
+#: gitk:4045
 msgid "Miscellaneous options:"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BD=D0=B8:"
=20
-#: gitk:4005
+#: gitk:4046
 msgid "Strictly sort by date"
 msgstr "=D0=9F=D0=BE=D0=B4=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BF=D0=BE =D0=B4=D0=B0=D1=82=D0=B0"
=20
-#: gitk:4006
+#: gitk:4047
 msgid "Mark branch sides"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0"
=20
-#: gitk:4007
+#: gitk:4048
 msgid "Limit to first parent"
-msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=B8=D1=8F=D1=
=82 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
+msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=B8=D1=8F =
=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
=20
-#: gitk:4008
+#: gitk:4049
 msgid "Simple history"
 msgstr "=D0=9E=D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=B5=D0=BD=D0=B0 =D0=B8=D1=
=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F"
=20
-#: gitk:4009
+#: gitk:4050
 msgid "Additional arguments to git log:"
 msgstr "=D0=94=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=
=BD=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BA=
=D1=8A=D0=BC =E2=80=9Egit log=E2=80=9C:"
=20
-#: gitk:4010
+#: gitk:4051
 msgid "Enter files and directories to include, one per line:"
 msgstr "=D0=92=D1=8A=D0=B2=D0=B5=D0=B4=D0=B5=D1=82=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5 =D0=B8 =D0=B4=D0=B8=D1=80=D0=B5=
=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B2=D0=
=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BF=D0=BE =D0=B5=D0=BB=
=D0=B5=D0=BC=D0=B5=D0=BD=D1=82 =D0=BD=D0=B0 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:4011
+#: gitk:4052
 msgid "Command to generate more commits to include:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B7=D0=B0 =D0=B3=
=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=B4=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F, =D0=BA=D0=
=BE=D0=B8=D1=82=D0=BE =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B2=
=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8:"
+msgstr ""
+"=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B7=D0=B0 =D0=B3=D0=B5=D0=
=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =
=D0=B4=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=B8=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F, =D0=BA=D0=BE=D0=
=B8=D1=82=D0=BE =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B2=D0=BA=
=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8:"
=20
-#: gitk:4135
+#: gitk:4176
 msgid "Gitk: edit view"
 msgstr "Gitk: =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:4143
+#: gitk:4184
 msgid "-- criteria for selecting revisions"
 msgstr "=E2=80=94 =D0=BA=D1=80=D0=B8=D1=82=D0=B5=D1=80=D0=B8=D0=B8 =D0=
=B7=D0=B0 =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D0=B8"
=20
-#: gitk:4148
+#: gitk:4189
 msgid "View Name"
 msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=
=D0=B4"
=20
-#: gitk:4223
+#: gitk:4264
 msgid "Apply (F5)"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BB=D0=B0=D0=B3=D0=B0=D0=BD=D0=B5 (F5)"
=20
-#: gitk:4261
+#: gitk:4302
 msgid "Error in commit selection arguments:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=B0=D1=80=D0=B3=
=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B8=D0=
=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=
=D0=BD=D0=B8=D1=8F:"
=20
-#: gitk:4314 gitk:4366 gitk:4827 gitk:4841 gitk:6107 gitk:12184 gitk:1=
2185
+#: gitk:4355 gitk:4407 gitk:4868 gitk:4882 gitk:6152 gitk:12281 gitk:1=
2282
 msgid "None"
 msgstr "=D0=9D=D1=8F=D0=BC=D0=B0"
=20
-#: gitk:4924 gitk:4929
+#: gitk:4965 gitk:4970
 msgid "Descendant"
 msgstr "=D0=9D=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=BA"
=20
-#: gitk:4925
+#: gitk:4966
 msgid "Not descendant"
 msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=
=D0=B8=D0=BA"
=20
-#: gitk:4932 gitk:4937
+#: gitk:4973 gitk:4978
 msgid "Ancestor"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B5=D0=
=BD=D0=B8=D0=BA"
=20
-#: gitk:4933
+#: gitk:4974
 msgid "Not ancestor"
 msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=
=D1=82=D0=B2=D0=B5=D0=BD=D0=B8=D0=BA"
=20
-#: gitk:5223
+#: gitk:5268
 msgid "Local changes checked in to index but not committed"
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD=D0=B8 =
=D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0, =D0=BD=D0=
=BE =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:5259
+#: gitk:5304
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B8=D0=B7=D0=B2=D1=8A=D0=BD =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B0"
=20
-#: gitk:7032
+#: gitk:7077
 msgid "and many more"
 msgstr "=D0=B8 =D0=BE=D1=89=D0=B5 =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
=20
-#: gitk:7035
+#: gitk:7080
 msgid "many"
 msgstr "=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
=20
-#: gitk:7222
+#: gitk:7271
 msgid "Tags:"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8:"
=20
-#: gitk:7239 gitk:7245 gitk:8708
+#: gitk:7288 gitk:7294 gitk:8760
 msgid "Parent"
 msgstr "=D0=A0=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
=20
-#: gitk:7250
+#: gitk:7299
 msgid "Child"
 msgstr "=D0=94=D0=B5=D1=82=D0=B5"
=20
-#: gitk:7259
+#: gitk:7308
 msgid "Branch"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:7262
+#: gitk:7311
 msgid "Follows"
 msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0"
=20
-#: gitk:7265
+#: gitk:7314
 msgid "Precedes"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0"
=20
-#: gitk:7849
+#: gitk:7901
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5: %s"
=20
-#: gitk:8533
+#: gitk:8585
 msgid "Goto:"
 msgstr "=D0=9A=D1=8A=D0=BC =D1=80=D0=B5=D0=B4:"
=20
-#: gitk:8554
+#: gitk:8606
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
-msgstr "=D0=A1=D1=8A=D0=BA=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=B0=D1=82=D0=
=B0 SHA1 %s =D0=BD=D0=B5 =D0=B5 =D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=
=B0=D1=87=D0=BD=D0=B0"
+msgstr "=D0=A1=D1=8A=D0=BA=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=B0=D1=82=D0=
=B0 =D1=81=D1=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s =D0=BD=D0=B5 =D0=B5 =D0=
=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=BD=D0=B0"
=20
-#: gitk:8561
+#: gitk:8613
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D0=B2=D0=
=B5=D1=80=D1=81=D0=B8=D1=8F %s"
=20
-#: gitk:8571
+#: gitk:8623
 #, tcl-format
 msgid "SHA1 id %s is not known"
-msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 SHA1 %s=
"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D1=81=D1=
=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s"
=20
-#: gitk:8573
+#: gitk:8625
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F %s =D0=BD=D0=B5 =D0=B5 =D0=
=B2 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=B8=D0=B7=D0=B3=D0=BB=
=D0=B5=D0=B4"
=20
-#: gitk:8715 gitk:8730
+#: gitk:8767 gitk:8782
 msgid "Date"
 msgstr "=D0=94=D0=B0=D1=82=D0=B0"
=20
-#: gitk:8718
+#: gitk:8770
 msgid "Children"
 msgstr "=D0=94=D0=B5=D1=86=D0=B0"
=20
-#: gitk:8781
+#: gitk:8833
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=D1=
=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:8783
+#: gitk:8835
 msgid "Detached head: can't reset"
 msgstr "=D0=9D=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD =D0=B2=D1=
=80=D1=8A=D1=85: =D0=BD=D0=B5=D0=B2=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=
=D0=BE =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:8888 gitk:8894
+#: gitk:8940 gitk:8946
 msgid "Skipping merge commit "
 msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:8903 gitk:8908
+#: gitk:8955 gitk:8960
 msgid "Error getting patch ID for "
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=
=D0=BE=D1=80=D0=B0 =D0=BD=D0=B0 "
=20
-#: gitk:8904 gitk:8909
+#: gitk:8956 gitk:8961
 msgid " - stopping\n"
 msgstr " =E2=80=94 =D1=81=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
=20
-#: gitk:8914 gitk:8917 gitk:8925 gitk:8939 gitk:8948
+#: gitk:8966 gitk:8969 gitk:8977 gitk:8991 gitk:9000
 msgid "Commit "
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:8918
+#: gitk:8970
 msgid ""
 " is the same patch as\n"
 "       "
@@ -874,7 +875,7 @@ msgstr ""
 " =D0=B5 =D1=81=D1=8A=D1=89=D0=B0=D1=82=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=
=D0=BA=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE\n"
 "       "
=20
-#: gitk:8926
+#: gitk:8978
 msgid ""
 " differs from\n"
 "       "
@@ -882,135 +883,138 @@ msgstr ""
 " =D1=81=D0=B5 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=B0=D0=B2=D0=B0 =
=D0=BE=D1=82\n"
 "       "
=20
-#: gitk:8928
+#: gitk:8980
 msgid ""
 "Diff of commits:\n"
 "\n"
-msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0:\n\n"
+msgstr ""
+"=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D0=BC=D0=B5=D0=B6=D0=B4=D1=
=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0:=
\n"
+"\n"
=20
-#: gitk:8940 gitk:8949
+#: gitk:8992 gitk:9001
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " =D0=B8=D0=BC=D0=B0 %s =D0=B4=D0=B5=D1=86=D0=B0 =E2=80=94 =D1=81=
=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
=20
-#: gitk:8968
+#: gitk:9020
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB: %s"
=20
-#: gitk:8974
+#: gitk:9026
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D1=87=D0=B8=D1=81=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE=
 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D0=
=BC=D0=B5=D0=B6=D0=B4=D1=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B8=D1=8F=D1=82=D0=B0: %s"
=20
-#: gitk:9020
+#: gitk:9072
 msgid "Top"
 msgstr "=D0=9D=D0=B0=D0=B9-=D0=B3=D0=BE=D1=80=D0=B5"
=20
-#: gitk:9021
+#: gitk:9073
 msgid "From"
 msgstr "=D0=9E=D1=82"
=20
-#: gitk:9026
+#: gitk:9078
 msgid "To"
 msgstr "=D0=94=D0=BE"
=20
-#: gitk:9050
+#: gitk:9102
 msgid "Generate patch"
 msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:9052
+#: gitk:9104
 msgid "From:"
 msgstr "=D0=9E=D1=82:"
=20
-#: gitk:9061
+#: gitk:9113
 msgid "To:"
 msgstr "=D0=94=D0=BE:"
=20
-#: gitk:9070
+#: gitk:9122
 msgid "Reverse"
 msgstr "=D0=9E=D0=B1=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9072 gitk:9268
+#: gitk:9124 gitk:9320
 msgid "Output file:"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0:"
=20
-#: gitk:9078
+#: gitk:9130
 msgid "Generate"
 msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9116
+#: gitk:9168
 msgid "Error creating patch:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0:"
=20
-#: gitk:9139 gitk:9256 gitk:9313
+#: gitk:9191 gitk:9308 gitk:9365
 msgid "ID:"
 msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80:"
=20
-#: gitk:9148
+#: gitk:9200
 msgid "Tag name:"
 msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=
=D1=82:"
=20
-#: gitk:9151
+#: gitk:9203
 msgid "Tag message is optional"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=
=BE =D0=B7=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82 =D0=B5 =D0=BD=D0=B5=
=D0=B7=D0=B0=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=
"
=20
-#: gitk:9153
+#: gitk:9205
 msgid "Tag message:"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B7=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
=20
-#: gitk:9157 gitk:9322
+#: gitk:9209 gitk:9374
 msgid "Create"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9175
+#: gitk:9227
 msgid "No tag name specified"
 msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=
=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:9179
+#: gitk:9231
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D1=8A=D1=82 =E2=80=9E%s=E2=
=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0"
=20
-#: gitk:9189
+#: gitk:9241
 msgid "Error creating tag:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
=20
-#: gitk:9265
+#: gitk:9317
 msgid "Command:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:9273
+#: gitk:9325
 msgid "Write"
-msgstr "Pdmdpldke"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9291
+#: gitk:9343
 msgid "Error writing commit:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE:"
=20
-#: gitk:9318
+#: gitk:9370
 msgid "Name:"
 msgstr "=D0=98=D0=BC=D0=B5:"
=20
-#: gitk:9341
+#: gitk:9393
 msgid "Please specify a name for the new branch"
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =
=D0=B7=D0=B0 =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:9346
+#: gitk:9398
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=B2=
=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=
=D0=B0. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD?"
=20
-#: gitk:9413
+#: gitk:9465
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=
=8E=D1=87=D0=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=
=9E%s=E2=80=9C =E2=80=94 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=
=B8 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=BE =D0=BE=D1=82=
=D0=BD=D0=BE=D0=B2=D0=BE?"
+msgstr ""
+"=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=80=9E=
%s=E2=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=
=87=D0=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=
=E2=80=9C =E2=80=94 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =
=D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=BE =D0=BE=D1=82=D0=BD=
=D0=BE=D0=B2=D0=BE?"
=20
-#: gitk:9418
+#: gitk:9470
 msgid "Cherry-picking"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9427
+#: gitk:9479
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1019,7 +1023,7 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5, =D0=B7=D0=B0=D1=89=D0=BE=D1=82=D0=BE=
 =D0=B2=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C=
 =D0=B8=D0=BC=D0=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=
=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8.\n"
 "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B9=D1=82=D0=B5, =D0=B7=D0=B0=D0=BD=D1=83=D0=
=BB=D0=B5=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D0=B3=D0=B8 =D1=81=D0=BA=D0=B0=
=D1=82=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8 =D0=BF=D1=80=D0=BE=D0=B1=D0=B2=D0=
=B0=D0=B9=D1=82=D0=B5 =D0=BE=D1=82=D0=BD=D0=BE=D0=B2=D0=BE."
=20
-#: gitk:9433
+#: gitk:9485
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1027,20 +1031,20 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =
=D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8=
 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
 "=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
=20
-#: gitk:9449 gitk:9507
+#: gitk:9501 gitk:9559
 msgid "No changes committed"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=
=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:9476
+#: gitk:9528
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=
=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=
=9C. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BE=D1=82=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE?"
=20
-#: gitk:9481
+#: gitk:9533
 msgid "Reverting"
 msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0"
=20
-#: gitk:9489
+#: gitk:9541
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
@@ -1049,7 +1053,7 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=B0 =D0=BE=D1=82=D0=
=BC=D1=8F=D0=BD=D0=B0, =D0=B7=D0=B0=D1=89=D0=BE=D1=82=D0=BE =D0=B2=D1=8A=
=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C =D0=B8=D0=BC=
=D0=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8.\n"
 "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B9=D1=82=D0=B5, =D0=B7=D0=B0=D0=BD=D1=83=D0=
=BB=D0=B5=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D0=B3=D0=B8 =D1=81=D0=BA=D0=B0=
=D1=82=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8 =D0=BF=D1=80=D0=BE=D0=B1=D0=B2=D0=
=B0=D0=B9=D1=82=D0=B5 =D0=BE=D1=82=D0=BD=D0=BE=D0=B2=D0=BE.<"
=20
-#: gitk:9493
+#: gitk:9545
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1057,28 +1061,28 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=BC=D1=8F=D0=BD=D0=B0 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =D0=BA=D0=BE=
=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8 =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
 "=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
=20
-#: gitk:9536
+#: gitk:9588
 msgid "Confirm reset"
 msgstr "=D0=9F=D0=BE=D1=82=D0=B2=D1=8A=D1=80=D0=B6=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=
=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:9538
+#: gitk:9590
 #, tcl-format
 msgid "Reset branch %s to %s?"
-msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D0=B8=
 =D0=BB=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=
=D1=8A=D0=BC =E2=80=9E%s=E2=80=9C?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D0=B8=
 =D0=BB=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C=
 =D0=BA=D1=8A=D0=BC =E2=80=9E%s=E2=80=9C?"
=20
-#: gitk:9540
+#: gitk:9592
 msgid "Reset type:"
 msgstr "=D0=92=D0=B8=D0=B4 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=
=B0=D0=BD=D0=B5:"
=20
-#: gitk:9543
+#: gitk:9595
 msgid "Soft: Leave working tree and index untouched"
 msgstr "=D0=A1=D0=BB=D0=B0=D0=B1=D0=BE: =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=B8 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0=D1=
=82 =D1=81=D1=8A=D1=89=D0=B8=D1=82=D0=B5"
=20
-#: gitk:9546
+#: gitk:9598
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "=D0=A1=D0=BC=D0=B5=D1=81=D0=B5=D0=BD=D0=BE: =D1=80=D0=B0=D0=B1=
=D0=BE=D1=82=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=
=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0 =D1=81=D1=8A=D1=89=D0=BE=D1=82=D0=BE,=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D1=81=D0=B5 =D0=B7=D0=
=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:9549
+#: gitk:9601
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1086,249 +1090,251 @@ msgstr ""
 "=D0=A1=D0=B8=D0=BB=D0=BD=D0=BE: =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=B8 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE, =D0=B8 =D0=BD=D0=
=B0 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0\n"
 "(*=D0=92=D0=A1=D0=98=D0=A7=D0=9A=D0=98* =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=
=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D1=89=D0=B5 =D0=
=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B1=D0=B5=D0=B7=D0=B2=D1=8A=D0=B7=D0=B2=D1=
=80=D0=B0=D1=82=D0=BD=D0=BE =D0=B7=D0=B0=D0=B3=D1=83=D0=B1=D0=B5=D0=BD=D0=
=B8)"
=20
-#: gitk:9566
+#: gitk:9618
 msgid "Resetting"
 msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9626
+#: gitk:9678
 msgid "Checking out"
 msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
=20
-#: gitk:9679
+#: gitk:9731
 msgid "Cannot delete the currently checked-out branch"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=
=B3=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F=D1=82 =D0=BA=D0=BB=D0=BE=D0=BD =D0=BD=
=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=
=B8=D0=B7=D1=82=D1=80=D0=B8=D1=82"
=20
-#: gitk:9685
+#: gitk:9737
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr ""
 "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BD=D0=
=B5 =D1=81=D0=B0 =D0=BD=D0=B0 =D0=BD=D0=B8=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=
=D1=83=D0=B3 =D0=BA=D0=BB=D0=BE=D0=BD.\n"
-"=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B5 =D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C?"
+"=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B5 =D0=BA=D0=BB=D0=BE=
=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C?"
=20
-#: gitk:9716
+#: gitk:9768
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=
=D1=80=D1=85=D0=BE=D0=B2=D0=B5: %s"
=20
-#: gitk:9731
+#: gitk:9783
 msgid "Filter"
 msgstr "=D0=A4=D0=B8=D0=BB=D1=82=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:10027
+#: gitk:10079
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
-msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B3=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0. =D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=B7=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =D0=B8 =D0=BF=D1=80=D0=
=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D1=89=D0=B8=D1=82=D0=B5/=D1=
=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=82=D0=B5 =D0=B5=D1=82=D0=
=B8=D0=BA=D0=B5=D1=82=D0=B8 =D1=89=D0=B5 =D0=B5 =D0=BD=D0=B5=D0=BF=D1=8A=
=D0=BB=D0=BD=D0=B0."
+msgstr ""
+"=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D1=82=
=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B3=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0. =D0=
=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=B7=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 "
+"=D0=B8 =D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D1=
=89=D0=B8=D1=82=D0=B5/=D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=
=82=D0=B5 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8 =D1=89=D0=B5 =D0=B5=
 =D0=BD=D0=B5=D0=BF=D1=8A=D0=BB=D0=BD=D0=B0."
=20
-#: gitk:11004
+#: gitk:11056
 msgid "Tag"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:11008
+#: gitk:11060
 msgid "Id"
 msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80"
=20
-#: gitk:11091
+#: gitk:11143
 msgid "Gitk font chooser"
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=
=D1=84=D1=82 =D0=B7=D0=B0 Gitk"
=20
-#: gitk:11108
+#: gitk:11160
 msgid "B"
 msgstr "=D0=A7"
=20
-#: gitk:11111
+#: gitk:11163
 msgid "I"
 msgstr "=D0=9A"
=20
-#: gitk:11229
+#: gitk:11281
 msgid "Commit list display options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:11232
+#: gitk:11284
 msgid "Maximum graph width (lines)"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (=D0=B2 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5)"
=20
-#: gitk:11235
+#: gitk:11287
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (% =D0=BE=D1=82 =D0=BF=D0=B0=D0=BD=D0=B5=D0=BB=D0=B0=
)"
=20
-#: gitk:11238
+#: gitk:11290
 msgid "Show local changes"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:11241
+#: gitk:11293
 msgid "Auto-select SHA1 (length)"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=
=BE =D0=B8=D0=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 SHA1 =
(=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D0=BD=D0=B0)"
=20
-#: gitk:11245
+#: gitk:11297
 msgid "Hide remote refs"
 msgstr "=D0=A1=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=82=D0=B5=
 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8"
=20
-#: gitk:11249
+#: gitk:11301
 msgid "Diff display options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
=20
-#: gitk:11251
+#: gitk:11303
 msgid "Tab spacing"
 msgstr "=D0=A8=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =
=D1=82=D0=B0=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D1=80=D0=B0"
=20
-#: gitk:11254
+#: gitk:11306
 msgid "Display nearby tags/heads"
 msgstr "=D0=98=D0=B7=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D1=82=D0=B5 =D0=B5=D1=82=D0=B8=
=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=
=B5"
=20
-#: gitk:11257
+#: gitk:11309
 msgid "Maximum # tags/heads to show"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD =D0=
=B1=D1=80=D0=BE=D0=B9 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8/=D0=B2=
=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=B5 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=BA=D0=
=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11260
+#: gitk:11312
 msgid "Limit diffs to listed paths"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D1=81=D0=B0=D0=BC=D0=
=BE =D0=B2 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D1=8A=D1=82=D0=B8=D1=89=D0=B0"
=20
-#: gitk:11263
+#: gitk:11315
 msgid "Support per-file encodings"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B4=D1=80=D1=8A=D0=B6=D0=BA=D0=B0 =D0=BD=D0=
=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D0=B8 =D0=BA=D0=BE=D0=B4=
=D0=B8=D1=80=D0=B0=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=B2=D1=81=D0=B5=D0=
=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:11269 gitk:11416
+#: gitk:11321 gitk:11468
 msgid "External diff tool"
 msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=B5=D0=BD =D0=B8=D0=BD=D1=81=D1=82=D1=
=80=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=
=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:11270
+#: gitk:11322
 msgid "Choose..."
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80=E2=80=A6"
=20
-#: gitk:11275
+#: gitk:11327
 msgid "General options"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8 =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=
=B9=D0=BA=D0=B8"
=20
-#: gitk:11278
+#: gitk:11330
 msgid "Use themed widgets"
 msgstr "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=82=D0=B5=D0=BC=D0=B0 =D0=B7=D0=B0 =D0=B3=D1=80=D0=B0=D1=84=
=D0=B8=D1=87=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=
"
=20
-#: gitk:11280
+#: gitk:11332
 msgid "(change requires restart)"
 msgstr "(=D0=BF=D1=80=D0=BE=D0=BC=D1=8F=D0=BD=D0=B0=D1=82=D0=B0 =D0=B8=
=D0=B7=D0=B8=D1=81=D0=BA=D0=B2=D0=B0 =D1=80=D0=B5=D1=81=D1=82=D0=B0=D1=80=
=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 Gitk)"
=20
-#: gitk:11282
+#: gitk:11334
 msgid "(currently unavailable)"
 msgstr "(=D0=B2 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BD=D0=B5=
=D0=B4=D0=BE=D1=81=D1=82=D1=8A=D0=BF=D0=BD=D0=BE)"
=20
-#: gitk:11293
+#: gitk:11345
 msgid "Colors: press to choose"
 msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=D0=B1=
=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=81=D0=
=BA=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11296
+#: gitk:11348
 msgid "Interface"
 msgstr "=D0=98=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
-#: gitk:11297
+#: gitk:11349
 msgid "interface"
 msgstr "=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
-#: gitk:11300
+#: gitk:11352
 msgid "Background"
 msgstr "=D0=A4=D0=BE=D0=BD"
=20
-#: gitk:11301 gitk:11331
+#: gitk:11353 gitk:11383
 msgid "background"
-msgstr "=D0=A4=D0=BE=D0=BD"
+msgstr "=D1=84=D0=BE=D0=BD"
=20
-#: gitk:11304
+#: gitk:11356
 msgid "Foreground"
 msgstr "=D0=97=D0=BD=D0=B0=D1=86=D0=B8"
=20
-#: gitk:11305
+#: gitk:11357
 msgid "foreground"
 msgstr "=D0=B7=D0=BD=D0=B0=D1=86=D0=B8"
=20
-#: gitk:11308
+#: gitk:11360
 msgid "Diff: old lines"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11309
+#: gitk:11361
 msgid "diff old lines"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11313
+#: gitk:11365
 msgid "Diff: new lines"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11314
+#: gitk:11366
 msgid "diff new lines"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11318
+#: gitk:11370
 msgid "Diff: hunk header"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
=20
-#: gitk:11320
+#: gitk:11372
 msgid "diff hunk header"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
=20
-#: gitk:11324
+#: gitk:11376
 msgid "Marked line bg"
 msgstr "=D0=A4=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
=20
-#: gitk:11326
+#: gitk:11378
 msgid "marked line background"
-msgstr "=D0=A4=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
+msgstr "=D1=84=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
=20
-#: gitk:11330
+#: gitk:11382
 msgid "Select bg"
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=84=D0=BE=D0=BD=
"
=20
-#: gitk:11339
+#: gitk:11391
 msgid "Fonts: press to choose"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=
=D0=B1=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=
=81=D0=BA=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11341
+#: gitk:11393
 msgid "Main font"
 msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD =D1=88=D1=80=D0=B8=D1=
=84=D1=82"
=20
-#: gitk:11342
+#: gitk:11394
 msgid "Diff display font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=
=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
=20
-#: gitk:11343
+#: gitk:11395
 msgid "User interface font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BD=D0=B0 =D0=B8=D0=BD=D1=82=
=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
-#: gitk:11365
+#: gitk:11417
 msgid "Gitk preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 Gitk"
=20
-#: gitk:11374
+#: gitk:11426
 msgid "General"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8"
=20
-#: gitk:11375
+#: gitk:11427
 msgid "Colors"
 msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11376
+#: gitk:11428
 msgid "Fonts"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11426
+#: gitk:11478
 #, tcl-format
 msgid "Gitk: choose color for %s"
-msgstr "Gitk: =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=86=D0=B2=
=D1=8F=D1=82 =D0=BD=D0=B0 %s"
+msgstr "Gitk: =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=86=D0=B2=
=D1=8F=D1=82 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C"
=20
-#: gitk:12080
+#: gitk:12177
 msgid "Cannot find a git repository here."
 msgstr "=D0=A2=D1=83=D0=BA =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D1=85=
=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=B0 Git."
=20
-#: gitk:12127
+#: gitk:12224
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "=D0=9D=D0=B5=D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=B5=D0=BD =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =E2=80=9E%s=E2=
=80=9C: =D0=B8=D0=BC=D0=B0 =D0=B8 =D1=82=D0=B0=D0=BA=D0=B0=D0=B2=D0=B0 =
=D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F, =D0=B8 =D1=82=D0=B0=D0=BA=D1=8A=D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:12139
+#: gitk:12236
 msgid "Bad arguments to gitk:"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BD=D0=B0 gitk:"
=20
-#: gitk:12242
+#: gitk:12339
 msgid "Command line"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B5=D0=BD =D1=80=D0=B5=D0=
=B4"
--=20
1.9.3
