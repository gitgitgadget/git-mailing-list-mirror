From: al_shopov@yahoo.com
Subject: [PATCH] gitk i18n: Added Bulgarian translation (304t)
Date: Wed, 15 Jan 2014 13:27:29 +0200
Message-ID: <1389785251-8472-3-git-send-email-lists@kambanaria.org>
References: <1389785251-8472-1-git-send-email-lists@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OdU-0002XO-92
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbaAOL1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 06:27:47 -0500
Received: from nm16-vm1.bullet.mail.ird.yahoo.com ([77.238.189.88]:33510 "EHLO
	nm16-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbaAOL1p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:27:45 -0500
Received: from [77.238.189.54] by nm16.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:27:41 -0000
Received: from [46.228.39.69] by tm7.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:27:41 -0000
Received: from [127.0.0.1] by smtp106.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389785261; bh=U5t1UsFEv8oIyIufoPIteoGhaUox+XbJRsgeq+COgM0=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=iXwVXkRDjX4y2iCP6kAreskygxzuwv9p/e1gAKmvHH1ZHTLtwB9LUofnfKJvlmZD/A3szBp+2Nf+qGCOgvAHEcFTourMPDdA+KbFQBlCVreC4Zo3oGTOmb5wc1TbrPQNAs6+xWIUs+fWqUfeNAPrkilY9pWmFthfoxJMRjPgPFY=
X-Yahoo-Newman-Id: 607055.90545.bm@smtp106.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp106.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:27:41 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: fAByzA4VM1nxvhpofdX9k0aDVEGQ_fzqpQAdwgvt4HdpAi6
 .r.ZWGdTxfqkBABKymazsSa4GKeQ_2tzgZtN9IeY7QjXZd3MMOp462w_U4Z8
 8FCR1zGmaWBNtngtTRxjq0XBSmGnEq_S9ZWb0LLruWE9Fr9W_t5QfKCYMR6B
 SFvN12QbDlAUQJ8KKpJyODTILUMCmn844fHDzFAbCPXrZHP0VKgPE.yRWYrO
 S5KGTmfYSCGLiS91THxJInagMBKU.1U2VZy0YjwkqOKpcK69O61etpt.p.qE
 9BbSSvy6_ZN9bUoHr5KPhKBtEi4VAkvOcVOTtOUwTqdPf0bLX7kRutktoo3z
 O_TiiRQ_sc0aAFjXk6jnep6EXuW1M36Nckx0jbfZS3_PV4UZgPylzY6DqpNi
 nxiwBz8.psouDdF8OX4zqVLDeZ7g23.LTd9nI7UZIyiuejxfFB60lE9ptYim
 jzko5Ec2tQE0_MDc3FgtvelH.xL2XEsJWFowJxH97m1Wb9WvUtWBDyhqRcOs
 M.CJu2BgNbVGkrWTd4GpMVlfnCPfXKXUCL7G0jAIF6gO4
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1389785251-8472-1-git-send-email-lists@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240462>

=46rom: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 1334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 1334 insertions(+)
 create mode 100644 po/bg.po

diff --git a/po/bg.po b/po/bg.po
new file mode 100644
index 0000000..782397e
--- /dev/null
+++ b/po/bg.po
@@ -0,0 +1,1334 @@
+# Bulgarian translation of gitk po-file.
+# Copyright (C) 2014 Alexander Shopov <ash@kambanaria.org>.
+# This file is distributed under the same license as the git package.
+# Alexander Shopov <ash@kambanaria.org>, 2014.
+#
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk master\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"PO-Revision-Date: 2014-01-08 08:03+0200\n"
+"Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
+"Language-Team: Bulgarian <dict@fsa-bg.org>\n"
+"Language: bg\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+#: gitk:140
+msgid "Couldn't get list of unmerged files:"
+msgstr "=D0=A1=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D1=8A=D1=82 =D1=81 =D0=BD=
=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=
=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=
=B4=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD:"
+
+#: gitk:212 gitk:2353
+msgid "Color words"
+msgstr "=D0=9E=D1=86=D0=B2=D0=B5=D1=82=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
+
+#: gitk:217 gitk:2353 gitk:8103 gitk:8136
+msgid "Markup words"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B4=D1=83=D0=BC=D0=B8=D1=82=D0=B5"
+
+#: gitk:322
+msgid "Error parsing revisions:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=80=
=D0=B0=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D0=B8=D1=82=D0=B5:"
+
+#: gitk:378
+msgid "Error executing --argscmd command:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=
=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =D1=81 =E2=80=9E--a=
rgscmd=E2=80=9C."
+
+#: gitk:391
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=
=D0=B0=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=
=82=D0=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=
=B0 =D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=D0=B5."
+
+#: gitk:394
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =E2=80=94 =D1=83=D0=BA=
=D0=B0=D0=B7=D0=B0=D0=BD=D0=B0 =D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=8F=D1=
=82=D0=B0 =E2=80=9E--merge=E2=80=9C, =D0=BD=D0=BE =D0=BD=D1=8F=D0=BC=D0=
=B0 =D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=D0=B5 =D0=B2 =D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=
=B5=D0=BD=D0=B8=D1=8F=D1=82=D0=B0."
+
+#: gitk:416 gitk:564
+msgid "Error executing git log:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =E2=
=80=9Egit log=E2=80=9C:"
+
+#: gitk:434 gitk:580
+msgid "Reading"
+msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5"
+
+#: gitk:494 gitk:4429
+msgid "Reading commits..."
+msgstr "=D0=9F=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0=E2=
=80=A6"
+
+#: gitk:497 gitk:1635 gitk:4432
+msgid "No commits selected"
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
+
+#: gitk:1509
+msgid "Can't parse git log output:"
+msgstr "=D0=98=D0=B7=D1=85=D0=BE=D0=B4=D1=8A=D1=82 =D0=BE=D1=82 =E2=80=
=9Egit log=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =
=D1=81=D0=B5 =D0=B0=D0=BD=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=B0:"
+
+#: gitk:1738
+msgid "No commit information available"
+msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BD=D1=84=D0=BE=D1=
=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
+
+#: gitk:1895
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1930 gitk:4222 gitk:9552 gitk:11122 gitk:11401
+msgid "OK"
+msgstr "=D0=94=D0=BE=D0=B1=D1=80=D0=B5"
+
+#: gitk:1932 gitk:4224 gitk:9079 gitk:9158 gitk:9274 gitk:9323 gitk:95=
54
+#: gitk:11123 gitk:11402
+msgid "Cancel"
+msgstr "=D0=9E=D1=82=D0=BA=D0=B0=D0=B7"
+
+#: gitk:2067
+msgid "Update"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2068
+msgid "Reload"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B7=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=
=BD=D0=B5"
+
+#: gitk:2069
+msgid "Reread references"
+msgstr "=D0=9D=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=87=D0=
=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=81=D1=82=D1=80=
=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5"
+
+#: gitk:2070
+msgid "List references"
+msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=
=B5"
+
+#: gitk:2072
+msgid "Start git gui"
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 git gui"
+
+#: gitk:2074
+msgid "Quit"
+msgstr "=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
+
+#: gitk:2066
+msgid "File"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB"
+
+#: gitk:2078
+msgid "Preferences"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
+
+#: gitk:2077
+msgid "Edit"
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5"
+
+#: gitk:2082
+msgid "New view..."
+msgstr "=D0=9D=D0=BE=D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=E2=80=A6=
"
+
+#: gitk:2083
+msgid "Edit view..."
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=E2=80=A6"
+
+#: gitk:2084
+msgid "Delete view"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
+
+#: gitk:2086
+msgid "All files"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2=D0=B5"
+
+#: gitk:2081 gitk:3975
+msgid "View"
+msgstr "=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
+
+#: gitk:2091 gitk:2101 gitk:2945
+msgid "About gitk"
+msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
+
+#: gitk:2092 gitk:2106
+msgid "Key bindings"
+msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
+
+#: gitk:2090 gitk:2105
+msgid "Help"
+msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89"
+
+#: gitk:2183 gitk:8535
+msgid "SHA1 ID:"
+msgstr "SHA1:"
+
+#: gitk:2227
+msgid "Row"
+msgstr "=D0=A0=D0=B5=D0=B4"
+
+#: gitk:2265
+msgid "Find"
+msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
+
+#: gitk:2266
+msgid "next"
+msgstr "=D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=BE"
+
+#: gitk:2267
+msgid "prev"
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=BE"
+
+#: gitk:2268
+msgid "commit"
+msgstr "=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2271 gitk:2273 gitk:4590 gitk:4613 gitk:4637 gitk:6653 gitk:67=
25
+#: gitk:6810
+msgid "containing:"
+msgstr "=D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D1=89=D0=BE:"
+
+#: gitk:2274 gitk:3457 gitk:3462 gitk:4666
+msgid "touching paths:"
+msgstr "=D0=B7=D0=B0=D1=81=D1=8F=D0=B3=D0=B0=D1=89=D0=BE =D0=BF=D1=8A=D1=
=82=D0=B8=D1=89=D0=B0=D1=82=D0=B0:"
+
+#: gitk:2275 gitk:4680
+msgid "adding/removing string:"
+msgstr "=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D1=89=D0=BE/=D0=BF=D1=80=D0=
=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D1=89=D0=BE =D0=BD=D0=B8=D0=B7"
+
+#: gitk:2276 gitk:4682
+msgid "changing lines matching:"
+msgstr "=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D1=8F=D1=89=D0=BE =D1=80=D0=
=B5=D0=B4=D0=BE=D0=B2=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B0=D1=81=D0=B2=D0=B0=D1=
=89=D0=B8:"
+
+#: gitk:2285 gitk:2287 gitk:4669
+msgid "Exact"
+msgstr "=D0=A2=D0=BE=D1=87=D0=BD=D0=BE"
+
+#: gitk:2287 gitk:4757 gitk:6621
+msgid "IgnCase"
+msgstr "=D0=91=D0=B5=D0=B7 =D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=8A=D1=
=80"
+
+#: gitk:2287 gitk:4639 gitk:4755 gitk:6617
+msgid "Regexp"
+msgstr "=D0=A0=D0=B5=D0=B3. =D0=B8=D0=B7=D1=80."
+
+#: gitk:2289 gitk:2290 gitk:4777 gitk:4807 gitk:4814 gitk:6746 gitk:68=
14
+msgid "All fields"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B5=D1=
=82=D0=B0"
+
+#: gitk:2290 gitk:4774 gitk:4807 gitk:6684
+msgid "Headline"
+msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=B8 =D1=80=D0=B5=D0=B4"
+
+#: gitk:2291 gitk:4774 gitk:6684 gitk:6814 gitk:7283
+msgid "Comments"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8"
+
+#: gitk:2291 gitk:4774 gitk:4779 gitk:4814 gitk:6684 gitk:7218 gitk:87=
13
+#: gitk:8728
+msgid "Author"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
+
+#: gitk:2291 gitk:4774 gitk:6684 gitk:7220
+msgid "Committer"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D1=89"
+
+#: gitk:2322
+msgid "Search"
+msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
+
+#: gitk:2330
+msgid "Diff"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
+
+#: gitk:2332
+msgid "Old version"
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=
=8F"
+
+#: gitk:2334
+msgid "New version"
+msgstr "=D0=9D=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#: gitk:2336
+msgid "Lines of context"
+msgstr "=D0=9A=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B2 =D1=80=
=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
+
+#: gitk:2346
+msgid "Ignore space change"
+msgstr "=D0=9F=D1=80=D0=B0=D0=B7=D0=BD=D0=B8=D1=82=D0=B5 =D0=B7=D0=BD=D0=
=B0=D1=86=D0=B8 =D0=B1=D0=B5=D0=B7 =D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=
=D0=B8=D0=B5"
+
+#: gitk:2350 gitk:2352 gitk:7842 gitk:8089
+msgid "Line diff"
+msgstr "=D0=9F=D0=BE=D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B8 =D1=80=D0=B0=D0=
=B7=D0=BB=D0=B8=D0=BA=D0=B8"
+
+#: gitk:2417
+msgid "Patch"
+msgstr "=D0=9A=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
+
+#: gitk:2419
+msgid "Tree"
+msgstr "=D0=94=D1=8A=D1=80=D0=B2=D0=BE"
+
+#: gitk:2577 gitk:2597
+msgid "Diff this -> selected"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=
=D0=BD=D0=BE=D1=82=D0=BE"
+
+#: gitk:2578 gitk:2598
+msgid "Diff selected -> this"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D1=82=D0=BE =D0=B8=
 =D1=82=D0=BE=D0=B2=D0=B0"
+
+#: gitk:2579 gitk:2599
+msgid "Make patch"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
+
+#: gitk:2580 gitk:9137
+msgid "Create tag"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
+
+#: gitk:2581 gitk:9254
+msgid "Write commit to file"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=
=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB"
+
+#: gitk:2582 gitk:9311
+msgid "Create new branch"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=BE=D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: gitk:2583
+msgid "Cherry-pick this commit"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
+
+#: gitk:2584
+msgid "Reset HEAD branch to here"
+msgstr "=D0=9F=D1=80=D0=B8=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B2=D1=8A=D1=80=D1=85=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B0 =D0=BA=D1=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2585
+msgid "Mark this commit"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=
=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2586
+msgid "Return to mark"
+msgstr "=D0=92=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2587
+msgid "Find descendant of this and mark"
+msgstr "=D0=9E=D1=82=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B8 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=86=D0=B8=D1=82=
=D0=B5"
+
+#: gitk:2588
+msgid "Compare with marked commit"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81 =
=D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2589 gitk:2600
+msgid "Diff this -> marked commit"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B8 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=82=D0=BE"
+
+#: gitk:2590 gitk:2601
+msgid "Diff marked commit -> this"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B0=D0=BD=D0=BE=D1=
=82=D0=BE =D0=B8 =D1=82=D0=BE=D0=B2=D0=B0"
+
+#: gitk:2591
+msgid "Revert this commit"
+msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=82=D0=BE=
=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2607
+msgid "Check out this branch"
+msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: gitk:2608
+msgid "Remove this branch"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: gitk:2615
+msgid "Highlight this too"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=B8 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
+
+#: gitk:2616
+msgid "Highlight this only"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D1=81=D0=B0=D0=BC=D0=BE =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0"
+
+#: gitk:2617
+msgid "External diff"
+msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=
=D0=B8"
+
+#: gitk:2618
+msgid "Blame parent commit"
+msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=BE=D1=82=D0=
=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2625
+msgid "Show origin of this line"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
+
+#: gitk:2626
+msgid "Run git gui blame on this line"
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui blame=E2=80=9C =D0=B2=D1=8A=D1=80=D1=85=D1=83=
 =D1=82=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4"
+
+#: gitk:2947
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2011 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk =E2=80=94 =D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=
=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=B2 Git\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D1=80=D1=81=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=
=B2=D0=B0: =C2=A9 2005-2011 Paul Mackerras\n"
+"\n"
+"=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=
=B8 =D1=80=D0=B0=D0=B7=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=B8 =D1=83=D1=81=D0=BB=
=D0=BE=D0=B2=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 =D0=9E=D0=9F=D0=9B =D0=
=BD=D0=B0 =D0=93=D0=9D=D0=A3"
+
+#: gitk:2955 gitk:3020 gitk:9738
+msgid "Close"
+msgstr "=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5"
+
+#: gitk:2976
+msgid "Gitk key bindings"
+msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
+
+#: gitk:2979
+msgid "Gitk key bindings:"
+msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8:"
+
+#: gitk:2981
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\t=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
+
+#: gitk:2982
+#, tcl-format
+msgid "<%s-W>\t\tClose window"
+msgstr "<%s-W>\t\t=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5=
 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86=D0=B0"
+
+#: gitk:2983
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:2984
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=
=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
+
+#: gitk:2985
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Up>, p, k\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:2986
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Down>, n, j\t=D0=95=D0=B4=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
+
+#: gitk:2987
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Left>, z, h\t=D0=9D=D0=B0=D0=B7=D0=B0=D0=B4 =D0=B2 =D0=B8=D1=81=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: gitk:2988
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Right>, x, l\t=D0=9D=D0=B0=D0=BF=D1=80=D0=B5=D0=B4 =D0=B2 =D0=
=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: gitk:2989
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\t=D0=95=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5 =D0=B2 =D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: gitk:2990
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\t=D0=95=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83 =D0=B2 =D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: gitk:2991
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Home>\t=D0=9A=D1=8A=D0=BC =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BE=D1=82=D0=BE =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0"
+
+#: gitk:2992
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\t=D0=9A=D1=8A=D0=BC =D0=BA=D1=80=D0=B0=D1=8F =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: gitk:2993
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=
=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=
=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=B5=
=D0=B4=D0=B8=D0=BD =D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=
=B5"
+
+#: gitk:2994
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=
=B5=D0=B4=D0=B8=D0=BD =D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=
=D1=83"
+
+#: gitk:2995
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0=
 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81 =D0=
=B5=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:2996
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=
=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=
=B0 =D1=81 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D1=81=
 =D0=B5=D0=B4=D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=
=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
+
+#: gitk:2997
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Shift-Up>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0=D0=B7=D0=B0=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5, =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D0=BE=D1=81=D0=BB=D0=
=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8)"
+
+#: gitk:2998
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Shift-Down>\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=
=D0=B0=D0=BF=D1=80=D0=B5=D0=B4 (=D0=B2=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=
=BD=D0=BE =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83, =D0=B8=D1=81=D1=82=D0=BE=
=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =E2=80=94 =D0=BF=D1=80=D0=B5=
=D0=B4=D1=85=D0=BE=D0=B6=D0=B4=D0=B0=D1=89=D0=B8)"
+
+#: gitk:2999
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Delete>, b\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:3000
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:3001
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Space>\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=B5=D0=B4=D0=
=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D0=BD=D0=B0=
=D0=B4=D0=BE=D0=BB=D1=83"
+
+#: gitk:3002
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 18 =D1=80=D0=B5=D0=B4=
=D0=B0 =D0=BD=D0=B0=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:3003
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 18 =D1=80=D0=B5=D0=B4=
=D0=B0 =D0=BD=D0=B0=D0=B4=D0=BE=D0=BB=D1=83"
+
+#: gitk:3004
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
+
+#: gitk:3005
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
+
+#: gitk:3006
+msgid "<Return>\tMove to next find hit"
+msgstr "<Return>\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
+
+#: gitk:3007
+msgid "/\t\tFocus the search box"
+msgstr "/\t\t=D0=A4=D0=BE=D0=BA=D1=83=D1=81 =D0=B2=D1=8A=D1=80=D1=85=D1=
=83 =D0=BF=D0=BE=D0=BB=D0=B5=D1=82=D0=BE =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=
=D1=81=D0=B5=D0=BD=D0=B5"
+
+#: gitk:3008
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=
=BD=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
+
+#: gitk:3009
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\t=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8 =D0=BA=D1=8A=D0=BC =D1=
=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=8F =D1=80=D0=B5=D0=B4"
+
+#: gitk:3010
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
+
+#: gitk:3011
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\t=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=
=D0=BE=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=
=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8"
+
+#: gitk:3012
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
+
+#: gitk:3013
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\t=D0=9F=D0=BE-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
+
+#: gitk:3014
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
+
+#: gitk:3015
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\t=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D1=8A=D0=BA =D1=80=
=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=D1=84=D1=
=82=D0=B0"
+
+#: gitk:3016
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\t=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=
=D0=B5"
+
+#: gitk:3471 gitk:3480
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=
=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =E2=80=9E%s=E2=80=9C=
:"
+
+#: gitk:3493
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BE=D1=82 %s:"
+
+#: gitk:3556
+msgid "command failed:"
+msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=
=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: gitk:3705
+msgid "No such commit"
+msgstr "=D0=A2=D0=B0=D0=BA=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D1=8F=D0=BC=D0=B0"
+
+#: gitk:3719
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: =D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=
=D0=BE =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: gitk:3750
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "=D0=92=D1=8A=D1=80=D1=85=D1=8A=D1=82 =D0=B7=D0=B0 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=D1=80=D0=BE=D1=87=D0=B5=D1=82=
=D0=B5=D0=BD: %s"
+
+#: gitk:3758
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0: %s"
+
+#: gitk:3783
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =E2=80=9E=
git blame=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=
=B1=D1=8A=D0=B4=D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B0: %s"
+
+#: gitk:3786 gitk:6652
+msgid "Searching"
+msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5"
+
+#: gitk:3818
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =E2=80=9Egit blame=E2=80=9C: %s"
+
+#: gitk:3846
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "=D0=A2=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4 =D0=B8=D0=B4=D0=B2=
=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE %s,  =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D0=B5 =D0=B2=
 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
+
+#: gitk:3860
+msgid "External diff viewer failed:"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=
=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=B2=
=D1=8A=D0=BD=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=
=B8:"
+
+#: gitk:3978
+msgid "Gitk view definition"
+msgstr "=D0=94=D0=B5=D1=84=D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D1=8F =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4 =D0=B2 Gitk"
+
+#: gitk:3982
+msgid "Remember this view"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
+
+#: gitk:3983
+msgid "References (space separated list):"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8 (=D1=81=
=D0=BF=D0=B8=D1=81=D1=8A=D0=BA =D1=81 =D1=80=D0=B0=D0=B7=D0=B4=D0=B5=D0=
=BB=D0=B8=D1=82=D0=B5=D0=BB =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=B2=D0=B0=D0=
=BB):"
+
+#: gitk:3984
+msgid "Branches & tags:"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8 =D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=
=D0=B5=D1=82=D0=B8:"
+
+#: gitk:3985
+msgid "All refs"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=
=B0=D1=82=D0=B5=D0=BB=D0=B8"
+
+#: gitk:3986
+msgid "All (local) branches"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 (=D0=BB=D0=BE=D0=BA=D0=B0=
=D0=BB=D0=BD=D0=B8) =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
+
+#: gitk:3987
+msgid "All tags"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=B5=D1=82=D0=B8=D0=BA=D0=
=B5=D1=82=D0=B8"
+
+#: gitk:3988
+msgid "All remote-tracking branches"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=81=D0=BB=D0=B5=D0=B4=D1=
=8F=D1=89=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
+
+#: gitk:3989
+msgid "Commit Info (regular expressions):"
+msgstr "=D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 (=D1=80=D0=B5=
=D0=B3. =D0=B8=D0=B7=D1=80.):"
+
+#: gitk:3990
+msgid "Author:"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
+
+#: gitk:3991
+msgid "Committer:"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=BB:"
+
+#: gitk:3992
+msgid "Commit Message:"
+msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: gitk:3993
+msgid "Matches all Commit Info criteria"
+msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BA=D0=BE=D1=8F =D0=B4=D0=B0 =D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=
=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: gitk:3994
+msgid "Changes to Files:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BF=D0=BE =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5:"
+
+#: gitk:3995
+msgid "Fixed String"
+msgstr "=D0=94=D0=BE=D1=81=D0=BB=D0=BE=D0=B2=D0=B5=D0=BD =D0=BD=D0=B8=D0=
=B7"
+
+#: gitk:3996
+msgid "Regular Expression"
+msgstr "=D0=A0=D0=B5=D0=B3=D1=83=D0=BB=D1=8F=D1=80=D0=B5=D0=BD =D0=B8=D0=
=B7=D1=80=D0=B0=D0=B7"
+
+#: gitk:3997
+msgid "Search string:"
+msgstr "=D0=9D=D0=B8=D0=B7 =D0=B7=D0=B0 =D1=82=D1=8A=D1=80=D1=81=D0=B5=
=D0=BD=D0=B5:"
+
+#: gitk:3998
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr "=D0=94=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5 (=E2=80=9E2 weeks ago=E2=80=9C (=D0=BF=D1=80=D0=
=B5=D0=B4=D0=B8 2 =D1=81=D0=B5=D0=B4=D0=BC=D0=B8=D1=86=D0=B8), =E2=80=9E=
2009-03-17 15:27:38=E2=80=9C, =E2=80=9EMarch 17, 2009 15:27:38=E2=80=9C=
):"
+
+#: gitk:3999
+msgid "Since:"
+msgstr "=D0=9E=D1=82:"
+
+#: gitk:4000
+msgid "Until:"
+msgstr "=D0=94=D0=BE:"
+
+#: gitk:4001
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=B8/=D0=B8=D0=BB=D0=B8 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=B0=
=D1=87=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=
=B5=D0=BB=D0=B5=D0=BD =D0=B1=D1=80=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D0=B8 (=D0=BD=D0=B5=D0=BE=D1=82=D1=80=D0=B8=D1=86=D0=B0=D1=82=D0=
=B5=D0=BB=D0=BD=D0=BE =D1=86=D1=8F=D0=BB=D0=BE =D1=87=D0=B8=D1=81=D0=BB=
=D0=BE):"
+
+#: gitk:4002
+msgid "Number to show:"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=B8:"
+
+#: gitk:4003
+msgid "Number to skip:"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D1=80=D0=B5=D1=81=D0=BA=D0=BE=D1=
=87=D0=B5=D0=BD=D0=B8:"
+
+#: gitk:4004
+msgid "Miscellaneous options:"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BD=D0=B8:"
+
+#: gitk:4005
+msgid "Strictly sort by date"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=
=BF=D0=BE =D0=B4=D0=B0=D1=82=D0=B0"
+
+#: gitk:4006
+msgid "Mark branch sides"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B5=D0=BB=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0"
+
+#: gitk:4007
+msgid "Limit to first parent"
+msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=B8=D1=8F=D1=
=82 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
+
+#: gitk:4008
+msgid "Simple history"
+msgstr "=D0=9E=D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=B5=D0=BD=D0=B0 =D0=B8=D1=
=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F"
+
+#: gitk:4009
+msgid "Additional arguments to git log:"
+msgstr "=D0=94=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=
=BD=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BA=
=D1=8A=D0=BC =E2=80=9Egit log=E2=80=9C:"
+
+#: gitk:4010
+msgid "Enter files and directories to include, one per line:"
+msgstr "=D0=92=D1=8A=D0=B2=D0=B5=D0=B4=D0=B5=D1=82=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5 =D0=B8 =D0=B4=D0=B8=D1=80=D0=B5=
=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B2=D0=
=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BF=D0=BE =D0=B5=D0=BB=
=D0=B5=D0=BC=D0=B5=D0=BD=D1=82 =D0=BD=D0=B0 =D1=80=D0=B5=D0=B4"
+
+#: gitk:4011
+msgid "Command to generate more commits to include:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B7=D0=B0 =D0=B3=
=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=B4=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F, =D0=BA=D0=
=BE=D0=B8=D1=82=D0=BE =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B2=
=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8:"
+
+#: gitk:4135
+msgid "Gitk: edit view"
+msgstr "Gitk: =D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
+
+#: gitk:4143
+msgid "-- criteria for selecting revisions"
+msgstr "=E2=80=94 =D0=BA=D1=80=D0=B8=D1=82=D0=B5=D1=80=D0=B8=D0=B8 =D0=
=B7=D0=B0 =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D0=B8"
+
+#: gitk:4148
+msgid "View Name"
+msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=
=D0=B4"
+
+#: gitk:4223
+msgid "Apply (F5)"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BB=D0=B0=D0=B3=D0=B0=D0=BD=D0=B5 (F5)"
+
+#: gitk:4261
+msgid "Error in commit selection arguments:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=B0=D1=80=D0=B3=
=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D0=B8=D0=
=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=
=D0=BD=D0=B8=D1=8F:"
+
+#: gitk:4314 gitk:4366 gitk:4827 gitk:4841 gitk:6107 gitk:12184 gitk:1=
2185
+msgid "None"
+msgstr "=D0=9D=D1=8F=D0=BC=D0=B0"
+
+#: gitk:4924 gitk:4929
+msgid "Descendant"
+msgstr "=D0=9D=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=BA"
+
+#: gitk:4925
+msgid "Not descendant"
+msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=
=D0=B8=D0=BA"
+
+#: gitk:4932 gitk:4937
+msgid "Ancestor"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B5=D0=
=BD=D0=B8=D0=BA"
+
+#: gitk:4933
+msgid "Not ancestor"
+msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=
=D1=82=D0=B2=D0=B5=D0=BD=D0=B8=D0=BA"
+
+#: gitk:5223
+msgid "Local changes checked in to index but not committed"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD=D0=B8 =
=D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0, =D0=BD=D0=
=BE =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8"
+
+#: gitk:5259
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 =D0=B8=D0=B7=D0=B2=D1=8A=D0=BD =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: gitk:7032
+msgid "and many more"
+msgstr "=D0=B8 =D0=BE=D1=89=D0=B5 =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
+
+#: gitk:7035
+msgid "many"
+msgstr "=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE"
+
+#: gitk:7222
+msgid "Tags:"
+msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8:"
+
+#: gitk:7239 gitk:7245 gitk:8708
+msgid "Parent"
+msgstr "=D0=A0=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
+
+#: gitk:7250
+msgid "Child"
+msgstr "=D0=94=D0=B5=D1=82=D0=B5"
+
+#: gitk:7259
+msgid "Branch"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD"
+
+#: gitk:7262
+msgid "Follows"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0"
+
+#: gitk:7265
+msgid "Precedes"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0"
+
+#: gitk:7849
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5: %s"
+
+#: gitk:8533
+msgid "Goto:"
+msgstr "=D0=9A=D1=8A=D0=BC =D1=80=D0=B5=D0=B4:"
+
+#: gitk:8554
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "=D0=A1=D1=8A=D0=BA=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=B0=D1=82=D0=
=B0 SHA1 %s =D0=BD=D0=B5 =D0=B5 =D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=
=B0=D1=87=D0=BD=D0=B0"
+
+#: gitk:8561
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D0=B2=D0=
=B5=D1=80=D1=81=D0=B8=D1=8F %s"
+
+#: gitk:8571
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 SHA1 %s=
"
+
+#: gitk:8573
+#, tcl-format
+msgid "Revision %s is not in the current view"
+msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F %s =D0=BD=D0=B5 =D0=B5 =D0=
=B2 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=B8=D0=B7=D0=B3=D0=BB=
=D0=B5=D0=B4"
+
+#: gitk:8715 gitk:8730
+msgid "Date"
+msgstr "=D0=94=D0=B0=D1=82=D0=B0"
+
+#: gitk:8718
+msgid "Children"
+msgstr "=D0=94=D0=B5=D1=86=D0=B0"
+
+#: gitk:8781
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=D1=
=8A=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:8783
+msgid "Detached head: can't reset"
+msgstr "=D0=9D=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD =D0=B2=D1=
=80=D1=8A=D1=85: =D0=BD=D0=B5=D0=B2=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=
=D0=BE =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:8888 gitk:8894
+msgid "Skipping merge commit "
+msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: gitk:8903 gitk:8908
+msgid "Error getting patch ID for "
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=
=D0=BE=D1=80=D0=B0 =D0=BD=D0=B0 "
+
+#: gitk:8904 gitk:8909
+msgid " - stopping\n"
+msgstr " =E2=80=94 =D1=81=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
+
+#: gitk:8914 gitk:8917 gitk:8925 gitk:8939 gitk:8948
+msgid "Commit "
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:8918
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" =D0=B5 =D1=81=D1=8A=D1=89=D0=B0=D1=82=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=
=D0=BA=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE\n"
+"       "
+
+#: gitk:8926
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" =D1=81=D0=B5 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=B0=D0=B2=D0=B0 =
=D0=BE=D1=82\n"
+"       "
+
+#: gitk:8928
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D0=BC=D0=B5=D0=B6=D0=
=B4=D1=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0:\n\n"
+
+#: gitk:8940 gitk:8949
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " =D0=B8=D0=BC=D0=B0 %s =D0=B4=D0=B5=D1=86=D0=B0 =E2=80=94 =D1=81=
=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5\n"
+
+#: gitk:8968
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB: %s"
+
+#: gitk:8974
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D1=87=D0=B8=D1=81=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE=
 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D0=
=BC=D0=B5=D0=B6=D0=B4=D1=83 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B8=D1=8F=D1=82=D0=B0: %s"
+
+#: gitk:9020
+msgid "Top"
+msgstr "=D0=9D=D0=B0=D0=B9-=D0=B3=D0=BE=D1=80=D0=B5"
+
+#: gitk:9021
+msgid "From"
+msgstr "=D0=9E=D1=82"
+
+#: gitk:9026
+msgid "To"
+msgstr "=D0=94=D0=BE"
+
+#: gitk:9050
+msgid "Generate patch"
+msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0"
+
+#: gitk:9052
+msgid "From:"
+msgstr "=D0=9E=D1=82:"
+
+#: gitk:9061
+msgid "To:"
+msgstr "=D0=94=D0=BE:"
+
+#: gitk:9070
+msgid "Reverse"
+msgstr "=D0=9E=D0=B1=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5"
+
+#: gitk:9072 gitk:9268
+msgid "Output file:"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2=D1=
=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0:"
+
+#: gitk:9078
+msgid "Generate"
+msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: gitk:9116
+msgid "Error creating patch:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BA=D1=80=D1=8A=D0=BF=D0=BA=D0=B0:"
+
+#: gitk:9139 gitk:9256 gitk:9313
+msgid "ID:"
+msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80:"
+
+#: gitk:9148
+msgid "Tag name:"
+msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=
=D1=82:"
+
+#: gitk:9151
+msgid "Tag message is optional"
+msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=
=BE =D0=B7=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82 =D0=B5 =D0=BD=D0=B5=
=D0=B7=D0=B0=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=
"
+
+#: gitk:9153
+msgid "Tag message:"
+msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B7=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
+
+#: gitk:9157 gitk:9322
+msgid "Create"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:9175
+msgid "No tag name specified"
+msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=
=D0=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
+
+#: gitk:9179
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D1=8A=D1=82 =E2=80=9E%s=E2=
=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0"
+
+#: gitk:9189
+msgid "Error creating tag:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=
=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82:"
+
+#: gitk:9265
+msgid "Command:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: gitk:9273
+msgid "Write"
+msgstr "Pdmdpldke"
+
+#: gitk:9291
+msgid "Error writing commit:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE:"
+
+#: gitk:9318
+msgid "Name:"
+msgstr "=D0=98=D0=BC=D0=B5:"
+
+#: gitk:9341
+msgid "Please specify a name for the new branch"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =
=D0=B7=D0=B0 =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: gitk:9346
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=B2=
=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=
=D0=B0. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD?"
+
+#: gitk:9413
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=
=8E=D1=87=D0=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=
=9E%s=E2=80=9C =E2=80=94 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=
=B8 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=BE =D0=BE=D1=82=
=D0=BD=D0=BE=D0=B2=D0=BE?"
+
+#: gitk:9418
+msgid "Cherry-picking"
+msgstr "=D0=9E=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: gitk:9427
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5, =D0=B7=D0=B0=D1=89=D0=BE=D1=82=D0=BE=
 =D0=B2=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C=
 =D0=B8=D0=BC=D0=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=
=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8.\n"
+"=D0=9F=D0=BE=D0=B4=D0=B0=D0=B9=D1=82=D0=B5, =D0=B7=D0=B0=D0=BD=D1=83=D0=
=BB=D0=B5=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D0=B3=D0=B8 =D1=81=D0=BA=D0=B0=
=D1=82=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8 =D0=BF=D1=80=D0=BE=D0=B1=D0=B2=D0=
=B0=D0=B9=D1=82=D0=B5 =D0=BE=D1=82=D0=BD=D0=BE=D0=B2=D0=BE."
+
+#: gitk:9433
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =
=D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8=
 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
+
+#: gitk:9449 gitk:9507
+msgid "No changes committed"
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=
=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
+
+#: gitk:9476
+#, tcl-format
+msgid "Commit %s is not included in branch %s -- really revert it?"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=
=B5=D0=BD=D0=BE =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=
=9C. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=BE=D1=82=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE?"
+
+#: gitk:9481
+msgid "Reverting"
+msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0"
+
+#: gitk:9489
+#, tcl-format
+msgid ""
+"Revert failed because of local changes to the following files:%s Plea=
se "
+"commit, reset or stash  your changes and try again."
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=B0 =D0=BE=D1=82=D0=
=BC=D1=8F=D0=BD=D0=B0, =D0=B7=D0=B0=D1=89=D0=BE=D1=82=D0=BE =D0=B2=D1=8A=
=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C =D0=B8=D0=BC=
=D0=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8.\n"
+"=D0=9F=D0=BE=D0=B4=D0=B0=D0=B9=D1=82=D0=B5, =D0=B7=D0=B0=D0=BD=D1=83=D0=
=BB=D0=B5=D1=82=D0=B5 =D0=B8=D0=BB=D0=B8 =D0=B3=D0=B8 =D1=81=D0=BA=D0=B0=
=D1=82=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8 =D0=BF=D1=80=D0=BE=D0=B1=D0=B2=D0=
=B0=D0=B9=D1=82=D0=B5 =D0=BE=D1=82=D0=BD=D0=BE=D0=B2=D0=BE.<"
+
+#: gitk:9493
+msgid ""
+"Revert failed because of merge conflict.\n"
+" Do you wish to run git citool to resolve it?"
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=82=D0=
=BC=D1=8F=D0=BD=D0=B0 =D0=BF=D0=BE=D1=80=D0=B0=D0=B4=D0=B8 =D0=BA=D0=BE=
=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=BF=D1=80=D0=B8 =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"=D0=98=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=B3=
=D0=B8 =D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D1=
=87=D1=80=D0=B5=D0=B7 =E2=80=9Egit citool=E2=80=9C?"
+
+#: gitk:9536
+msgid "Confirm reset"
+msgstr "=D0=9F=D0=BE=D1=82=D0=B2=D1=8A=D1=80=D0=B6=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=
=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: gitk:9538
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D0=B8=
 =D0=BB=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=
=D1=8A=D0=BC =E2=80=9E%s=E2=80=9C?"
+
+#: gitk:9540
+msgid "Reset type:"
+msgstr "=D0=92=D0=B8=D0=B4 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=
=B0=D0=BD=D0=B5:"
+
+#: gitk:9543
+msgid "Soft: Leave working tree and index untouched"
+msgstr "=D0=A1=D0=BB=D0=B0=D0=B1=D0=BE: =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=B8 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0=D1=
=82 =D1=81=D1=8A=D1=89=D0=B8=D1=82=D0=B5"
+
+#: gitk:9546
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr "=D0=A1=D0=BC=D0=B5=D1=81=D0=B5=D0=BD=D0=BE: =D1=80=D0=B0=D0=B1=
=D0=BE=D1=82=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=
=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B0 =D1=81=D1=8A=D1=89=D0=BE=D1=82=D0=BE,=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D1=81=D0=B5 =D0=B7=D0=
=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0"
+
+#: gitk:9549
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"=D0=A1=D0=B8=D0=BB=D0=BD=D0=BE: =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=B8 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=BD=D0=BE=D1=82=D0=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE, =D0=B8 =D0=BD=D0=
=B0 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0\n"
+"(*=D0=92=D0=A1=D0=98=D0=A7=D0=9A=D0=98* =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=
=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D1=89=D0=B5 =D0=
=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B1=D0=B5=D0=B7=D0=B2=D1=8A=D0=B7=D0=B2=D1=
=80=D0=B0=D1=82=D0=BD=D0=BE =D0=B7=D0=B0=D0=B3=D1=83=D0=B1=D0=B5=D0=BD=D0=
=B8)"
+
+#: gitk:9566
+msgid "Resetting"
+msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:9626
+msgid "Checking out"
+msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
+
+#: gitk:9679
+msgid "Cannot delete the currently checked-out branch"
+msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=
=B3=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F=D1=82 =D0=BA=D0=BB=D0=BE=D0=BD =D0=BD=
=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=
=B8=D0=B7=D1=82=D1=80=D0=B8=D1=82"
+
+#: gitk:9685
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BD=D0=
=B5 =D1=81=D0=B0 =D0=BD=D0=B0 =D0=BD=D0=B8=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=
=D1=83=D0=B3 =D0=BA=D0=BB=D0=BE=D0=BD.\n"
+"=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B5 =D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C?"
+
+#: gitk:9716
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=
=D1=80=D1=85=D0=BE=D0=B2=D0=B5: %s"
+
+#: gitk:9731
+msgid "Filter"
+msgstr "=D0=A4=D0=B8=D0=BB=D1=82=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: gitk:10027
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=
=D1=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B3=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0. =D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=B7=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =D0=B8 =D0=BF=D1=80=D0=
=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D1=89=D0=B8=D1=82=D0=B5/=D1=
=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B8=D1=82=D0=B5 =D0=B5=D1=82=D0=
=B8=D0=BA=D0=B5=D1=82=D0=B8 =D1=89=D0=B5 =D0=B5 =D0=BD=D0=B5=D0=BF=D1=8A=
=D0=BB=D0=BD=D0=B0."
+
+#: gitk:11004
+msgid "Tag"
+msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
+
+#: gitk:11008
+msgid "Id"
+msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80"
+
+#: gitk:11091
+msgid "Gitk font chooser"
+msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=
=D1=84=D1=82 =D0=B7=D0=B0 Gitk"
+
+#: gitk:11108
+msgid "B"
+msgstr "=D0=A7"
+
+#: gitk:11111
+msgid "I"
+msgstr "=D0=9A"
+
+#: gitk:11229
+msgid "Commit list display options"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D1=81=D0=BF=D0=B8=D1=81=D1=8A=D0=BA=D0=B0 =D1=81 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F"
+
+#: gitk:11232
+msgid "Maximum graph width (lines)"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (=D0=B2 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5)"
+
+#: gitk:11235
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D1=
=88=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B0=D1=84=D0=B0 (% =D0=BE=D1=82 =D0=BF=D0=B0=D0=BD=D0=B5=D0=BB=D0=B0=
)"
+
+#: gitk:11238
+msgid "Show local changes"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8"
+
+#: gitk:11241
+msgid "Auto-select SHA1 (length)"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=
=BE =D0=B8=D0=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 SHA1 =
(=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D0=BD=D0=B0)"
+
+#: gitk:11245
+msgid "Hide remote refs"
+msgstr "=D0=A1=D0=BA=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=82=D0=B5=
 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8"
+
+#: gitk:11249
+msgid "Diff display options"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =
=D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
+
+#: gitk:11251
+msgid "Tab spacing"
+msgstr "=D0=A8=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =
=D1=82=D0=B0=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D1=80=D0=B0"
+
+#: gitk:11254
+msgid "Display nearby tags/heads"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D1=82=D0=B5 =D0=B5=D1=82=D0=B8=
=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=B2=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=
=B5"
+
+#: gitk:11257
+msgid "Maximum # tags/heads to show"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD =D0=
=B1=D1=80=D0=BE=D0=B9 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8/=D0=B2=
=D1=8A=D1=80=D1=85=D0=BE=D0=B2=D0=B5 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=BA=D0=
=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: gitk:11260
+msgid "Limit diffs to listed paths"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 =D1=81=D0=B0=D0=BC=D0=
=BE =D0=B2 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=
=D1=8A=D1=82=D0=B8=D1=89=D0=B0"
+
+#: gitk:11263
+msgid "Support per-file encodings"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B4=D1=80=D1=8A=D0=B6=D0=BA=D0=B0 =D0=BD=D0=
=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D0=B8 =D0=BA=D0=BE=D0=B4=
=D0=B8=D1=80=D0=B0=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=B2=D1=81=D0=B5=D0=
=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB"
+
+#: gitk:11269 gitk:11416
+msgid "External diff tool"
+msgstr "=D0=92=D1=8A=D0=BD=D1=88=D0=B5=D0=BD =D0=B8=D0=BD=D1=81=D1=82=D1=
=80=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=
=D0=B8=D0=BA=D0=B8"
+
+#: gitk:11270
+msgid "Choose..."
+msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80=E2=80=A6"
+
+#: gitk:11275
+msgid "General options"
+msgstr "=D0=9E=D0=B1=D1=89=D0=B8 =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=
=B9=D0=BA=D0=B8"
+
+#: gitk:11278
+msgid "Use themed widgets"
+msgstr "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=82=D0=B5=D0=BC=D0=B0 =D0=B7=D0=B0 =D0=B3=D1=80=D0=B0=D1=84=
=D0=B8=D1=87=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=
"
+
+#: gitk:11280
+msgid "(change requires restart)"
+msgstr "(=D0=BF=D1=80=D0=BE=D0=BC=D1=8F=D0=BD=D0=B0=D1=82=D0=B0 =D0=B8=
=D0=B7=D0=B8=D1=81=D0=BA=D0=B2=D0=B0 =D1=80=D0=B5=D1=81=D1=82=D0=B0=D1=80=
=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 Gitk)"
+
+#: gitk:11282
+msgid "(currently unavailable)"
+msgstr "(=D0=B2 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BD=D0=B5=
=D0=B4=D0=BE=D1=81=D1=82=D1=8A=D0=BF=D0=BD=D0=BE)"
+
+#: gitk:11293
+msgid "Colors: press to choose"
+msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=D0=B1=
=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=81=D0=
=BA=D0=B0=D0=BD=D0=B5"
+
+#: gitk:11296
+msgid "Interface"
+msgstr "=D0=98=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
+
+#: gitk:11297
+msgid "interface"
+msgstr "=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81"
+
+#: gitk:11300
+msgid "Background"
+msgstr "=D0=A4=D0=BE=D0=BD"
+
+#: gitk:11301 gitk:11331
+msgid "background"
+msgstr "=D0=A4=D0=BE=D0=BD"
+
+#: gitk:11304
+msgid "Foreground"
+msgstr "=D0=97=D0=BD=D0=B0=D1=86=D0=B8"
+
+#: gitk:11305
+msgid "foreground"
+msgstr "=D0=B7=D0=BD=D0=B0=D1=86=D0=B8"
+
+#: gitk:11308
+msgid "Diff: old lines"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11309
+msgid "diff old lines"
+msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D1=81=D1=82=D0=B0=
=D1=80=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11313
+msgid "Diff: new lines"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11314
+msgid "diff new lines"
+msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=BE=D0=B2=
=D0=B8 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11318
+msgid "Diff: hunk header"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0: =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
+
+#: gitk:11320
+msgid "diff hunk header"
+msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0, =D0=BD=D0=B0=D1=87=
=D0=B0=D0=BB=D0=BE =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5"
+
+#: gitk:11324
+msgid "Marked line bg"
+msgstr "=D0=A4=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
+
+#: gitk:11326
+msgid "marked line background"
+msgstr "=D0=A4=D0=BE=D0=BD =D0=BD=D0=B0 =D0=BE=D1=82=D0=B1=D0=B5=D0=BB=
=D1=8F=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=D0=B4"
+
+#: gitk:11330
+msgid "Select bg"
+msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=84=D0=BE=D0=BD=
"
+
+#: gitk:11339
+msgid "Fonts: press to choose"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5: =D0=B8=D0=B7=
=D0=B1=D0=B8=D1=80=D0=B0 =D1=81=D0=B5 =D1=81 =D0=BD=D0=B0=D1=82=D0=B8=D1=
=81=D0=BA=D0=B0=D0=BD=D0=B5"
+
+#: gitk:11341
+msgid "Main font"
+msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD =D1=88=D1=80=D0=B8=D1=
=84=D1=82"
+
+#: gitk:11342
+msgid "Diff display font"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=
=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
+
+#: gitk:11343
+msgid "User interface font"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BD=D0=B0 =D0=B8=D0=BD=D1=82=
=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81=D0=B0"
+
+#: gitk:11365
+msgid "Gitk preferences"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=
=B0 Gitk"
+
+#: gitk:11374
+msgid "General"
+msgstr "=D0=9E=D0=B1=D1=89=D0=B8"
+
+#: gitk:11375
+msgid "Colors"
+msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11376
+msgid "Fonts"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82=D0=BE=D0=B2=D0=B5"
+
+#: gitk:11426
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: =D0=B8=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =D1=86=D0=B2=
=D1=8F=D1=82 =D0=BD=D0=B0 %s"
+
+#: gitk:12080
+msgid "Cannot find a git repository here."
+msgstr "=D0=A2=D1=83=D0=BA =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D1=85=
=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=B0 Git."
+
+#: gitk:12127
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "=D0=9D=D0=B5=D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=B5=D0=BD =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 =E2=80=9E%s=E2=
=80=9C: =D0=B8=D0=BC=D0=B0 =D0=B8 =D1=82=D0=B0=D0=BA=D0=B0=D0=B2=D0=B0 =
=D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F, =D0=B8 =D1=82=D0=B0=D0=BA=D1=8A=D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB"
+
+#: gitk:12139
+msgid "Bad arguments to gitk:"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BD=D0=B0 gitk:"
+
+#: gitk:12242
+msgid "Command line"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B5=D0=BD =D1=80=D0=B5=D0=
=B4"
--=20
1.8.4.2
