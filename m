From: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] gitk: Update Bulgarian translation (311t)
Date: Sun, 20 Dec 2015 00:36:09 +0200
Message-ID: <1450564569-27551-1-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 23:36:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAQ7U-0008N1-7N
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 23:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbLSWgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2015 17:36:17 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35159 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbbLSWgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 17:36:15 -0500
Received: by mail-wm0-f45.google.com with SMTP id l126so26943580wml.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 14:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yjD0rnTQS5VGNUlkZgJLTiE1MPf38AgQRWCMsxz1WH8=;
        b=XJsw5LMZ3OHRuxMi7c6uY8pxIO+E6kwHkADcKPZlb9KVmLeiNMS4c8XjV0LIk2ilOr
         sN7tXXr92Ct5Eg1Sa6SYpW5WTtzK8zDfgG/YjyFEff+mge1VPIYMoLSJxCo7F3uPZ9/y
         Gi0T9j2rMJBlz17FRejTimPlplNeApDYvBcEBVuNRXKB24XEwCuh2/8e8jqAV5ZFUAaT
         2uNOknILE2p0BbTjxSXz2sNgllPD9EU9UywXWykhbP6ChhUxwLruXFk4Wk36bJJJ6GId
         I3MYeko+lUwdJ6lbq6h2/nvypNeXDkhxl6SGA8v0IIGJnM/1pD1IAfMyzWbUhIqvlKAa
         z1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=yjD0rnTQS5VGNUlkZgJLTiE1MPf38AgQRWCMsxz1WH8=;
        b=UJGgwSDzDZboGOhIFaM/Qa/P4PcWXqnFtRzoOOLq65QNYwHzw1dOADhJK8wDfDiO9t
         hebQbDIIX4cdqvZRs+6JVl74pODq/Xw6IPmv+5kA3Zg+YYmXGCIP+0hC5ZHOOnkA705x
         NyDejrb5KEs3lBu/xNvJ/pEzcVygINQZCOFzkcchGEKJX6dRPPOceQUHTtovGDyneq5r
         yjiDkpj0AuEV24HudHnobhEM02Ywv0jgnR37yKtY+rji16Zz6Fammr17Sn8LyoOjYLCA
         3Q1ESERmYAqu5BXe/K9rKE++U7vf9RFzpQ+UrisYiW3ecbpeIBOSl6gePcPFvApdH9Ov
         HpQw==
X-Gm-Message-State: ALoCoQkN+8cMEZKekf6+9H5YSJJTZSytZNddHVKdAhj8oaZbjiyXhzvZq9xpPhlxe3fgliWGddXis3HEXXLSGgBvgWVd5CctZA==
X-Received: by 10.194.117.163 with SMTP id kf3mr11756730wjb.139.1450564573734;
        Sat, 19 Dec 2015 14:36:13 -0800 (PST)
Received: from ashmac.lan (78-83-54-40.spectrumnet.bg. [78.83.54.40])
        by smtp.gmail.com with ESMTPSA id w203sm12666308wmg.15.2015.12.19.14.36.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 14:36:13 -0800 (PST)
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282752>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 656 ++++++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 336 insertions(+), 320 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 909a564..99aa77a 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-06-27 20:44+0300\n"
-"PO-Revision-Date: 2015-06-27 20:46+0300\n"
+"POT-Creation-Date: 2015-12-19 11:48+0200\n"
+"PO-Revision-Date: 2015-12-19 11:49+0200\n"
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
-#: gitk:212 gitk:2381
+#: gitk:212 gitk:2399
 msgid "Color words"
 msgstr "=D0=9E=D1=86=D0=B2=D0=B5=D1=82=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
=20
-#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:217 gitk:2399 gitk:8239 gitk:8272
 msgid "Markup words"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
=20
@@ -59,15 +59,15 @@ msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B0 =E2=80=9Egit log=E2=80=9C:"
 msgid "Reading"
 msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:496 gitk:4525
+#: gitk:496 gitk:4544
 msgid "Reading commits..."
 msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0=E2=
=80=A6"
=20
-#: gitk:499 gitk:1637 gitk:4528
+#: gitk:499 gitk:1637 gitk:4547
 msgid "No commits selected"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1445 gitk:4064 gitk:12469
 msgid "Command line"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B5=D0=BD =D1=80=D0=B5=D0=
=B4"
=20
@@ -79,286 +79,294 @@ msgstr "=D0=98=D0=B7=D1=85=D0=BE=D0=B4=D1=8A=D1=82=
 =D0=BE=D1=82 =E2=80=9Egit log=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=
=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=B0=D0=BD=D0=B0=D0=BB=D0=B8=D0=B7=D0=
=B8
 msgid "No commit information available"
 msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BD=D1=84=D0=BE=D1=
=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1903 gitk:1932 gitk:4334 gitk:9702 gitk:11274 gitk:11554
 msgid "OK"
 msgstr "=D0=94=D0=BE=D0=B1=D1=80=D0=B5"
=20
-#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:96=
71
-#: gitk:11242 gitk:11522
+#: gitk:1934 gitk:4336 gitk:9215 gitk:9294 gitk:9424 gitk:9473 gitk:97=
04
+#: gitk:11275 gitk:11555
 msgid "Cancel"
 msgstr "=D0=9E=D1=82=D0=BA=D0=B0=D0=B7"
=20
-#: gitk:2069
+#: gitk:2083
 msgid "&Update"
-msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+msgstr "&=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2070
+#: gitk:2084
 msgid "&Reload"
-msgstr "=D0=9F=D1=80=D0=B5=D0=B7=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=
=BD=D0=B5"
+msgstr "&=D0=9F=D1=80=D0=B5=D0=B7=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=
=BD=D0=B5"
=20
-#: gitk:2071
+#: gitk:2085
 msgid "Reread re&ferences"
-msgstr "=D0=9D=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=87=D0=
=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=81=D1=82=D1=80=
=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5"
+msgstr "&=D0=9D=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=87=
=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=81=D1=82=D1=
=80=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5"
=20
-#: gitk:2072
+#: gitk:2086
 msgid "&List references"
-msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=
=B5"
+msgstr "&=D0=98=D0=B7=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =
=D0=BD=D0=B0 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=
=D0=B5"
=20
-#: gitk:2074
+#: gitk:2088
 msgid "Start git &gui"
-msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui=E2=80=9C"
+msgstr "&=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =
=D0=BD=D0=B0 =E2=80=9Egit gui=E2=80=9C"
=20
-#: gitk:2076
+#: gitk:2090
 msgid "&Quit"
-msgstr "=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
+msgstr "&=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
=20
-#: gitk:2068
+#: gitk:2082
 msgid "&File"
-msgstr "=D0=A4=D0=B0=D0=B9=D0=BB"
+msgstr "&=D0=A4=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:2080
+#: gitk:2094
 msgid "&Preferences"
-msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
+msgstr "&=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
=20
-#: gitk:2079
+#: gitk:2093
 msgid "&Edit"
-msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5"
+msgstr "&=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5"
=20
-#: gitk:2084
+#: gitk:2098
 msgid "&New view..."
-msgstr "=D0=9D=D0=BE=D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=E2=80=A6=
"
+msgstr "&=D0=9D=D0=BE=D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=E2=80=
=A6"
=20
-#: gitk:2085
+#: gitk:2099
 msgid "&Edit view..."
-msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=E2=80=A6"
+msgstr "&=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=E2=80=A6"
=20
-#: gitk:2086
+#: gitk:2100
 msgid "&Delete view"
-msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
+msgstr "&=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
=20
-#: gitk:2088 gitk:4043
+#: gitk:2102
 msgid "&All files"
-msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2=D0=B5"
+msgstr "&=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:2083 gitk:4067
+#: gitk:2097
 msgid "&View"
-msgstr "=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
+msgstr "&=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2107 gitk:2117
 msgid "&About gitk"
-msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
+msgstr "&=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
=20
-#: gitk:2094 gitk:2108
+#: gitk:2108 gitk:2122
 msgid "&Key bindings"
-msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
+msgstr "&=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=
=D0=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
=20
-#: gitk:2092 gitk:2107
+#: gitk:2106 gitk:2121
 msgid "&Help"
-msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89"
+msgstr "=D0=9F=D0=BE=D0=BC=D0=BE&=D1=89"
=20
-#: gitk:2185 gitk:8652
+#: gitk:2199 gitk:8671
 msgid "SHA1 ID:"
 msgstr "SHA1:"
=20
-#: gitk:2229
+#: gitk:2243
 msgid "Row"
 msgstr "=D0=A0=D0=B5=D0=B4"
=20
-#: gitk:2267
+#: gitk:2281
 msgid "Find"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:2295
+#: gitk:2309
 msgid "commit"
 msgstr "=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:68=
27
-#: gitk:6912
+#: gitk:2313 gitk:2315 gitk:4706 gitk:4729 gitk:4753 gitk:6774 gitk:68=
46
+#: gitk:6931
 msgid "containing:"
 msgstr "=D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D1=89=D0=BE:"
=20
-#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2316 gitk:3545 gitk:3550 gitk:4782
 msgid "touching paths:"
 msgstr "=D0=B7=D0=B0=D1=81=D1=8F=D0=B3=D0=B0=D1=89=D0=BE =D0=BF=D1=8A=D1=
=82=D0=B8=D1=89=D0=B0=D1=82=D0=B0:"
=20
-#: gitk:2303 gitk:4777
+#: gitk:2317 gitk:4796
 msgid "adding/removing string:"
 msgstr "=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D1=89=D0=BE/=D0=BF=D1=80=D0=
=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D1=89=D0=BE =D0=BD=D0=B8=D0=B7"
=20
-#: gitk:2304 gitk:4779
+#: gitk:2318 gitk:4798
 msgid "changing lines matching:"
 msgstr "=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D1=8F=D1=89=D0=BE =D1=80=D0=
=B5=D0=B4=D0=BE=D0=B2=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B0=D1=81=D0=B2=D0=B0=D1=
=89=D0=B8:"
=20
-#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2327 gitk:2329 gitk:4785
 msgid "Exact"
 msgstr "=D0=A2=D0=BE=D1=87=D0=BD=D0=BE"
=20
-#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2329 gitk:4873 gitk:6742
 msgid "IgnCase"
 msgstr "=D0=91=D0=B5=D0=B7 =D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=8A=D1=
=80"
=20
-#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2329 gitk:4755 gitk:4871 gitk:6738
 msgid "Regexp"
 msgstr "=D0=A0=D0=B5=D0=B3. =D0=B8=D0=B7=D1=80=D0=B0=D0=B7"
=20
-#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:69=
16
+#: gitk:2331 gitk:2332 gitk:4893 gitk:4923 gitk:4930 gitk:6867 gitk:69=
35
 msgid "All fields"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B5=D1=
=82=D0=B0"
=20
-#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2332 gitk:4890 gitk:4923 gitk:6805
 msgid "Headline"
 msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
 msgid "Comments"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8"
=20
-#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:88=
30
-#: gitk:8845
+#: gitk:2333 gitk:4890 gitk:4895 gitk:4930 gitk:6805 gitk:7343 gitk:88=
49
+#: gitk:8864
 msgid "Author"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
=20
-#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2333 gitk:4890 gitk:6805 gitk:7345
 msgid "Committer"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D1=89"
=20
-#: gitk:2350
+#: gitk:2367
 msgid "Search"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:2358
+#: gitk:2375
 msgid "Diff"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:2360
+#: gitk:2377
 msgid "Old version"
 msgstr "=D0=A1=D1=82=D0=B0=D1=80=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=
=8F"
=20
-#: gitk:2362
+#: gitk:2379
 msgid "New version"
 msgstr "=D0=9D=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
=20
-#: gitk:2364
+#: gitk:2382
 msgid "Lines of context"
 msgstr "=D0=9A=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B2 =D1=80=
=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:2374
+#: gitk:2392
 msgid "Ignore space change"
 msgstr "=D0=9F=D1=80=D0=B0=D0=B7=D0=BD=D0=B8=D1=82=D0=B5 =D0=B7=D0=BD=D0=
=B0=D1=86=D0=B8 =D0=B1=D0=B5=D0=B7 =D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=
=D0=B8=D0=B5"
=20
-#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2396 gitk:2398 gitk:7978 gitk:8225
 msgid "Line diff"
 msgstr "=D0=9F=D0=BE=D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B8 =D1=80=D0=B0=D0=
=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:2445
+#: gitk:2463
 msgid "Patch"
 msgstr "=D0=9A=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:2447
+#: gitk:2465
 msgid "Tree"
 msgstr "=D0=94=D1=8A=D1=80=D0=B2=D0=BE"
=20
-#: gitk:2617 gitk:2637
+#: gitk:2635 gitk:2656
 msgid "Diff this -> selected"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=
=D0=BD=D0=BE=D1=82=D0=BE"
=20
-#: gitk:2618 gitk:2638
+#: gitk:2636 gitk:2657
 msgid "Diff selected -> this"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D1=82=D0=BE =D0=B8=
 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2619 gitk:2639
+#: gitk:2637 gitk:2658
 msgid "Make patch"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:2620 gitk:9254
+#: gitk:2638 gitk:9273
 msgid "Create tag"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:2621 gitk:9371
+#: gitk:2639
+msgid "Copy commit summary"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0=
 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2640 gitk:9404
 msgid "Write commit to file"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=
=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:2622 gitk:9428
+#: gitk:2641 gitk:9461
 msgid "Create new branch"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=BE=D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2623
+#: gitk:2642
 msgid "Cherry-pick this commit"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
=20
-#: gitk:2624
+#: gitk:2643
 msgid "Reset HEAD branch to here"
 msgstr "=D0=9F=D1=80=D0=B8=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B2=D1=8A=D1=80=D1=85=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B0 =D0=BA=D1=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2625
+#: gitk:2644
 msgid "Mark this commit"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=
=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2626
+#: gitk:2645
 msgid "Return to mark"
 msgstr "=D0=92=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2627
+#: gitk:2646
 msgid "Find descendant of this and mark"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B8 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=86=D0=B8=D1=82=
=D0=B5"
=20
-#: gitk:2628
+#: gitk:2647
 msgid "Compare with marked commit"
 msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2629 gitk:2640
+#: gitk:2648 gitk:2659
 msgid "Diff this -> marked commit"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE"
=20
-#: gitk:2630 gitk:2641
+#: gitk:2649 gitk:2660
 msgid "Diff marked commit -> this"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=
=82=D0=BE =D0=B8 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2631
+#: gitk:2650
 msgid "Revert this commit"
 msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=82=D0=BE=
=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2647
+#: gitk:2666
 msgid "Check out this branch"
 msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2648
+#: gitk:2667
 msgid "Remove this branch"
 msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:2649
+#: gitk:2668
 msgid "Copy branch name"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B8=D0=BC=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B0"
=20
-#: gitk:2656
+#: gitk:2675
 msgid "Highlight this too"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=B8 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2657
+#: gitk:2676
 msgid "Highlight this only"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D1=81=D0=B0=D0=BC=D0=BE =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
=20
-#: gitk:2658
+#: gitk:2677
 msgid "External diff"
 msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=
=D0=B8"
=20
-#: gitk:2659
+#: gitk:2678
 msgid "Blame parent commit"
 msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=BE=D1=82=D0=
=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:2660
+#: gitk:2679
 msgid "Copy path"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BF=D1=8A=D1=82=D1=8F"
=20
-#: gitk:2667
+#: gitk:2686
 msgid "Show origin of this line"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:2668
+#: gitk:2687
 msgid "Run git gui blame on this line"
 msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui blame=E2=80=9C =D0=B2=D1=8A=D1=80=D1=85=D1=83=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:3014
+#: gitk:3031
+msgid "About gitk"
+msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
+
+#: gitk:3033
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -374,316 +382,324 @@ msgstr ""
 "\n"
 "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=
=B8 =D1=80=D0=B0=D0=B7=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=B8 =D1=83=D1=81=D0=BB=
=D0=BE=D0=B2=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 =D0=9E=D0=9F=D0=9B =D0=
=BD=D0=B0 =D0=93=D0=9D=D0=A3"
=20
-#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3041 gitk:3108 gitk:9890
 msgid "Close"
 msgstr "=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5"
=20
-#: gitk:3043
+#: gitk:3062
 msgid "Gitk key bindings"
 msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
=20
-#: gitk:3046
+#: gitk:3065
 msgid "Gitk key bindings:"
 msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8:"
=20
-#: gitk:3048
+#: gitk:3067
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\t=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
=20
-#: gitk:3049
+#: gitk:3068
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\t=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5=
 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86=D0=B0"
=20
-#: gitk:3050
+#: gitk:3069
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:3051
+#: gitk:3070
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=
=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
=20
-#: gitk:3052
+#: gitk:3071
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
=20
-#: gitk:3053
+#: gitk:3072
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
=20
-#: gitk:3054
+#: gitk:3073
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\t=D0=9D=D0=B0=D0=B7=D0=B0=D0=B4 =D0=B2 =D0=B8=D1=81=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:3055
+#: gitk:3074
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\t=D0=9D=D0=B0=D0=BF=D1=80=D0=B5=D0=B4 =D0=B2 =D0=
=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:3056
+#: gitk:3075
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\t=D0=9A=D1=8A=D0=BC n-=D1=82=D0=B8=D1=8F =D1=80=D0=BE=D0=
=B4=D0=B8=D1=82=D0=B5=D0=BB =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=B2 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:3057
+#: gitk:3076
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=
=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=
=8F=D1=82=D0=B0"
=20
-#: gitk:3058
+#: gitk:3077
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=
=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=
=8F=D1=82=D0=B0"
=20
-#: gitk:3059
+#: gitk:3078
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\t=D0=9A=D1=8A=D0=BC =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BE=D1=82=D0=BE =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0"
=20
-#: gitk:3060
+#: gitk:3079
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\t=D0=9A=D1=8A=D0=BC =D0=BA=D1=80=D0=B0=D1=8F =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
=20
-#: gitk:3061
+#: gitk:3080
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\t=D0=A0=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5=
 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=
=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:3062
+#: gitk:3081
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\t=D0=A0=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=
=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:3063
+#: gitk:3082
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=
=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=
=D1=8F"
=20
-#: gitk:3064
+#: gitk:3083
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D1=
=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=
=D1=8F"
=20
-#: gitk:3065
+#: gitk:3084
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0=D0=B7=D0=B0=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5, =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D0=BE=D1=81=D0=BB=D0=
=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8)"
=20
-#: gitk:3066
+#: gitk:3085
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr ""
 "<Shift-Down>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=B0=
=D0=BF=D1=80=D0=B5=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=BD=D0=
=BE =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83, =D0=B8=D1=81=D1=82=D0=BE=D1=80=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D1=80=D0=B5=D0=B4=
=D1=85=D0=BE=D0=B6=D0=B4=D0=B0=D1=89=D0=B8)"
=20
-#: gitk:3067
+#: gitk:3086
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=
=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=
"
=20
-#: gitk:3068
+#: gitk:3087
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=
=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=
"
=20
-#: gitk:3069
+#: gitk:3088
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\t=D0=A1=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=
=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=
=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3070
+#: gitk:3089
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\t18 =D1=80=D0=B5=D0=B4=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=
=D0=B5 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=
=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3071
+#: gitk:3090
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\t18 =D1=80=D0=B5=D0=B4=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=
=D1=83 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D1=
=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3072
+#: gitk:3091
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3073
+#: gitk:3092
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3074
+#: gitk:3093
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3075
+#: gitk:3094
 msgid "g\t\tGo to commit"
 msgstr "g\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=
=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:3076
+#: gitk:3095
 msgid "/\t\tFocus the search box"
 msgstr "/\t\t=D0=A4=D0=BE=D0=BA=D1=83=D1=81 =D0=B2=D1=8A=D1=80=D1=85=D1=
=83 =D0=BF=D0=BE=D0=BB=D0=B5=D1=82=D0=BE =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=
=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3077
+#: gitk:3096
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=
=BD=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:3078
+#: gitk:3097
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\t=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89 =D1=84=D0=B0=D0=
=B9=D0=BB =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0=
 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3079
+#: gitk:3098
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3080
+#: gitk:3099
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:3081
+#: gitk:3100
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3082
+#: gitk:3101
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3083
+#: gitk:3102
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
=20
-#: gitk:3084
+#: gitk:3103
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=
=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=
=82=D0=B0"
=20
-#: gitk:3085
+#: gitk:3104
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\t=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=
=D0=B5"
=20
-#: gitk:3550 gitk:3559
+#: gitk:3569 gitk:3578
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=
=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =E2=80=9E%s=E2=80=9C=
:"
=20
-#: gitk:3572
+#: gitk:3591
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BE=D1=82 %s:"
=20
-#: gitk:3635
+#: gitk:3654
 msgid "command failed:"
 msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=
=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:3784
+#: gitk:3803
 msgid "No such commit"
 msgstr "=D0=A2=D0=B0=D0=BA=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D1=8F=D0=BC=D0=B0"
=20
-#: gitk:3798
+#: gitk:3817
 msgid "git gui blame: command failed:"
 msgstr "=E2=80=9Egit gui blame=E2=80=9C: =D0=BD=D0=B5=D1=83=D1=81=D0=BF=
=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:3829
+#: gitk:3848
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "=D0=92=D1=8A=D1=80=D1=85=D1=8A=D1=82 =D0=B7=D0=B0 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=D1=80=D0=BE=D1=87=D0=B5=D1=82=
=D0=B5=D0=BD: %s"
=20
-#: gitk:3837
+#: gitk:3856
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0: %s"
=20
-#: gitk:3862
+#: gitk:3881
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =E2=80=9E=
git blame=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=
=B1=D1=8A=D0=B4=D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B0: %s"
=20
-#: gitk:3865 gitk:6754
+#: gitk:3884 gitk:6773
 msgid "Searching"
 msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
=20
-#: gitk:3897
+#: gitk:3916
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9Egit blame=E2=80=9C: %s"
=20
-#: gitk:3925
+#: gitk:3944
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "=D0=A2=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4 =D0=B8=D0=B4=D0=B2=
=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE %s, =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D0=B5 =D0=B2=
 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
=20
-#: gitk:3939
+#: gitk:3958
 msgid "External diff viewer failed:"
 msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=B2=
=D1=8A=D0=BD=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=
=B8:"
=20
-#: gitk:4070
+#: gitk:4062
+msgid "All files"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2=D0=B5"
+
+#: gitk:4086
+msgid "View"
+msgstr "=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
+
+#: gitk:4089
 msgid "Gitk view definition"
 msgstr "=D0=94=D0=B5=D1=84=D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D1=8F =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4 =D0=B2 Gitk"
=20
-#: gitk:4074
+#: gitk:4093
 msgid "Remember this view"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:4075
+#: gitk:4094
 msgid "References (space separated list):"
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8 (=D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA =D1=81 =D1=80=D0=B0=D0=B7=D0=B4=D0=B5=D0=
=BB=D0=B8=D1=82=D0=B5=D0=BB =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=B2=D0=B0=D0=
=BB):"
=20
-#: gitk:4076
+#: gitk:4095
 msgid "Branches & tags:"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8 =D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=
=D0=B5=D1=82=D0=B8:"
=20
-#: gitk:4077
+#: gitk:4096
 msgid "All refs"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=
=B0=D1=82=D0=B5=D0=BB=D0=B8"
=20
-#: gitk:4078
+#: gitk:4097
 msgid "All (local) branches"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 (=D0=BB=D0=BE=D0=BA=D0=B0=
=D0=BB=D0=BD=D0=B8) =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
=20
-#: gitk:4079
+#: gitk:4098
 msgid "All tags"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=D0=
=B5=D1=82=D0=B8"
=20
-#: gitk:4080
+#: gitk:4099
 msgid "All remote-tracking branches"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=81=D0=BB=D0=B5=D0=B4=D1=
=8F=D1=89=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
=20
-#: gitk:4081
+#: gitk:4100
 msgid "Commit Info (regular expressions):"
 msgstr "=D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 (=D1=80=D0=B5=
=D0=B3. =D0=B8=D0=B7=D1=80.):"
=20
-#: gitk:4082
+#: gitk:4101
 msgid "Author:"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
-#: gitk:4083
+#: gitk:4102
 msgid "Committer:"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=BB:"
=20
-#: gitk:4084
+#: gitk:4103
 msgid "Commit Message:"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
=20
-#: gitk:4085
+#: gitk:4104
 msgid "Matches all Commit Info criteria"
 msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=85=D0=B0=D1=80=D0=B0=
=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8 =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:4086
+#: gitk:4105
 msgid "Matches no Commit Info criteria"
 msgstr "=D0=9D=D0=B5 =D1=81=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B0 =D0=BF=
=D0=BE =D0=BD=D0=B8=D0=BA=D0=BE=D1=8F =D0=BE=D1=82 =D1=85=D0=B0=D1=80=D0=
=B0=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8=D1=82=D0=
=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=
=D0=BE"
=20
-#: gitk:4087
+#: gitk:4106
 msgid "Changes to Files:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BF=D0=BE =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5:"
=20
-#: gitk:4088
+#: gitk:4107
 msgid "Fixed String"
 msgstr "=D0=94=D0=BE=D1=81=D0=BB=D0=BE=D0=B2=D0=B5=D0=BD =D0=BD=D0=B8=D0=
=B7"
=20
-#: gitk:4089
+#: gitk:4108
 msgid "Regular Expression"
 msgstr "=D0=A0=D0=B5=D0=B3=D1=83=D0=BB=D1=8F=D1=80=D0=B5=D0=BD =D0=B8=D0=
=B7=D1=80=D0=B0=D0=B7"
=20
-#: gitk:4090
+#: gitk:4109
 msgid "Search string:"
 msgstr "=D0=9D=D0=B8=D0=B7 =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=D1=81=D0=B5=
=D0=BD=D0=B5:"
=20
-#: gitk:4091
+#: gitk:4110
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
 "15:27:38\"):"
@@ -691,204 +707,204 @@ msgstr ""
 "=D0=94=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5 (=E2=80=9E2 weeks ago=E2=80=9C (=D0=BF=D1=80=D0=B5=D0=B4=
=D0=B8 2 =D1=81=D0=B5=D0=B4=D0=BC=D0=B8=D1=86=D0=B8), =E2=80=9E2009-03-=
17 15:27:38=E2=80=9C, "
 "=E2=80=9EMarch 17, 2009 15:27:38=E2=80=9C):"
=20
-#: gitk:4092
+#: gitk:4111
 msgid "Since:"
 msgstr "=D0=9E=D1=82:"
=20
-#: gitk:4093
+#: gitk:4112
 msgid "Until:"
 msgstr "=D0=94=D0=BE:"
=20
-#: gitk:4094
+#: gitk:4113
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr ""
 "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=B8/=D0=B8=D0=BB=D0=B8 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=B0=D1=87=
=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=
=BB=D0=B5=D0=BD =D0=B1=D1=80=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=
=D0=B8 (=D0=BD=D0=B5=D0=BE=D1=82=D1=80=D0=B8=D1=86=D0=B0=D1=82=D0=B5=D0=
=BB=D0=BD=D0=BE =D1=86=D1=8F=D0=BB=D0=BE "
 "=D1=87=D0=B8=D1=81=D0=BB=D0=BE):"
=20
-#: gitk:4095
+#: gitk:4114
 msgid "Number to show:"
 msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=B8:"
=20
-#: gitk:4096
+#: gitk:4115
 msgid "Number to skip:"
 msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=BE=D1=
=87=D0=B5=D0=BD=D0=B8:"
=20
-#: gitk:4097
+#: gitk:4116
 msgid "Miscellaneous options:"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BD=D0=B8:"
=20
-#: gitk:4098
+#: gitk:4117
 msgid "Strictly sort by date"
 msgstr "=D0=9F=D0=BE=D0=B4=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BF=D0=BE =D0=B4=D0=B0=D1=82=D0=B0"
=20
-#: gitk:4099
+#: gitk:4118
 msgid "Mark branch sides"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0"
=20
-#: gitk:4100
+#: gitk:4119
 msgid "Limit to first parent"
 msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=B8=D1=8F =
=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
=20
-#: gitk:4101
+#: gitk:4120
 msgid "Simple history"
 msgstr "=D0=9E=D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=B5=D0=BD=D0=B0 =D0=B8=D1=
=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F"
=20
-#: gitk:4102
+#: gitk:4121
 msgid "Additional arguments to git log:"
 msgstr "=D0=94=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=
=BD=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BA=
=D1=8A=D0=BC =E2=80=9Egit log=E2=80=9C:"
=20
-#: gitk:4103
+#: gitk:4122
 msgid "Enter files and directories to include, one per line:"
 msgstr "=D0=92=D1=8A=D0=B2=D0=B5=D0=B4=D0=B5=D1=82=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5 =D0=B8 =D0=B4=D0=B8=D1=80=D0=B5=
=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B2=D0=
=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BF=D0=BE =D0=B5=D0=BB=
=D0=B5=D0=BC=D0=B5=D0=BD=D1=82 =D0=BD=D0=B0 =D1=80=D0=B5=D0=B4"
=20
-#: gitk:4104
+#: gitk:4123
 msgid "Command to generate more commits to include:"
 msgstr ""
 "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B7=D0=B0 =D0=B3=D0=B5=D0=
=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =
=D0=B4=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=B8=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F, =D0=BA=D0=BE=D0=
=B8=D1=82=D0=BE =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B2=D0=BA=
=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8:"
=20
-#: gitk:4228
+#: gitk:4247
 msgid "Gitk: edit view"
 msgstr "Gitk: =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
-#: gitk:4236
+#: gitk:4255
 msgid "-- criteria for selecting revisions"
 msgstr "=E2=80=94 =D0=BA=D1=80=D0=B8=D1=82=D0=B5=D1=80=D0=B8=D0=B8 =D0=
=B7=D0=B0 =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D0=B8"
=20
-#: gitk:4241
+#: gitk:4260
 msgid "View Name"
 msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=
=D0=B4"
=20
-#: gitk:4316
+#: gitk:4335
 msgid "Apply (F5)"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BB=D0=B0=D0=B3=D0=B0=D0=BD=D0=B5 (F5)"
=20
-#: gitk:4354
+#: gitk:4373
 msgid "Error in commit selection arguments:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=B0=D1=80=D0=B3=
=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B8=D0=
=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=
=D0=BD=D0=B8=D1=8F:"
=20
-#: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:1=
2374
+#: gitk:4428 gitk:4481 gitk:4943 gitk:4957 gitk:6227 gitk:12410 gitk:1=
2411
 msgid "None"
 msgstr "=D0=9D=D1=8F=D0=BC=D0=B0"
=20
-#: gitk:5021 gitk:5026
+#: gitk:5040 gitk:5045
 msgid "Descendant"
 msgstr "=D0=9D=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=BA"
=20
-#: gitk:5022
+#: gitk:5041
 msgid "Not descendant"
 msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=
=D0=B8=D0=BA"
=20
-#: gitk:5029 gitk:5034
+#: gitk:5048 gitk:5053
 msgid "Ancestor"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B5=D0=
=BD=D0=B8=D0=BA"
=20
-#: gitk:5030
+#: gitk:5049
 msgid "Not ancestor"
 msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=
=D1=82=D0=B2=D0=B5=D0=BD=D0=B8=D0=BA"
=20
-#: gitk:5324
+#: gitk:5343
 msgid "Local changes checked in to index but not committed"
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD=D0=B8 =
=D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0, =D0=BD=D0=
=BE =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:5360
+#: gitk:5379
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B8=D0=B7=D0=B2=D1=8A=D0=BD =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B0"
=20
-#: gitk:7134
+#: gitk:7153
 msgid "and many more"
 msgstr "=D0=B8 =D0=BE=D1=89=D0=B5 =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
=20
-#: gitk:7137
+#: gitk:7156
 msgid "many"
 msgstr "=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
=20
-#: gitk:7328
+#: gitk:7347
 msgid "Tags:"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8:"
=20
-#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7364 gitk:7370 gitk:8844
 msgid "Parent"
 msgstr "=D0=A0=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
=20
-#: gitk:7356
+#: gitk:7375
 msgid "Child"
 msgstr "=D0=94=D0=B5=D1=82=D0=B5"
=20
-#: gitk:7365
+#: gitk:7384
 msgid "Branch"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:7368
+#: gitk:7387
 msgid "Follows"
 msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0"
=20
-#: gitk:7371
+#: gitk:7390
 msgid "Precedes"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0"
=20
-#: gitk:7966
+#: gitk:7985
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5: %s"
=20
-#: gitk:8650
+#: gitk:8669
 msgid "Goto:"
 msgstr "=D0=9A=D1=8A=D0=BC =D1=80=D0=B5=D0=B4:"
=20
-#: gitk:8671
+#: gitk:8690
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "=D0=A1=D1=8A=D0=BA=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=B0=D1=82=D0=
=B0 =D1=81=D1=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s =D0=BD=D0=B5 =D0=B5 =D0=
=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=BD=D0=B0"
=20
-#: gitk:8678
+#: gitk:8697
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D0=B2=D0=
=B5=D1=80=D1=81=D0=B8=D1=8F %s"
=20
-#: gitk:8688
+#: gitk:8707
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D1=81=D1=
=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s"
=20
-#: gitk:8690
+#: gitk:8709
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F %s =D0=BD=D0=B5 =D0=B5 =D0=
=B2 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=B8=D0=B7=D0=B3=D0=BB=
=D0=B5=D0=B4"
=20
-#: gitk:8832 gitk:8847
+#: gitk:8851 gitk:8866
 msgid "Date"
 msgstr "=D0=94=D0=B0=D1=82=D0=B0"
=20
-#: gitk:8835
+#: gitk:8854
 msgid "Children"
 msgstr "=D0=94=D0=B5=D1=86=D0=B0"
=20
-#: gitk:8898
+#: gitk:8917
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=D1=
=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:8900
+#: gitk:8919
 msgid "Detached head: can't reset"
 msgstr "=D0=9D=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD =D0=B2=D1=
=80=D1=8A=D1=85: =D0=BD=D0=B5=D0=B2=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=
=D0=BE =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9005 gitk:9011
+#: gitk:9024 gitk:9030
 msgid "Skipping merge commit "
 msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:9020 gitk:9025
+#: gitk:9039 gitk:9044
 msgid "Error getting patch ID for "
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=
=D0=BE=D1=80=D0=B0 =D0=BD=D0=B0 "
=20
-#: gitk:9021 gitk:9026
+#: gitk:9040 gitk:9045
 msgid " - stopping\n"
 msgstr " =E2=80=94 =D1=81=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
=20
-#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9050 gitk:9053 gitk:9061 gitk:9075 gitk:9084
 msgid "Commit "
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9035
+#: gitk:9054
 msgid ""
 " is the same patch as\n"
 "       "
@@ -896,7 +912,7 @@ msgstr ""
 " =D0=B5 =D1=81=D1=8A=D1=89=D0=B0=D1=82=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=
=D0=BA=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE\n"
 "       "
=20
-#: gitk:9043
+#: gitk:9062
 msgid ""
 " differs from\n"
 "       "
@@ -904,7 +920,7 @@ msgstr ""
 " =D1=81=D0=B5 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=B0=D0=B2=D0=B0 =
=D0=BE=D1=82\n"
 "       "
=20
-#: gitk:9045
+#: gitk:9064
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -912,130 +928,130 @@ msgstr ""
 "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D0=BC=D0=B5=D0=B6=D0=B4=D1=
=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0:=
\n"
 "\n"
=20
-#: gitk:9057 gitk:9066
+#: gitk:9076 gitk:9085
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " =D0=B8=D0=BC=D0=B0 %s =D0=B4=D0=B5=D1=86=D0=B0 =E2=80=94 =D1=81=
=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
=20
-#: gitk:9085
+#: gitk:9104
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB: %s"
=20
-#: gitk:9091
+#: gitk:9110
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D1=87=D0=B8=D1=81=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE=
 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D0=
=BC=D0=B5=D0=B6=D0=B4=D1=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B8=D1=8F=D1=82=D0=B0: %s"
=20
-#: gitk:9137
+#: gitk:9156
 msgid "Top"
 msgstr "=D0=9D=D0=B0=D0=B9-=D0=B3=D0=BE=D1=80=D0=B5"
=20
-#: gitk:9138
+#: gitk:9157
 msgid "From"
 msgstr "=D0=9E=D1=82"
=20
-#: gitk:9143
+#: gitk:9162
 msgid "To"
 msgstr "=D0=94=D0=BE"
=20
-#: gitk:9167
+#: gitk:9186
 msgid "Generate patch"
 msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
=20
-#: gitk:9169
+#: gitk:9188
 msgid "From:"
 msgstr "=D0=9E=D1=82:"
=20
-#: gitk:9178
+#: gitk:9197
 msgid "To:"
 msgstr "=D0=94=D0=BE:"
=20
-#: gitk:9187
+#: gitk:9206
 msgid "Reverse"
 msgstr "=D0=9E=D0=B1=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9189 gitk:9385
+#: gitk:9208 gitk:9418
 msgid "Output file:"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0:"
=20
-#: gitk:9195
+#: gitk:9214
 msgid "Generate"
 msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9233
+#: gitk:9252
 msgid "Error creating patch:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0:"
=20
-#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9275 gitk:9406 gitk:9463
 msgid "ID:"
 msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80:"
=20
-#: gitk:9265
+#: gitk:9284
 msgid "Tag name:"
 msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=
=D1=82:"
=20
-#: gitk:9268
+#: gitk:9287
 msgid "Tag message is optional"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=
=BE =D0=B7=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82 =D0=B5 =D0=BD=D0=B5=
=D0=B7=D0=B0=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=
"
=20
-#: gitk:9270
+#: gitk:9289
 msgid "Tag message:"
 msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B7=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
=20
-#: gitk:9274 gitk:9439
+#: gitk:9293 gitk:9472
 msgid "Create"
 msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9292
+#: gitk:9311
 msgid "No tag name specified"
 msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=
=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:9296
+#: gitk:9315
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D1=8A=D1=82 =E2=80=9E%s=E2=
=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0"
=20
-#: gitk:9306
+#: gitk:9325
 msgid "Error creating tag:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
=20
-#: gitk:9382
+#: gitk:9415
 msgid "Command:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
=20
-#: gitk:9390
+#: gitk:9423
 msgid "Write"
 msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9408
+#: gitk:9441
 msgid "Error writing commit:"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE:"
=20
-#: gitk:9435
+#: gitk:9468
 msgid "Name:"
 msgstr "=D0=98=D0=BC=D0=B5:"
=20
-#: gitk:9458
+#: gitk:9491
 msgid "Please specify a name for the new branch"
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =
=D0=B7=D0=B0 =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD"
=20
-#: gitk:9463
+#: gitk:9496
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=B2=
=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=
=D0=B0. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD?"
=20
-#: gitk:9530
+#: gitk:9563
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=80=9E=
%s=E2=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=
=87=D0=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=
=E2=80=9C =E2=80=94 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =
=D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=BE =D0=BE=D1=82=D0=BD=
=D0=BE=D0=B2=D0=BE?"
=20
-#: gitk:9535
+#: gitk:9568
 msgid "Cherry-picking"
 msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9544
+#: gitk:9577
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1044,7 +1060,7 @@ msgstr ""
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
-#: gitk:9550
+#: gitk:9583
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1052,20 +1068,20 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =
=D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8=
 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
 "=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
=20
-#: gitk:9566 gitk:9624
+#: gitk:9599 gitk:9657
 msgid "No changes committed"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=
=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:9593
+#: gitk:9626
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=
=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=
=9C. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BE=D1=82=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE?"
=20
-#: gitk:9598
+#: gitk:9631
 msgid "Reverting"
 msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0"
=20
-#: gitk:9606
+#: gitk:9639
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
@@ -1074,7 +1090,7 @@ msgstr ""
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
-#: gitk:9610
+#: gitk:9643
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1082,28 +1098,28 @@ msgstr ""
 "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=BC=D1=8F=D0=BD=D0=B0 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =D0=BA=D0=BE=
=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8 =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
 "=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
=20
-#: gitk:9653
+#: gitk:9686
 msgid "Confirm reset"
 msgstr "=D0=9F=D0=BE=D1=82=D0=B2=D1=8A=D1=80=D0=B6=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=
=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
-#: gitk:9655
+#: gitk:9688
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D0=B8=
 =D0=BB=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C=
 =D0=BA=D1=8A=D0=BC =E2=80=9E%s=E2=80=9C?"
=20
-#: gitk:9657
+#: gitk:9690
 msgid "Reset type:"
 msgstr "=D0=92=D0=B8=D0=B4 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=
=B0=D0=BD=D0=B5:"
=20
-#: gitk:9660
+#: gitk:9693
 msgid "Soft: Leave working tree and index untouched"
 msgstr "=D0=A1=D0=BB=D0=B0=D0=B1=D0=BE: =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=B8 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0=D1=
=82 =D1=81=D1=8A=D1=89=D0=B8=D1=82=D0=B5"
=20
-#: gitk:9663
+#: gitk:9696
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "=D0=A1=D0=BC=D0=B5=D1=81=D0=B5=D0=BD=D0=BE: =D1=80=D0=B0=D0=B1=
=D0=BE=D1=82=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=
=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0 =D1=81=D1=8A=D1=89=D0=BE=D1=82=D0=BE,=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D1=81=D0=B5 =D0=B7=D0=
=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0"
=20
-#: gitk:9666
+#: gitk:9699
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1111,19 +1127,19 @@ msgstr ""
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
-#: gitk:9683
+#: gitk:9716
 msgid "Resetting"
 msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:9743
+#: gitk:9776
 msgid "Checking out"
 msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
=20
-#: gitk:9796
+#: gitk:9829
 msgid "Cannot delete the currently checked-out branch"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=
=B3=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F=D1=82 =D0=BA=D0=BB=D0=BE=D0=BD =D0=BD=
=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=
=B8=D0=B7=D1=82=D1=80=D0=B8=D1=82"
=20
-#: gitk:9802
+#: gitk:9835
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1132,16 +1148,16 @@ msgstr ""
 "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BD=D0=
=B5 =D1=81=D0=B0 =D0=BD=D0=B0 =D0=BD=D0=B8=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=
=D1=83=D0=B3 =D0=BA=D0=BB=D0=BE=D0=BD.\n"
 "=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B5 =D0=BA=D0=BB=D0=BE=
=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C?"
=20
-#: gitk:9833
+#: gitk:9866
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=
=D1=80=D1=85=D0=BE=D0=B2=D0=B5: %s"
=20
-#: gitk:9850
+#: gitk:9883
 msgid "Filter"
 msgstr "=D0=A4=D0=B8=D0=BB=D1=82=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:10146
+#: gitk:10179
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -1149,201 +1165,201 @@ msgstr ""
 "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D1=82=
=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B3=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0. =D0=
=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=B7=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 "
 "=D0=B8 =D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D1=
=89=D0=B8=D1=82=D0=B5/=D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=
=82=D0=B5 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8 =D1=89=D0=B5 =D0=B5=
 =D0=BD=D0=B5=D0=BF=D1=8A=D0=BB=D0=BD=D0=B0."
=20
-#: gitk:11123
+#: gitk:11156
 msgid "Tag"
 msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
=20
-#: gitk:11127
+#: gitk:11160
 msgid "Id"
 msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80"
=20
-#: gitk:11210
+#: gitk:11243
 msgid "Gitk font chooser"
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=
=D1=84=D1=82 =D0=B7=D0=B0 Gitk"
=20
-#: gitk:11227
+#: gitk:11260
 msgid "B"
 msgstr "=D0=A7"
=20
-#: gitk:11230
+#: gitk:11263
 msgid "I"
 msgstr "=D0=9A"
=20
-#: gitk:11348
+#: gitk:11381
 msgid "Commit list display options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: gitk:11351
+#: gitk:11384
 msgid "Maximum graph width (lines)"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (=D0=B2 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5)"
=20
-#: gitk:11355
+#: gitk:11388
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (% =D0=BE=D1=82 =D0=BF=D0=B0=D0=BD=D0=B5=D0=BB=D0=B0=
)"
=20
-#: gitk:11358
+#: gitk:11391
 msgid "Show local changes"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
=20
-#: gitk:11361
+#: gitk:11394
 msgid "Auto-select SHA1 (length)"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=
=BE =D0=B8=D0=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 SHA1 =
(=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D0=BD=D0=B0)"
=20
-#: gitk:11365
+#: gitk:11398
 msgid "Hide remote refs"
 msgstr "=D0=A1=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=82=D0=B5=
 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8"
=20
-#: gitk:11369
+#: gitk:11402
 msgid "Diff display options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
=20
-#: gitk:11371
+#: gitk:11404
 msgid "Tab spacing"
 msgstr "=D0=A8=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =
=D1=82=D0=B0=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D1=80=D0=B0"
=20
-#: gitk:11374
+#: gitk:11407
 msgid "Display nearby tags/heads"
 msgstr "=D0=98=D0=B7=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D1=82=D0=B5 =D0=B5=D1=82=D0=B8=
=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=
=B5"
=20
-#: gitk:11377
+#: gitk:11410
 msgid "Maximum # tags/heads to show"
 msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD =D0=
=B1=D1=80=D0=BE=D0=B9 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8/=D0=B2=
=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=B5 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=BA=D0=
=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11380
+#: gitk:11413
 msgid "Limit diffs to listed paths"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D1=81=D0=B0=D0=BC=D0=
=BE =D0=B2 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D1=8A=D1=82=D0=B8=D1=89=D0=B0"
=20
-#: gitk:11383
+#: gitk:11416
 msgid "Support per-file encodings"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B4=D1=80=D1=8A=D0=B6=D0=BA=D0=B0 =D0=BD=D0=
=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D0=B8 =D0=BA=D0=BE=D0=B4=
=D0=B8=D1=80=D0=B0=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=B2=D1=81=D0=B5=D0=
=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:11389 gitk:11536
+#: gitk:11422 gitk:11569
 msgid "External diff tool"
 msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=B5=D0=BD =D0=B8=D0=BD=D1=81=D1=82=D1=
=80=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=
=D0=B8=D0=BA=D0=B8"
=20
-#: gitk:11390
+#: gitk:11423
 msgid "Choose..."
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80=E2=80=A6"
=20
-#: gitk:11395
+#: gitk:11428
 msgid "General options"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8 =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=
=B9=D0=BA=D0=B8"
=20
-#: gitk:11398
+#: gitk:11431
 msgid "Use themed widgets"
 msgstr "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=82=D0=B5=D0=BC=D0=B0 =D0=B7=D0=B0 =D0=B3=D1=80=D0=B0=D1=84=
=D0=B8=D1=87=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=
"
=20
-#: gitk:11400
+#: gitk:11433
 msgid "(change requires restart)"
 msgstr "(=D0=BF=D1=80=D0=BE=D0=BC=D1=8F=D0=BD=D0=B0=D1=82=D0=B0 =D0=B8=
=D0=B7=D0=B8=D1=81=D0=BA=D0=B2=D0=B0 =D1=80=D0=B5=D1=81=D1=82=D0=B0=D1=80=
=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 Gitk)"
=20
-#: gitk:11402
+#: gitk:11435
 msgid "(currently unavailable)"
 msgstr "(=D0=B2 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BD=D0=B5=
=D0=B4=D0=BE=D1=81=D1=82=D1=8A=D0=BF=D0=BD=D0=BE)"
=20
-#: gitk:11413
+#: gitk:11446
 msgid "Colors: press to choose"
 msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=D0=B1=
=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=81=D0=
=BA=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11416
+#: gitk:11449
 msgid "Interface"
 msgstr "=D0=98=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
-#: gitk:11417
+#: gitk:11450
 msgid "interface"
 msgstr "=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
=20
-#: gitk:11420
+#: gitk:11453
 msgid "Background"
 msgstr "=D0=A4=D0=BE=D0=BD"
=20
-#: gitk:11421 gitk:11451
+#: gitk:11454 gitk:11484
 msgid "background"
 msgstr "=D1=84=D0=BE=D0=BD"
=20
-#: gitk:11424
+#: gitk:11457
 msgid "Foreground"
 msgstr "=D0=97=D0=BD=D0=B0=D1=86=D0=B8"
=20
-#: gitk:11425
+#: gitk:11458
 msgid "foreground"
 msgstr "=D0=B7=D0=BD=D0=B0=D1=86=D0=B8"
=20
-#: gitk:11428
+#: gitk:11461
 msgid "Diff: old lines"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11429
+#: gitk:11462
 msgid "diff old lines"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11433
+#: gitk:11466
 msgid "Diff: new lines"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11434
+#: gitk:11467
 msgid "diff new lines"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11438
+#: gitk:11471
 msgid "Diff: hunk header"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
=20
-#: gitk:11440
+#: gitk:11473
 msgid "diff hunk header"
 msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
=20
-#: gitk:11444
+#: gitk:11477
 msgid "Marked line bg"
 msgstr "=D0=A4=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
=20
-#: gitk:11446
+#: gitk:11479
 msgid "marked line background"
 msgstr "=D1=84=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
=20
-#: gitk:11450
+#: gitk:11483
 msgid "Select bg"
 msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=84=D0=BE=D0=BD=
"
=20
-#: gitk:11459
+#: gitk:11492
 msgid "Fonts: press to choose"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=
=D0=B1=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=
=81=D0=BA=D0=B0=D0=BD=D0=B5"
=20
-#: gitk:11461
+#: gitk:11494
 msgid "Main font"
 msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD =D1=88=D1=80=D0=B8=D1=
=84=D1=82"
=20
-#: gitk:11462
+#: gitk:11495
 msgid "Diff display font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=
=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
=20
-#: gitk:11463
+#: gitk:11496
 msgid "User interface font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BD=D0=B0 =D0=B8=D0=BD=D1=82=
=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
-#: gitk:11485
+#: gitk:11518
 msgid "Gitk preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 Gitk"
=20
-#: gitk:11494
+#: gitk:11527
 msgid "General"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8"
=20
-#: gitk:11495
+#: gitk:11528
 msgid "Colors"
 msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11496
+#: gitk:11529
 msgid "Fonts"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5"
=20
-#: gitk:11546
+#: gitk:11579
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=86=D0=B2=
=D1=8F=D1=82 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C"
=20
-#: gitk:12059
+#: gitk:12092
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1351,15 +1367,15 @@ msgstr ""
 "=D0=A2=D0=B0=D0=B7=D0=B8 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BD=D0=
=B0 Tcl/Tk =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=
=D0=B6=D0=B0 =D0=BE=D1=82 Gitk.\n"
 " =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=B0 =D0=B2=D0=
=B8 =D0=B5 =D0=BF=D0=BE=D0=BD=D0=B5 Tcl/Tk 8.4."
=20
-#: gitk:12269
+#: gitk:12302
 msgid "Cannot find a git repository here."
 msgstr "=D0=A2=D1=83=D0=BA =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D1=85=
=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=B0 Git."
=20
-#: gitk:12316
+#: gitk:12349
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "=D0=9D=D0=B5=D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=B5=D0=BD =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =E2=80=9E%s=E2=
=80=9C: =D0=B8=D0=BC=D0=B0 =D0=B8 =D1=82=D0=B0=D0=BA=D0=B0=D0=B2=D0=B0 =
=D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F, =D0=B8 =D1=82=D0=B0=D0=BA=D1=8A=D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB"
=20
-#: gitk:12328
+#: gitk:12361
 msgid "Bad arguments to gitk:"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BD=D0=B0 gitk:"
--=20
2.6.4
