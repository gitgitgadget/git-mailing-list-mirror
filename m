From: al_shopov@yahoo.com
Subject: [PATCH 2/3] git-gui i18n: Added Bulgarian translation
Date: Wed, 15 Jan 2014 13:07:56 +0200
Message-ID: <1389784077-8105-3-git-send-email-lists@kambanaria.org>
References: <1389784077-8105-1-git-send-email-lists@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ORQ-0004ud-3l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbaAOLPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 06:15:20 -0500
Received: from nm11-vm7.bullet.mail.ir2.yahoo.com ([212.82.96.168]:36879 "EHLO
	nm11-vm7.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751559AbaAOLPP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:15:15 -0500
Received: from [212.82.98.124] by nm11.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:12 -0000
Received: from [46.228.39.110] by tm17.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:12 -0000
Received: from [127.0.0.1] by smtp147.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389784092; bh=tWEOc5nSHifqN6g7Af/Y96j2ropOPcT4FqsFjRx2qoc=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=nYXWtJQ7c+4KuPqF3d9/+tuejulJuhDoaclrsIDcwfxnnZgPc7QUd7DomB8IAN2UVGVkJ8O17JGJ+jqQbJqhkAyBJLcb64dA44+osB7c/j+z4U9160RFRQiDaQ/9rpgA3Negf+Hfax9LlBv2RymLWU5SB41DxlE1VMdTW2Wz98c=
X-Yahoo-Newman-Id: 31056.73467.bm@smtp147.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp147.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:08:11 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: Sy4xwIgVM1m5knQKr7jDit9rrWWYWsyQhQUtefg_jxPa1xX
 ZLk9xilPiBrhMRE4eL1A6Lr34h9yJbM3h0Ms010oUdKejfPmJ3pZCnA5tJXd
 CFvp0dgqAeI5S9lOF_lRyEdtNpw4Dw5ykR.Xf_W6lpac6WQe7tflMyjxhzXs
 KYHRmGgnxg8bNga3TOUt7DjuBoPwN3iiIISicLBTkYuQd_UI2yjaKw236z91
 xlNe.aF3ntb.M7IR5tEr2x6tuE.mhxiNMDFYO0zM.R0uXQYLv6okO33BOi3X
 _w6nzQ8JYHxF5IHRjhhNDe7xZmSHkMyfjol3JCCbKP2MGsBDiL74PeqEqYb2
 PHR3.SzYryr2AKHqe.tVCHPNtN8pUxLwC74xM_s5fDdZ8bvAe5Lv..YDLwrQ
 y1hbhaZUvt_ClMVY2Zy96YTrH2ON_qfm5pSDLKqI5PG5oXPsNzQQNMys4xZk
 O.tuWEmasiCvpkCOEjRKAl7EJANYI5s4mAX93bJGK0aEA2D8jaOZJLvvgDuU
 uv5bGRGtT5hZ7nmk610b9UVifokOwWtYVUnWS10b0gXTAixykaqO8icY8lH4
 NKp2C.5Tt6.hLxgk4mb2wMhZbRhqvMume48zMRS5T5Rd3G.jyhQh4Y3e7djV
 mZ.TH1jHDZ0Xzrfd7NO5xgLv8AKeU
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1389784077-8105-1-git-send-email-lists@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240457>

=46rom: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 2694 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 2694 insertions(+)
 create mode 100644 po/bg.po

diff --git a/po/bg.po b/po/bg.po
new file mode 100644
index 0000000..89b3a4e
--- /dev/null
+++ b/po/bg.po
@@ -0,0 +1,2694 @@
+# Bulgarian translation of git-gui po-file.
+# Copyright (C) 2012, 2013, 2014 Alexander Shopov <ash@kambanaria.org>=
=2E
+# This file is distributed under the same license as the git package.
+# Alexander Shopov <ash@kambanaria.org>, 2012, 2013, 2014.
+#
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui master\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2014-01-13 20:45+0200\n"
+"PO-Revision-Date: 2014-01-13 21:31+0200\n"
+"Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
+"Language-Team: Bulgarian <dict@fsa-bg.org>\n"
+"Language: bg\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+#: git-gui.sh:859
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D0=B5 =D0=BD=D0=B5=D0=BF=
=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=B5=D0=BD =D1=88=D1=80=D0=B8=D1=84=D1=82=
 =D0=B2 %s:"
+
+#: git-gui.sh:912
+msgid "Main Font"
+msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD =D1=88=D1=80=D0=B8=D1=
=84=D1=82"
+
+#: git-gui.sh:913
+msgid "Diff/Console Font"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=
=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5/=D0=BA=D0=BE=D0=BD=D0=B7=D0=BE=D0=BB=
=D0=B0=D1=82=D0=B0"
+
+#: git-gui.sh:928 git-gui.sh:942 git-gui.sh:955 git-gui.sh:1045
+#: git-gui.sh:1064 git-gui.sh:3115
+msgid "git-gui: fatal error"
+msgstr "git-gui: =D1=84=D0=B0=D1=82=D0=B0=D0=BB=D0=BD=D0=B0 =D0=B3=D1=80=
=D0=B5=D1=88=D0=BA=D0=B0"
+
+#: git-gui.sh:929
+msgid "Cannot find git in PATH."
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 git =D0=
=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B2 =D0=BF=D1=8A=D1=82=D1=8F (PATH=
)."
+
+#: git-gui.sh:956
+msgid "Cannot parse Git version string:"
+msgstr "=D0=9D=D0=B8=D0=B7=D1=8A=D1=82 =D1=81 =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 Git =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=
=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B8=D0=BD=D1=82=D0=B5=D1=
=80=D0=BF=D1=80=D0=B5=D1=82=D0=B8=D1=80=D0=B0=D0=BD:"
+
+#: git-gui.sh:981
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+"=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 Git =D0=
=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5=
 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B0.\n"
+"\n"
+"=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 %s =D0=B8=
=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0, =D1=87=D0=B5 =D0=B5 =E2=80=9E=
%s=E2=80=9C.\n"
+"\n"
+"%s =D0=B8=D0=B7=D0=B8=D1=81=D0=BA=D0=B2=D0=B0 Git, =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8F =D0=BF=D0=BE=D0=BD=D0=B5 1.5.0.\n"
+"\n"
+"=D0=94=D0=B0 =D1=81=D0=B5 =D0=BF=D1=80=D0=B8=D0=B5=D0=BC=D0=B5 =D0=BB=
=D0=B8, =D1=87=D0=B5 =E2=80=9E%s=E2=80=9C =D0=B5 =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D1=8F 1.5.0?\n"
+
+#: git-gui.sh:1278
+msgid "Git directory not found:"
+msgstr "=D0=94=D0=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=
=82=D0=B0 =D0=BD=D0=B0 Git =D0=BD=D0=B5 =D0=B5 =D0=BE=D1=82=D0=BA=D1=80=
=D0=B8=D1=82=D0=B0:"
+
+#: git-gui.sh:1312
+msgid "Cannot move to top of working directory:"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5=
 =D0=BF=D1=80=D0=B5=D0=BC=D0=B8=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =D1=80=D0=
=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=B0=D1=82=D0=B0  =D0=B4=
=D0=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
+
+#: git-gui.sh:1320
+msgid "Cannot use bare repository:"
+msgstr "=D0=93=D0=BE=D0=BB=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=
=B8=D1=89=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D1=81=
=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0:"
+
+#: git-gui.sh:1328
+msgid "No working directory"
+msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=
=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BB=D0=B8=D0=BF=D1=
=81=D0=B2=D0=B0"
+
+#: git-gui.sh:1500 lib/checkout_op.tcl:306
+msgid "Refreshing file status..."
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=81=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D1=82=D0=
=BE =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=E2=80=A6"
+
+#: git-gui.sh:1560
+msgid "Scanning for modified files ..."
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B7=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=BE=D0=B2=D0=B5=E2=80=A6"
+
+#: git-gui.sh:1632
+msgid "Calling prepare-commit-msg hook..."
+msgstr "=D0=9A=D1=83=D0=BA=D0=B0=D1=82=D0=B0 prepare-commit-msg =D1=81=
=D0=B5 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D1=8F=D0=B2=D0=B0 =D0=B2 =D0=
=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=E2=80=A6"
+
+#: git-gui.sh:1649
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=
=B5 =D0=BE=D1=82=D1=85=D0=B2=D1=8A=D1=80=D0=BB=D0=B5=D0=BD=D0=BE =D0=BE=
=D1=82 =D0=BA=D1=83=D0=BA=D0=B0=D1=82=D0=B0 prepare-commit-msg."
+
+#: git-gui.sh:1807 lib/browser.tcl:252
+msgid "Ready."
+msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE."
+
+#: git-gui.sh:1965
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=B0=D0=BC=D0=BE %s =D0=BE=D1=82 %s =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B0."
+
+#: git-gui.sh:2091
+msgid "Unmodified"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD"
+
+#: git-gui.sh:2093
+msgid "Modified, not staged"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD, =D0=BD=D0=BE=
 =D0=BD=D0=B5 =D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: git-gui.sh:2094 git-gui.sh:2106
+msgid "Staged for commit"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2095 git-gui.sh:2107
+msgid "Portions staged for commit"
+msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8 =D1=81=D0=B0 =D0=B2 =D0=B8=D0=BD=
=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2096 git-gui.sh:2108
+msgid "Staged for commit, missing"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BD=D0=BE =D0=BB=D0=
=B8=D0=BF=D1=81=D0=B2=D0=B0"
+
+#: git-gui.sh:2098
+msgid "File type changed, not staged"
+msgstr "=D0=92=D0=B8=D0=B4=D1=8A=D1=82 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=B0 =D0=B5 =D1=81=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD, =D0=BD=D0=BE =
=D0=BD=D0=B5 =D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: git-gui.sh:2099 git-gui.sh:2100
+msgid "File type changed, old type staged for commit"
+msgstr "=D0=92=D0=B8=D0=B4=D1=8A=D1=82 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=B0 =D0=B5 =D1=81=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD, =D0=B2 =D0=B8=
=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B5 =D1=81=D1=82=D0=B0=D1=80=D0=
=B8=D1=8F=D1=82"
+
+#: git-gui.sh:2101
+msgid "File type changed, staged"
+msgstr "=D0=92=D0=B8=D0=B4=D1=8A=D1=82 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=B0 =D0=B5 =D1=81=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B8 =D0=B5 =
=D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: git-gui.sh:2102
+msgid "File type change staged, modification not staged"
+msgstr "=D0=92=D0=B8=D0=B4=D1=8A=D1=82 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=B0 =D0=B5 =D1=81=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD, =D0=BF=D1=80=D0=
=BE=D0=BC=D1=8F=D0=BD=D0=B0=D1=82=D0=B0 =D0=BD=D0=B5 =D0=B5 =D0=B2 =D0=B8=
=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: git-gui.sh:2103
+msgid "File type change staged, file missing"
+msgstr "=D0=92=D0=B8=D0=B4=D1=8A=D1=82 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB=D0=B0 =D0=B5 =D1=81=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD, =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8A=D1=82 =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0"
+
+#: git-gui.sh:2105
+msgid "Untracked, not staged"
+msgstr "=D0=9D=D0=B5=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD"
+
+#: git-gui.sh:2110
+msgid "Missing"
+msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0=D1=89"
+
+#: git-gui.sh:2111
+msgid "Staged for removal"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0=
 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2112
+msgid "Staged for removal, still present"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0=
 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BD=D0=BE =D0=
=BE=D1=89=D0=B5 =D0=B3=D0=BE =D0=B8=D0=BC=D0=B0"
+
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
+msgid "Requires merge resolution"
+msgstr "=D0=98=D0=B7=D0=B8=D1=81=D0=BA=D0=B2=D0=B0 =D0=BA=D0=BE=D1=80=D0=
=B8=D0=B3=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BF=D1=80=D0=B8 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2154
+msgid "Starting gitk... please wait..."
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 gitk=E2=80=A6, =D0=B8=D0=B7=D1=87=D0=B0=D0=BA=D0=B0=D0=B9=D1=82=
=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2166
+msgid "Couldn't find gitk in PATH"
+msgstr "=D0=92 =D0=BF=D1=8A=D1=82=D0=B8=D1=89=D0=B0=D1=82=D0=B0, =D0=BE=
=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B8 =D0=BE=D1=82 =D0=
=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=BB=D0=B8=D0=B2=D0=B0=D1=82=D0=B0 P=
ATH, =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=
=D0=BD=D0=B8=D0=BC gitk"
+
+#: git-gui.sh:2225
+msgid "Couldn't find git gui in PATH"
+msgstr "=D0=92 =D0=BF=D1=8A=D1=82=D0=B8=D1=89=D0=B0=D1=82=D0=B0, =D0=BE=
=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B8 =D0=BE=D1=82 =D0=
=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=BB=D0=B8=D0=B2=D0=B0=D1=82=D0=B0 P=
ATH, =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=
=D0=BD=D0=B8=D0=BC git gui"
+
+#: git-gui.sh:2644 lib/choose_repository.tcl:40
+msgid "Repository"
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: git-gui.sh:2645
+msgid "Edit"
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5"
+
+#: git-gui.sh:2647 lib/choose_rev.tcl:567
+msgid "Branch"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD"
+
+#: git-gui.sh:2650 lib/choose_rev.tcl:554
+msgid "Commit@@noun"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2653 lib/merge.tcl:123 lib/merge.tcl:152 lib/merge.tcl:1=
70
+msgid "Merge"
+msgstr "=D0=A1=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2654 lib/choose_rev.tcl:563
+msgid "Remote"
+msgstr "=D0=9E=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=
=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: git-gui.sh:2657
+msgid "Tools"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B8"
+
+#: git-gui.sh:2666
+msgid "Explore Working Copy"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=BE=D1=82=D0=BE=
 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B5"
+
+#: git-gui.sh:2672
+msgid "Git Bash"
+msgstr "Bash =D0=BD=D0=B0 Git"
+
+#: git-gui.sh:2682
+msgid "Browse Current Branch's Files"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5=
 =D0=B2 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=
=BD"
+
+#: git-gui.sh:2686
+msgid "Browse Branch Files..."
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=BA=D0=BB=
=D0=BE=D0=BD"
+
+#: git-gui.sh:2691
+msgid "Visualize Current Branch's History"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=BA=D0=
=BB=D0=BE=D0=BD"
+
+#: git-gui.sh:2695
+msgid "Visualize All Branch History"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=BD=D0=B0 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BA=D0=BB=D0=
=BE=D0=BD=D0=BE=D0=B2=D0=B5"
+
+#: git-gui.sh:2702
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5=
 =D0=B2 %s"
+
+#: git-gui.sh:2704
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=BD=D0=B0 %s"
+
+#: git-gui.sh:2709 lib/database.tcl:40 lib/database.tcl:66
+msgid "Database Statistics"
+msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82 =D0=B4=D0=B0=
=D0=BD=D0=BD=D0=B8"
+
+#: git-gui.sh:2712 lib/database.tcl:33
+msgid "Compress Database"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82=
 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8"
+
+#: git-gui.sh:2715
+msgid "Verify Database"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =
=D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=B8"
+
+#: git-gui.sh:2722 git-gui.sh:2726 git-gui.sh:2730 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+msgid "Create Desktop Icon"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B8=D0=BA=D0=BE=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=
=82=D0=BD=D0=B8=D1=8F =D0=BF=D0=BB=D0=BE=D1=82"
+
+#: git-gui.sh:2738 lib/choose_repository.tcl:192 lib/choose_repository=
=2Etcl:200
+msgid "Quit"
+msgstr "=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
+
+#: git-gui.sh:2746
+msgid "Undo"
+msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0"
+
+#: git-gui.sh:2749
+msgid "Redo"
+msgstr "=D0=9F=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B5=D0=BD=D0=B8=D0=B5"
+
+#: git-gui.sh:2753 git-gui.sh:3348
+msgid "Cut"
+msgstr "=D0=9E=D1=82=D1=80=D1=8F=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2756 git-gui.sh:3351 git-gui.sh:3425 git-gui.sh:3510
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2759 git-gui.sh:3354
+msgid "Paste"
+msgstr "=D0=9F=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#: git-gui.sh:2762 git-gui.sh:3357 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
+msgid "Delete"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2766 git-gui.sh:3361 git-gui.sh:3514 lib/console.tcl:71
+msgid "Select All"
+msgstr "=D0=98=D0=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=BE"
+
+#: git-gui.sh:2775
+msgid "Create..."
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6=
"
+
+#: git-gui.sh:2781
+msgid "Checkout..."
+msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5=E2=80=A6=
"
+
+#: git-gui.sh:2787
+msgid "Rename..."
+msgstr "=D0=9F=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D1=83=D0=B2=D0=B0=D0=
=BD=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2792
+msgid "Delete..."
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6=
"
+
+#: git-gui.sh:2797
+msgid "Reset..."
+msgstr "=D0=9E=D1=82=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2807
+msgid "Done"
+msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE"
+
+#: git-gui.sh:2809
+msgid "Commit@@verb"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2818 git-gui.sh:3289
+msgid "New Commit"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2826 git-gui.sh:3296
+msgid "Amend Last Commit"
+msgstr "=D0=9F=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2836 git-gui.sh:3250 lib/remote_branch_delete.tcl:101
+msgid "Rescan"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2842
+msgid "Stage To Commit"
+msgstr "=D0=9A=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =
=D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2848
+msgid "Stage Changed Files To Commit"
+msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =
=D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2854
+msgid "Unstage From Commit"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B0=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BE=D1=
=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2860 lib/index.tcl:442
+msgid "Revert Changes"
+msgstr "=D0=92=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=
=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=B0"
+
+#: git-gui.sh:2868 git-gui.sh:3561 git-gui.sh:3592
+msgid "Show Less Context"
+msgstr "=D0=9F=D0=BE-=D0=BC=D0=B0=D0=BB=D0=BA=D0=BE =D0=BA=D0=BE=D0=BD=
=D1=82=D0=B5=D0=BA=D1=81=D1=82"
+
+#: git-gui.sh:2872 git-gui.sh:3565 git-gui.sh:3596
+msgid "Show More Context"
+msgstr "=D0=9F=D0=BE=D0=B2=D0=B5=D1=87=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82"
+
+#: git-gui.sh:2879 git-gui.sh:3263 git-gui.sh:3372
+msgid "Sign Off"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:2895
+msgid "Local Merge..."
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=BE =D1=81=D0=BB=D0=B8=D0=
=B2=D0=B0=D0=BD=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2900
+msgid "Abort Merge..."
+msgstr "=D0=9F=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=
=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=
=D0=BD=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2912 git-gui.sh:2940
+msgid "Add..."
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5=E2=80=A6"
+
+#: git-gui.sh:2916
+msgid "Push..."
+msgstr "=D0=98=D0=B7=D0=B1=D1=83=D1=82=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6=
"
+
+#: git-gui.sh:2920
+msgid "Delete Branch..."
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BB=D0=BE=D0=BD=E2=80=A6"
+
+#: git-gui.sh:2930 git-gui.sh:3543
+msgid "Options..."
+msgstr "=D0=9E=D0=BF=D1=86=D0=B8=D0=B8=E2=80=A6"
+
+#: git-gui.sh:2941
+msgid "Remove..."
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D0=BD=D0=B5=E2=
=80=A6"
+
+#: git-gui.sh:2950 lib/choose_repository.tcl:54
+msgid "Help"
+msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89"
+
+#: git-gui.sh:2954 git-gui.sh:2958 lib/choose_repository.tcl:48
+#: lib/choose_repository.tcl:57 lib/about.tcl:14
+#, tcl-format
+msgid "About %s"
+msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE %s"
+
+#: git-gui.sh:2982
+msgid "Online Documentation"
+msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=98=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82"
+
+#: git-gui.sh:2985 lib/choose_repository.tcl:51 lib/choose_repository.=
tcl:60
+msgid "Show SSH Key"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BB=D1=8E=D1=87=D0=B0 =D0=B7=D0=B0 SSH"
+
+#: git-gui.sh:3004 git-gui.sh:3136
+msgid "Usage"
+msgstr "=D0=A3=D0=BF=D0=BE=D1=82=D1=80=D0=B5=D0=B1=D0=B0"
+
+#: git-gui.sh:3085 lib/blame.tcl:573
+msgid "Error"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0"
+
+#: git-gui.sh:3116
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr ""
+"=D1=84=D0=B0=D1=82=D0=B0=D0=BB=D0=BD=D0=BE: =D0=BF=D1=8A=D1=82=D1=8F=D1=
=82 %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=
=B4=D0=B5 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D1=82: =D1=82=D0=B0=D0=BA=D1=8A=
=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB =D0=B8=D0=BB=D0=B8 =D0=B4=D0=B8=D1=80=D0=
=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D1=8F=D0=BC=D0=B0"
+
+#: git-gui.sh:3149
+msgid "Current Branch:"
+msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89 =D0=BA=D0=BB=D0=BE=D0=BD:"
+
+#: git-gui.sh:3175
+msgid "Staged Changes (Will Commit)"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=B2 =D0=B8=D0=BD=
=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 (=D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5)"
+
+#: git-gui.sh:3195
+msgid "Unstaged Changes"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=B8=D0=B7=D0=B2=D1=
=8A=D0=BD =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: git-gui.sh:3256
+msgid "Stage Changed"
+msgstr "=D0=98=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D0=B5 =D0=BF=
=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD"
+
+#: git-gui.sh:3275 lib/transport.tcl:137 lib/transport.tcl:229
+msgid "Push"
+msgstr "=D0=98=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5"
+
+#: git-gui.sh:3310
+msgid "Initial Commit Message:"
+msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BD=D0=BE =D1=81=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=
=D1=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3311
+msgid "Amended Commit Message:"
+msgstr "=D0=9F=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B5=D0=BD=D0=BE =D1=81=D1=
=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3312
+msgid "Amended Initial Commit Message:"
+msgstr "=D0=9F=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B5=D0=BD=D0=BE =D0=BF=D1=
=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BD=D0=BE =D1=81=D1=
=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3313
+msgid "Amended Merge Commit Message:"
+msgstr "=D0=9F=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B5=D0=BD=D0=BE =D1=81=D1=
=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D1=81=D1=8A=D1=81 =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3314
+msgid "Merge Commit Message:"
+msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D1=81=D1=8A=
=D1=81 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3315
+msgid "Commit Message:"
+msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: git-gui.sh:3364 git-gui.sh:3518 lib/console.tcl:73
+msgid "Copy All"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=BE"
+
+#: git-gui.sh:3388 lib/blame.tcl:105
+msgid "File:"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
+
+#: git-gui.sh:3506
+msgid "Refresh"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3527
+msgid "Decrease Font Size"
+msgstr "=D0=9F=D0=BE-=D0=B5=D0=B4=D1=8A=D1=80 =D1=88=D1=80=D0=B8=D1=84=
=D1=82"
+
+#: git-gui.sh:3531
+msgid "Increase Font Size"
+msgstr "=D0=9F=D0=BE-=D0=B4=D1=80=D0=B5=D0=B1=D0=B5=D0=BD =D1=88=D1=80=
=D0=B8=D1=84=D1=82"
+
+#: git-gui.sh:3539 lib/blame.tcl:294
+msgid "Encoding"
+msgstr "=D0=9A=D0=BE=D0=B4=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3550
+msgid "Apply/Reverse Hunk"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BB=D0=B0=D0=B3=D0=B0=D0=BD=D0=B5/=D0=B2=D1=
=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D0=B0=D1=80=D1=87=
=D0=B5"
+
+#: git-gui.sh:3555
+msgid "Apply/Reverse Line"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BB=D0=B0=D0=B3=D0=B0=D0=BD=D0=B5/=D0=B2=D1=
=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=80=D0=B5=D0=B4"
+
+#: git-gui.sh:3574
+msgid "Run Merge Tool"
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =
=D0=B7=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3579
+msgid "Use Remote Version"
+msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BE=D1=82 =D0=BE=D1=82=
=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE=D1=82=D0=BE =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: git-gui.sh:3583
+msgid "Use Local Version"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8F"
+
+#: git-gui.sh:3587
+msgid "Revert To Base"
+msgstr "=D0=92=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =
=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=B0=D1=82=D0=B0=
 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#: git-gui.sh:3605
+msgid "Visualize These Changes In The Submodule"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=
=D1=82=D0=B5 =D0=B2 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=
=B0"
+
+#: git-gui.sh:3609
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D1=8F =D0=BA=D0=
=BB=D0=BE=D0=BD =D0=B2 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=
=B0"
+
+#: git-gui.sh:3613
+msgid "Visualize All Branch History In The Submodule"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=BD=D0=B0 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BA=D0=BB=D0=
=BE=D0=BD=D0=B8 =D0=B2 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=
=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=
=B0"
+
+#: git-gui.sh:3618
+msgid "Start git gui In The Submodule"
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui=E2=80=9C =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=BC=
=D0=BE=D0=B4=D1=83=D0=BB=D0=B0"
+
+#: git-gui.sh:3653
+msgid "Unstage Hunk From Commit"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B0=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D0=B0=D1=80=D1=87=D0=B5=D1=82=D0=BE =D0=BE=D1=82 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: git-gui.sh:3655
+msgid "Unstage Lines From Commit"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B0=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5=D1=82=D0=B5 =D0=BE=D1=82 =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: git-gui.sh:3657
+msgid "Unstage Line From Commit"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B0=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=B5=D0=B4=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=
=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+
+#: git-gui.sh:3660
+msgid "Stage Hunk For Commit"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BF=D0=B0=D1=80=D1=87=D0=B5=D1=82=D0=BE =D0=B7=D0=B0 =D0=BF=D0=BE=D0=
=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3662
+msgid "Stage Lines For Commit"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5=D1=82=D0=B5 =D0=B7=D0=B0 =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3664
+msgid "Stage Line For Commit"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=80=D0=B5=D0=B4=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=
=B0=D0=BD=D0=B5"
+
+#: git-gui.sh:3689
+msgid "Initializing..."
+msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=
=80=D0=B0=D0=BD=D0=B5=E2=80=A6"
+
+#: git-gui.sh:3832
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+"=D0=92=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B5 =D0=B4=D0=B0 =
=D0=B8=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC =D1=81=D1=
=8A=D1=81 =D1=81=D1=80=D0=B5=D0=B4=D0=B0=D1=82=D0=B0.\n"
+"\n"
+"=D0=9D=D0=B0=D0=B9-=D0=B2=D0=B5=D1=80=D0=BE=D1=8F=D1=82=D0=BD=D0=BE =D1=
=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=
=B5=D0=BD=D0=BB=D0=B8=D0=B2=D0=B8 =D0=BD=D1=8F=D0=BC=D0=B0 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82\n"
+"=D0=B2=D0=B7=D0=B5=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4 =D0=B2=D0=BD=D0=B8=D0=
=BC=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=BF=D1=80=
=D0=BE=D1=86=D0=B5=D1=81=D0=B8=D1=82=D0=B5 Git =D0=B8=D0=B7=D0=BF=D1=8A=
=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8\n"
+"=D0=BE=D1=82 %s:\n"
+"\n"
+
+#: git-gui.sh:3861
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+"\n"
+"=D0=A2=D0=BE=D0=B2=D0=B0 =D0=B5 =D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82 =
=D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC =D0=B8 =D1=81=D0=B5 =D0=B4=D1=
=8A=D0=BB=D0=B6=D0=B8 =D0=BD=D0=B0\n"
+"=D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 Tcl =D0=
=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B0 =D0=B2 Cygwin."
+
+#: git-gui.sh:3866
+#, tcl-format
+msgid ""
+"\n"
+"\n"
+"A good replacement for %s\n"
+"is placing values for the user.name and\n"
+"user.email settings into your personal\n"
+"~/.gitconfig file.\n"
+msgstr ""
+"\n"
+"\n"
+"=D0=94=D0=BE=D0=B1=D1=8A=D1=80 =D0=B7=D0=B0=D0=BC=D0=B5=D1=81=D1=82=D0=
=B8=D1=82=D0=B5=D0=BB =D0=BD=D0=B0 %s\n"
+"=D0=B5 =D0=B4=D0=B0 =D0=BF=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D0=
=B5 =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5 =
user.name =D0=B8\n"
+"user.email =D0=B2 =D0=BB=D0=B8=D1=87=D0=BD=D0=B8=D1=8F =D1=81=D0=B8 =D1=
=84=D0=B0=D0=B9=D0=BB ~/.gitconfig.\n"
+
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "=D0=A2=D0=B0=D0=B7=D0=B8 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=B0 =D0=B7=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0=
 =D0=BD=D0=B0 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0 =D0=
=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=
"
+
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "=D0=9B=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=
=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=
=81=D0=B0"
+
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D0=
=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0"
+
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "=D0=9F=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=80=D0=B5=D1=87=D0=BD=D0=B8=D0=BA =D0=B7=D0=B0 =D0=B5=D0=B7=D0=B8=D0=
=BA =E2=80=9E%s=E2=80=9C."
+
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=
=B7=D0=B0 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81 =D0=B4=D0=B0=
=D0=B6=D0=B5 =D0=BD=D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=
=B0 =D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE."
+
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0 =D0=BF=D1=80=D0=BE=
=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=BF=D1=80=D0=B0=D0=B2=D0=
=BE=D0=BF=D0=B8=D1=81=D0=B0"
+
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D1=80=D0=B5=D0=B4=D0=BB=D0=BE=D0=
=B6=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "=D0=9D=D0=B5=D0=BE=D1=87=D0=B0=D0=BA=D0=B2=D0=B0=D0=BD =D0=BA=D1=
=80=D0=B0=D0=B9 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB =D0=BE=D1=82 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D0=
=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=BF=D1=80=
=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0"
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=BF=D1=80=D0=BE=
=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D0=BF=D1=80=D0=
=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0"
+
+#: lib/remote_add.tcl:20
+msgid "Add Remote"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#: lib/remote_add.tcl:34 lib/browser.tcl:292 lib/branch_checkout.tcl:3=
0
+#: lib/transport.tcl:141 lib/branch_rename.tcl:32 lib/choose_font.tcl:=
45
+#: lib/option.tcl:127 lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202
+#: lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/checkout_op.tcl:579 lib/branch_create.tcl:37 lib/branch_delete.=
tcl:34
+#: lib/merge.tcl:174
+msgid "Cancel"
+msgstr "=D0=9E=D1=82=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "=D0=94=D0=B0=D0=BD=D0=BD=D0=B8 =D0=B7=D0=B0 =D0=BE=D1=82=D0=B4=
=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE=D1=82=D0=BE =D1=85=D1=80=D0=B0=
=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "=D0=98=D0=BC=D0=B5:"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "=D0=9C=D0=B5=D1=81=D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=
=B5=D0=BD=D0=B8=D0=B5:"
+
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=BE =D0=B4=D0=B5=D0=
=B9=D1=81=D1=82=D0=B2=D0=B8=D0=B5"
+
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "=D0=9D=D0=B5=D0=B7=D0=B0=D0=B1=D0=B0=D0=B2=D0=BD=D0=BE =D0=B4=D0=
=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=
=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=
=D1=87=D0=B5=D0=BD=D0=BE=D1=82=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=
=D0=B8=D1=89=D0=B5 =D0=B8 =D0=B8=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=
=D0=B8=D1=82=D0=B5"
+
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "=D0=94=D0=B0 =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=B8 =D0=BD=D0=B8=D1=89=D0=BE"
+
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "=D0=97=D0=B0=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =
=D0=B7=D0=B0 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE=
=D1=82=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5."
+
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "=D0=9E=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=
=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=B5 =D0=BC=
=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BA=D0=B0=D0=B7=D0=B2=D0=
=B0 =E2=80=9E%s=E2=80=9C."
+
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B4=D0=
=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D1=82=D0=B4=
=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE=D1=82=D0=BE =D1=85=D1=80=D0=B0=
=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =E2=80=9E%s=E2=80=9C =D0=BE=D1=82 =
=D0=B0=D0=B4=D1=80=D0=B5=D1=81 =E2=80=9E%s=E2=80=9C."
+
+#: lib/remote_add.tcl:132 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C"
+
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "=D0=94=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C"
+
+#: lib/remote_add.tcl:156
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=
=BE =D1=81 =D0=BC=D0=B5=D1=81=D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=
=D0=B5=D0=BD=D0=B8=D0=B5 =E2=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=
=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B8=D0=BD=D0=B8=D1=
=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=B0=D0=BD=D0=BE."
+
+#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
+#: lib/transport.tcl:110
+#, tcl-format
+msgid "push %s"
+msgstr "=D0=B8=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C"
+
+#: lib/remote_add.tcl:163
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =E2=80=9E%s=E2=80=
=9C (=D1=81 =D0=B0=D0=B4=D1=80=D0=B5=D1=81 =E2=80=9E%s=E2=80=9C)"
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=E2=
=80=A6"
+
+#: lib/browser.tcl:27
+msgid "File Browser"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B1=D1=80=D0=B0=D1=83=D0=
=B7=D1=8A=D1=80"
+
+#: lib/browser.tcl:132 lib/browser.tcl:149
+#, tcl-format
+msgid "Loading %s..."
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C=E2=80=A6"
+
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[=D0=9A=D1=8A=D0=BC =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=
=D1=8F]"
+
+#: lib/browser.tcl:275 lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5=
 =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0"
+
+#: lib/browser.tcl:288 lib/choose_repository.tcl:406
+#: lib/choose_repository.tcl:493 lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:1029
+msgid "Browse"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=
=B5"
+
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:32=
1
+msgid "Revision"
+msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "=D0=97=D0=B0 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D1=82=D1=80=D1=
=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B8=D0=B7=D0=B1=D0=B5=D1=80=D0=B5=
=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB."
+
+#: lib/tools.tcl:91
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "=D0=A1=D0=B8=D0=B3=D1=83=D1=80=D0=BD=D0=B8 =D0=BB=D0=B8 =D1=81=
=D1=82=D0=B5, =D1=87=D0=B5 =D0=B8=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=B4=D0=
=B0 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =E2=80=
=9E%1$s=E2=80=9C =D0=B2=D1=8A=D1=80=D1=85=D1=83 =E2=80=9E%2$s=E2=80=9C?=
"
+
+#: lib/tools.tcl:95
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=D0=A1=D0=B8=D0=B3=D1=83=D1=80=D0=BD=D0=B8 =D0=BB=D0=B8 =D1=81=
=D1=82=D0=B5, =D1=87=D0=B5 =D0=B8=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=B4=D0=
=B0 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =E2=80=
=9E%s=E2=80=9C?"
+
+#: lib/tools.tcl:116
+#, tcl-format
+msgid "Tool: %s"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0: %s"
+
+#: lib/tools.tcl:117
+#, tcl-format
+msgid "Running: %s"
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5: =
%s"
+
+#: lib/tools.tcl:155
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =D0=B7=D0=
=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8 =D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=
=BE: %s"
+
+#: lib/tools.tcl:157
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =D0=B2=D1=
=8A=D1=80=D0=BD=D0=B0 =D0=B3=D1=80=D0=B5=D1=88=D0=BA=D0=B0: %s"
+
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD =D0=B7=D0=B0 =D0=B8=D0=B7=D1=82=D0=B5=
=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
+
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
+
+#: lib/branch_checkout.tcl:39 lib/option.tcl:309 lib/branch_create.tcl=
:69
+msgid "Options"
+msgstr "=D0=9E=D0=BF=D1=86=D0=B8=D0=B8"
+
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "=D0=98=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D1=82=
 =D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=
=BD"
+
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BE=D1=
=82 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=
=D0=BD"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "=D0=94=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D1=82=
 %s"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "=D0=BE=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=
=D0=BE=D0=BD=D0=B8 =D0=BA=D1=8A=D0=BC =E2=80=9E%s=E2=80=9C"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "=D0=9E=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=
=D0=BE=D0=BD=D0=B8 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D1=82=D0=
=B8=D1=82=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8 =D0=BE=D1=82 =E2=80=9E%s=
=E2=80=9C"
+
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=
=D0=BB=D0=B8=D1=89=D0=B0"
+
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "=D0=94=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D1=82=
 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=
=B5=D1=87=D0=B5=D0=BD=D0=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=
=89=D0=B0"
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "=D0=BE=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=
 =D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8 =D0=B8=D0=B7=D1=82=D1=80=D0=
=B8=D1=82=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8"
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr ""
+"=D0=9E=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=
=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=D0=BE=D0=
=BD=D0=B8 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D1=82=D0=B8=D1=82=
=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8 =D0=BE=D1=82 =D0=B2=D1=81=D0=B8=D1=
=87=D0=BA=D0=B8 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=
=B8 "
+"=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0"
+
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "=D0=98=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5=
 =D0=BA=D1=8A=D0=BC %s"
+
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "=D0=98=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=BE =D0=BA=D1=8A=D0=BC=
 =E2=80=9E%s=E2=80=9C"
+
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "=D0=98=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 %s %s =D0=BA=D1=8A=D0=BC %s"
+
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8 =D0=B7=D0=B0 =D0=B8=D0=B7=D1=82=
=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8-=D0=B8=D0=B7=D1=82=D0=BE=D1=87=D0=
=BD=D0=B8=D1=86=D0=B8"
+
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "=D0=A6=D0=B5=D0=BB=D0=B5=D0=B2=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=
=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "=D0=9E=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=
=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5:"
+
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=BB=D0=BD=D0=BE =D0=
=BC=D0=B5=D1=81=D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=
=B8=D0=B5:"
+
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BF=D1=
=80=D0=B8 =D0=BF=D1=80=D0=B5=D0=BD=D0=B0=D1=81=D1=8F=D0=BD=D0=B5=D1=82=D0=
=BE"
+
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr ""
+"=D0=98=D0=B7=D1=80=D0=B8=D1=87=D0=BD=D0=BE =D0=BF=D1=80=D0=B5=D0=B7=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=81=D1=8A=
=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0=D1=89 =D0=BA=D0=BB=D0=BE=
=D0=BD (=D0=BD=D1=8F=D0=BA=D0=BE=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=
=BD=D0=B8 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=
=D1=82 "
+"=D0=B7=D0=B0=D0=B3=D1=83=D0=B1=D0=B5=D0=BD=D0=B8)"
+
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=BD=D0=B0 =D0=
=BA=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=8F (=D0=B7=D0=B0 =D0=B1=
=D0=B0=D0=B2=D0=BD=D0=B8 =D0=BC=D1=80=D0=B5=D0=B6=D0=BE=D0=B2=D0=B8 =D0=
=B2=D1=80=D1=8A=D0=B7=D0=BA=D0=B8)"
+
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8=D1=82=D0=B5"
+
+#: lib/status_bar.tcl:87
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s=E2=80=A6 %*i =D0=BE=D1=82 =D0=BE=D0=B1=D1=89=D0=BE %*i %s (=
%3i%%)"
+
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "=D0=98=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BA=D1=8A=D0=BC"
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =
=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "=D0=9E=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BE=D1=
=82"
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "=D0=94=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BE=D1=
=82"
+
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B0 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D1=82=
=D0=B8 =D0=BA=D0=BB=D1=8E=D1=87=D0=BE=D0=B2=D0=B5."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "=D0=9E=D1=82=D0=BA=D1=80=D0=B8=D1=82 =D0=B5 =D0=BF=D1=83=D0=B1=
=D0=BB=D0=B8=D1=87=D0=B5=D0=BD =D0=BA=D0=BB=D1=8E=D1=87 =D0=B2 =E2=80=9E=
%s=E2=80=9C"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BB=D1=8E=D1=87"
+
+#: lib/sshkey.tcl:55 lib/checkout_op.tcl:146 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "=D0=97=D0=B0=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5"
+
+#: lib/sshkey.tcl:58
+msgid "Copy To Clipboard"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=
=BC =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D0=B8=D1=8F =D0=B1=D1=83=
=D1=84=D0=B5=D1=80"
+
+#: lib/sshkey.tcl:72
+msgid "Your OpenSSH Public Key"
+msgstr "=D0=9F=D1=83=D0=B1=D0=BB=D0=B8=D1=87=D0=BD=D0=B8=D1=8F=D1=82 =D0=
=B2=D0=B8 =D0=BA=D0=BB=D1=8E=D1=87 =D0=B7=D0=B0 OpenSSH"
+
+#: lib/sshkey.tcl:80
+msgid "Generating..."
+msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=E2=
=80=A6"
+
+#: lib/sshkey.tcl:86
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =E2=80=9E=
ssh-keygen=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =
=D0=B1=D1=8A=D0=B4=D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=
=D0=BD=D0=B0:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:113
+msgid "Generation failed."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B3=D0=
=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5."
+
+#: lib/sshkey.tcl:120
+msgid "Generation succeeded, but no keys found."
+msgstr "=D0=93=D0=B5=D0=BD=D0=B5=D1=80=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE =D0=B7=D0=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8 =D1=83=D1=81=D0=BF=
=D0=B5=D1=88=D0=BD=D0=BE, =D0=B0 =D0=BD=D0=B5 =D1=81=D0=B0 =D0=BD=D0=B0=
=D0=BC=D0=B5=D1=80=D0=B5=D0=BD=D0=B8 =D0=BA=D0=BB=D1=8E=D1=87=D0=BE=D0=B2=
=D0=B5."
+
+#: lib/sshkey.tcl:123
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "=D0=9A=D0=BB=D1=8E=D1=87=D1=8A=D1=82 =D0=B2=D0=B8 =D0=B5 =D0=B2=
 =E2=80=9E%s=E2=80=9C"
+
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D1=83=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D1=83=D0=B2=D0=B0=D0=
=BD=D0=B5"
+
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD:"
+
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "=D0=9D=D0=BE=D0=B2=D0=BE =D0=B8=D0=BC=D0=B5:"
+
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "=D0=98=D0=B7=D0=B1=D0=B5=D1=80=D0=B5=D1=82=D0=B5 =D0=BA=D0=BB=D0=
=BE=D0=BD =D0=B7=D0=B0 =D0=BF=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D1=83=
=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "=D0=94=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =D0=BD=D0=B0=
 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0."
+
+#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=B2=
=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=
=D0=B0."
+
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "=E2=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=
 =D0=B7=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD.=
"
+
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D1=
=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D1=83=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80"
+
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80"
+
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "=D0=9C=D0=BE=D1=81=D1=82=D1=80=D0=B0"
+
+#: lib/choose_font.tcl:105
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"=D0=A2=D0=BE=D0=B2=D0=B0 =D0=B5 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=D0=
=B5=D0=BD =D1=82=D0=B5=D0=BA=D1=81=D1=82.\n"
+"=D0=90=D0=BA=D0=BE =D0=B2=D0=B8 =D1=85=D0=B0=D1=80=D0=B5=D1=81=D0=B2=D0=
=B0 =D0=BA=D0=B0=D0=BA =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0=
, =D0=B8=D0=B7=D0=B1=D0=B5=D1=80=D0=B5=D1=82=D0=B5 =D1=82=D0=BE=D0=B7=D0=
=B8 =D1=88=D1=80=D0=B8=D1=84=D1=82."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=BE =D0=
=B3=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=D0=BD=D0=BE =D0=BA=D0=BE=D0=B4=D0=B8=D1=
=80=D0=B0=D0=BD=D0=B5 =E2=80=9E%s=E2=80=9C"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=BE =D0=
=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =E2=80=9E%s=E2=80=9C =D0=BD=
=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE=
"
+
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D0=B8 =D0=
=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
+
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/option.tcl:133
+#, tcl-format
+msgid "%s Repository"
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =E2=80=9E=
%s=E2=80=9C"
+
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "=D0=93=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=D0=BD=D0=BE (=D0=B7=D0=B0=
 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=
=BB=D0=B8=D1=89=D0=B0)"
+
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "=D0=9F=D0=BE=D1=82=D1=80=D0=B5=D0=B1=D0=B8=D1=82=D0=B5=D0=BB=D1=
=81=D0=BA=D0=BE =D0=B8=D0=BC=D0=B5"
+
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81 =D0=BD=D0=B0 =D0=B5-=D0=BF=D0=BE=
=D1=89=D0=B0"
+
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "=D0=9E=D0=B1=D0=BE=D0=B1=D1=89=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=
=B0 =D0=BF=D1=80=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=80=D0=BE=D0=B1=D0=BD=D0=BE=D1=81=D1=82=D0=
=B8 =D0=BF=D1=80=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=
=D1=82=D0=B0"
+
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D1=81=
=D0=BB=D0=B5=D0=B4 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=
=D0=B0"
+
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0=
 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "=D0=94=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D0=B5 =D0=B2=D1=8A=D0=B2 =
=D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BF=D1=80=D0=
=BE=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=
=D0=B2=D0=B5=D1=82=D0=B5"
+
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "=D0=9E=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=
=D0=BE=D0=BD=D0=BE=D0=B2=D0=B5 =D0=BF=D1=80=D0=B8 =D0=B4=D0=BE=D1=81=D1=
=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "=D0=9D=D0=B0=D0=BF=D0=B0=D1=81=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=
=D0=BE=D0=BD=D0=BE=D0=B2=D0=B5"
+
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Etextconv=E2=80=9C =D0=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=
=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D0=B8 =D0=B0=D0=BD=D0=BE=D1=82=D0=B0=
=D1=86=D0=B8=D0=B8=D1=82=D0=B5"
+
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B5=D1=82=D0=BE =D1=81=D0=B0=D0=BC=D0=BE=
 =D0=BF=D0=BE =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5"
+
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD =D0=
=B1=D1=80=D0=BE=D0=B9 =D1=81=D0=BA=D0=BE=D1=80=D0=BE =D0=BF=D0=BE=D0=BB=
=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=
=D1=89=D0=B0"
+
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "=D0=9C=D0=B8=D0=BD=D0=B8=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD =D0=B1=D1=
=80=D0=BE=D0=B9 =D0=B7=D0=BD=D0=B0=D1=86=D0=B8 =D0=B7=D0=B0 =D0=B0=D0=BD=
=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BF=D0=B8=D0=B5=D1=82=D0=BE"
+
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=
=B8 =D0=BE=D0=B1=D1=85=D0=B2=D0=B0=D1=82 =D0=B7=D0=B0 =D0=B0=D0=BD=D0=BE=
=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=B2 =D0=B4=D0=BD=D0=B8"
+
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5 =
=D0=B7=D0=B0 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=
=BF=D1=80=D0=B8 =D0=B8=D0=B7=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =
=D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
+
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
+msgstr "=D0=94=D0=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=
=BD=D0=B8 =D0=BF=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D0=B8 =D0=B7=
=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5"
+
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "=D0=A8=D0=B8=D1=80=D0=BE=D1=87=D0=B8=D0=BD=D0=B0 =D0=BD=D0=B0 =
=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BD=D0=B0 =D1=81=D1=8A=D0=BE=D0=
=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BF=D1=80=D0=B8 =D0=BF=
=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B7=D0=B0 =D0=B8=D0=BC=
=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D0=B5 =D0=
=BA=D0=BB=D0=BE=D0=BD=D0=B8"
+
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D0=BE =D0=
=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=84=D0=B0=
=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5=D1=82=D0=B5"
+
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=
=D0=B0=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =D0=BD=D0=B5=D1=81=D0=B2=D1=8A=D1=
=80=D0=B7=D0=B0=D0=BD =D0=B2=D1=80=D1=8A=D1=85"
+
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=
=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=B5=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5"
+
+#: lib/option.tcl:209
+msgid "Change"
+msgstr "=D0=A1=D0=BC=D1=8F=D0=BD=D0=B0"
+
+#: lib/option.tcl:253
+msgid "Spelling Dictionary:"
+msgstr "=D0=9F=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B5=D0=BD =D1=
=80=D0=B5=D1=87=D0=BD=D0=B8=D0=BA:"
+
+#: lib/option.tcl:283
+msgid "Change Font"
+msgstr "=D0=A1=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=88=D1=80=D0=B8=
=D1=84=D1=82=D0=B0"
+
+#: lib/option.tcl:287
+#, tcl-format
+msgid "Choose %s"
+msgstr "=D0=98=D0=B7=D0=B1=D0=BE=D1=80 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C=
"
+
+#: lib/option.tcl:293
+msgid "pt."
+msgstr "=D1=82=D1=87=D0=BA."
+
+#: lib/option.tcl:307
+msgid "Preferences"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
+
+#: lib/option.tcl:344
+msgid "Failed to completely save options:"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=
=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BD=D0=B0=
=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5:"
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=
=D0=B2=D0=B0 =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B0 =D0=B2=D0=
=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=
=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F=D1=82=D0=B0 =D0=BE=D1=
=82 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=
=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F=D1=82=D0=B0 =D0=BE=D1=
=82 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"=D0=A0=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D0=
=BA=D0=B0=D0=B7=D0=B2=D0=B0 =D1=81=D0=B0=D0=BC=D0=BE =D1=80=D0=B0=D0=B7=
=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D1=81 =D0=BA=D0=BE=D0=BD=D1=84=D0=
=BB=D0=B8=D0=BA=D1=82.\n"
+"\n"
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D1=89=D0=B5=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=D1=80=D0=B5=D0=B7=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BD.\n"
+"\n"
+"=D0=A2=D0=B0=D0=B7=D0=B8 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8F =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=
=D1=82=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B0 =D1=81=D0=B0=D0=BC=D0=BE =D1=
=87=D1=80=D0=B5=D0=B7 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE=
 =D0=BD=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr ""
+"=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0, =D1=87=D0=B5 =D0=B2=
=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C =D0=B2=
=D1=81=D0=B5 =D0=BE=D1=89=D0=B5 =D0=B8=D0=BC=D0=B0 =D0=BD=D0=B5=D0=BA=D0=
=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8. =D0=94=D0=B0 =D1=81=D0=B5 =D0=B4=D0=BE=
=D0=B1=D0=B0=D0=B2=D0=B8 "
+"=D0=BB=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D1=8A=D1=82 =D0=BA=D1=8A=D0=BC =
=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BA=D0=BE=D1=80=D0=B5=D0=BA=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D0=B2 =E2=80=
=9E%s=E2=80=9C"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+"=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D0=
=BF=D1=80=D0=B8 =D1=81=D0=B8=D0=BC=D0=B2=D0=BE=D0=BB=D0=BD=D0=B8 =D0=B2=
=D1=80=D1=8A=D0=B7=D0=BA=D0=B8 =D0=B8=D0=BB=D0=B8 =D0=B8=D0=B7=D1=82=D1=
=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B3=D0=B0=
=D1=82 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=BA=D0=BE=D1=80=D0=
=B8=D0=B3=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D1=81 "
+"=D0=B2=D1=8A=D0=BD=D1=88=D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=B0."
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8A=D1=82, =D0=B2 =D0=BA=D0=BE=D0=B9=
=D1=82=D0=BE =D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=
=8A=D1=82, =D0=BD=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=
=D0=B2=D0=B0"
+
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "=D0=A2=D0=BE=D0=B2=D0=B0 =D0=BD=D0=B5 =D0=B5 =D0=B3=D1=80=D0=B0=
=D1=84=D0=B8=D1=87=D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=B0 =D0=B7=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5: =E2=80=9E=
%s=E2=80=9C"
+
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D0=
=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0 =D0=B7=D0=B0=
 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5: =E2=80=9E%s=E2=80=9C"
+
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=
=B7=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2=D0=B5=D1=87=
=D0=B5 =D0=B5 =D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B0. =D0=94=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BB=D0=B8 =D0=B8=D0=B7=D0=
=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B0?"
+
+#: lib/mergetool.tcl:330
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=D0=B7=D1=
=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=B2=
=D0=B5=D1=80=D1=81=D0=B8=D0=B8:\n"
+"%s"
+
+#: lib/mergetool.tcl:350
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=B7=D0=
=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=
=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D1=81=D1=82=D0=B0=D1=
=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B0:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =
=D0=B7=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6"
+
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=BF=D1=80=D0=BE=
=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D1=81=D0=BB=D0=
=B8=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0"
+
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "=D0=93=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=D0=BD=D0=BE =D0=B4=D0=BE=D0=
=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=80=D0=BE=D0=B1=D0=BD=D0=BE=D1=81=D1=82=D0=
=B8 =D0=B7=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0=
"
+
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "=D0=97=D0=B0 =D1=81=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=BC=D0=B5=D0=BD=D1=8E=D1=82=D0=B0=
 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=
=B7=D0=B0 =D1=80=D0=B0=D0=B7=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D0=B5=D0=BB =
=D0=B7=D0=BD=D0=B0=D0=BA=D0=B0 =E2=80=9E/=E2=80=9C:"
+
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D0=B8 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=B2=
=D0=B5=D0=B6=D0=B4=D0=B0 =D0=B4=D0=B8=D0=B0=D0=BB=D0=BE=D0=B3=D0=BE=D0=B2=
 =D0=BF=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86"
+
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "=D0=9F=D0=BE=D1=82=D1=80=D0=B5=D0=B1=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8F=D1=82 =D0=B4=D0=B0 =D1=83=D0=BA=D0=B0=D0=B6=D0=B5 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8F (=D0=B7=D0=B0=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=BB=D0=B8=D0=B2=D0=B0=D1=
=82=D0=B0 $REVISION)"
+
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr ""
+"=D0=9F=D0=BE=D1=82=D1=80=D0=B5=D0=B1=D0=B8=D1=82=D0=B5=D0=BB=D1=8F=D1=
=82 =D0=B4=D0=B0 =D1=83=D0=BA=D0=B0=D0=B6=D0=B5 =D0=B4=D0=BE=D0=BF=D1=8A=
=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=B8 =D0=B0=D1=80=D0=B3=D1=83=
=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 (=D0=B7=D0=B0=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=BB=D0=B8=
=D0=B2=D0=B0=D1=82=D0=B0 $ARGS)"
+
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "=D0=91=D0=B5=D0=B7 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86=
 =D1=81 =D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BE=D1=82 =D0=BA=D0=BE=D0=
=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0"
+
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr ""
+"=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D1=81=D0=
=B0=D0=BC=D0=BE =D1=81=D0=BB=D0=B5=D0=B4 =D0=B8=D0=B7=D0=B1=D0=BE=D1=80=
 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0 (=D0=BF=D1=80=D0=
=BE=D0=BC=D0=B5=D0=BD=D0=BB=D0=B8=D0=B2=D0=B0=D1=82=D0=B0 $FILENAME =D0=
=BD=D0=B5 =D0=B5 =D0=BF=D1=80=D0=B0=D0=B7=D0=BD=D0=B0)"
+
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "=D0=97=D0=B0=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8=D0=BC=D0=B5 =
=D0=B7=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0."
+
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =E2=80=9E=
%s=E2=80=9C =D0=B2=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=
=D0=B2=D1=83=D0=B2=D0=B0."
+
+#: lib/tools_dlg.tcl:148
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =D0=BD=D0=B5 =D0=
=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B4=D0=BE=
=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD=D0=B0:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:187
+msgid "Remove Tool"
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0"
+
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B8"
+
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B0=D1=85=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B8 =D0=BA=D1=8A=D0=BC=
 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=BE=D1=82=D0=BE =D1=85=D1=80=D0=
=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D1=81=D0=B0 =D0=BE=D0=B1=D0=BE=
=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8 =D0=B2 =D1=81=D0=B8=D0=BD=D1=
=8C=D0=BE)"
+
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=B0 =E2=80=
=9E%s=E2=80=9C"
+
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "=D0=90=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8"
+
+#: lib/tools_dlg.tcl:336 lib/checkout_op.tcl:567 lib/merge.tcl:166
+msgid "Visualize"
+msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=86=D0=
=B8=D1=8F"
+
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "=D0=94=D0=BE=D0=B1=D1=80=D0=B5"
+
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5:"
+
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=B0 =D0=BF=D0=BE=D1=
=8F=D0=B2=D0=B0"
+
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=B0 =D0=BF=D0=BE=D1=
=8F=D0=B2=D0=B0"
+
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "=D0=A0=D0=B5=D0=B3. =D0=B8=D0=B7=D1=80."
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "=D0=A0=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=8A=D1=80"
+
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
+msgid "Cannot write shortcut:"
+msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B0=D1=82=D0=B0 =D0=
=BA=D0=BE=D0=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B5 =
=D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=
=B0=D0=BF=D0=B0=D0=B7=D0=B5=D0=BD=D0=B0:"
+
+#: lib/shortcut.tcl:137
+msgid "Cannot write icon:"
+msgstr "=D0=98=D0=BA=D0=BE=D0=BD=D0=B0=D1=82=D0=B0 =D0=BD=D0=B5 =D0=BC=
=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=
=BF=D0=B0=D0=B7=D0=B5=D0=BD=D0=B0:"
+
+#: lib/diff.tcl:64
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application=
, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may =
have "
+"the same state."
+msgstr ""
+"=D0=9D=D0=B5 =D1=81=D0=B0 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D1=82=D0=B8 =
=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8.\n"
+"\n"
+"=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=
=B2 =E2=80=9E%s=E2=80=9C.\n"
+"\n"
+"=D0=92=D1=80=D0=B5=D0=BC=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BF=D1=80=D0=
=BE=D0=BC=D1=8F=D0=BD=D0=B0 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=
 =D0=B5 =D0=B1=D0=B8=D0=BB =D0=B7=D0=B0=D0=B4=D0=B0=D0=B4=D0=B5=D0=BD =D0=
=BE=D1=82 =D0=B4=D1=80=D1=83=D0=B3=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=B0, =D0=BD=D0=BE =D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=
=B0=D0=BD=D0=B8=D0=B5=D1=82=D0=BE "
+"=D0=BC=D1=83 =D0=BD=D0=B5 =D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=BE.\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=
=89=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=
=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B4=D0=B0=D0=
=BB=D0=B8 =D0=BD=D1=8F=D0=BC=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=D0=B8 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =D0=B2 =D1=82=D0=BE=D0=B2=D0=B0 "
+"=D1=81=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
+
+#: lib/diff.tcl:104
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B8=D1=82=D0=B5 =D0=B2 =E2=80=
=9E%s=E2=80=9C=E2=80=A6"
+
+#: lib/diff.tcl:125
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=9D=D0=9E: =D0=B8=D0=B7=D1=82=D1=80=D0=
=B8=D1=82\n"
+"=D0=9E=D0=A2=D0=94=D0=90=D0=9B=D0=95=D0=A7=D0=95=D0=9D=D0=9E:\n"
+
+#: lib/diff.tcl:130
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"=D0=9E=D0=A2=D0=94=D0=90=D0=9B=D0=95=D0=A7=D0=95=D0=9D=D0=9E: =D0=B8=D0=
=B7=D1=82=D1=80=D0=B8=D1=82\n"
+"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=9D=D0=9E:\n"
+
+#: lib/diff.tcl:137
+msgid "LOCAL:\n"
+msgstr "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=9D=D0=9E:\n"
+
+#: lib/diff.tcl:140
+msgid "REMOTE:\n"
+msgstr "=D0=9E=D0=A2=D0=94=D0=90=D0=9B=D0=95=D0=A7=D0=95=D0=9D=D0=9E:\=
n"
+
+#: lib/diff.tcl:202 lib/diff.tcl:337
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=
=D0=B4=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C"
+
+#: lib/diff.tcl:203
+msgid "Error loading file:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=84=D0=
=B0=D0=B9=D0=BB:"
+
+#: lib/diff.tcl:210
+msgid "Git Repository (subproject)"
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=
=B0 Git (=D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82)"
+
+#: lib/diff.tcl:222
+msgid "* Binary file (not showing content)."
+msgstr "=E2=81=83 =D0=94=D0=B2=D0=BE=D0=B8=D1=87=D0=B5=D0=BD =D1=84=D0=
=B0=D0=B9=D0=BB (=D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D0=BD=D0=B8=
=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=
=B7=D0=B2=D0=B0)."
+
+#: lib/diff.tcl:227
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"=E2=81=83 =D0=9D=D0=B5=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F=
=D1=82 =D1=84=D0=B0=D0=B9=D0=BB =D0=B5 %d =D0=B1=D0=B0=D0=B9=D1=82=D0=B0=
=2E\n"
+"=E2=81=83 =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D1=82 =D1=81=D0=B5=
 =D1=81=D0=B0=D0=BC=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=B8=D1=82=D0=B5 %d=
 =D0=B1=D0=B0=D0=B9=D1=82=D0=B0.\n"
+
+#: lib/diff.tcl:233
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"=E2=81=83 =D0=9D=D0=B5=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F=
=D1=82 =D1=84=D0=B0=D0=B9=D0=BB =D0=B5 =D0=BE=D1=82=D1=80=D1=8F=D0=B7=D0=
=B0=D0=BD =D0=B4=D0=BE=D1=82=D1=83=D0=BA %s.\n"
+"=E2=81=83 =D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=
=D0=B5 =D0=B2=D1=8A=D0=BD=D1=88=D0=B5=D0=BD =D1=80=D0=B5=D0=B4=D0=B0=D0=
=BA=D1=82=D0=BE=D1=80, =D0=B7=D0=B0 =D0=B4=D0=B0 =D0=B2=D0=B8=D0=B4=D0=B8=
=D1=82=D0=B5 =D1=86=D0=B5=D0=BB=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB.\n=
"
+
+#: lib/diff.tcl:338 lib/blame.tcl:1128
+msgid "Error loading diff:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=80=D0=
=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0:"
+
+#: lib/diff.tcl:557
+msgid "Failed to unstage selected hunk."
+msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=
=B0=D1=80=D1=87=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B8=D0=B7=D0=B2=D0=B0=D0=B4=D0=B5=D0=BD=D0=
=BE =D0=BE=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0."
+
+#: lib/diff.tcl:564
+msgid "Failed to stage selected hunk."
+msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=
=B0=D1=80=D1=87=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD =D0=
=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0."
+
+#: lib/diff.tcl:643
+msgid "Failed to unstage selected line."
+msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8=D1=8F=D1=82 =D1=80=D0=
=B5=D0=B4 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=
=D0=B4=D0=B5 =D0=B8=D0=B7=D0=B2=D0=B0=D0=B4=D0=B5=D0=BD =D0=BE=D1=82 =D0=
=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0."
+
+#: lib/diff.tcl:651
+msgid "Failed to stage selected line."
+msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B8=D1=8F=D1=82 =D1=80=D0=
=B5=D0=B4 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=
=D0=B4=D0=B5 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D0=BD =D0=BA=D1=8A=D0=
=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0."
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =
=D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
+msgstr "=D0=9E=D1=82 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=
=B5"
+
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=BE=D0=B2=D0=B5"
+
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5, =D1=81=
=D0=B0=D0=BC=D0=BE =D0=B0=D0=BA=D0=BE"
+
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr "=D0=A1=D0=BB=D1=8F=D1=82 =D0=B2:"
+
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "=D0=92=D0=B8=D0=BD=D0=B0=D0=B3=D0=B8 (=D0=B1=D0=B5=D0=B7 =D0=BF=
=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B7=D0=B0 =D1=81=D0=BB=D0=
=B8=D0=B2=D0=B0=D0=BD=D0=B5)"
+
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr "=D0=97=D0=B0 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8=D1=82=D0=B5 =E2=80=
=9E=D0=A1=D0=BB=D1=8F=D1=82 =D0=B2=E2=80=9C =D0=B5 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=B4=D0=B0 =D0=B7=D0=B0=D0=B4=
=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD."
+
+#: lib/remote_branch_delete.tcl:185
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"=D0=A1=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=82=D0=B5 =D0=BA=D0=BB=D0=BE=D0=
=BD=D0=B8 =D0=BD=D0=B5 =D1=81=D0=B0 =D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D0=BD=
=D0=B0=D0=BF=D1=8A=D0=BB=D0=BD=D0=BE =D0=B2 =E2=80=9E%s=E2=80=9C:\n"
+"\n"
+" =E2=81=83 %s"
+
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched th=
e "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"=D0=9F=D0=BE=D0=BD=D0=B5 =D0=B5=D0=B4=D0=BD=D0=B0 =D0=BE=D1=82 =D0=BF=
=D1=80=D0=BE=D0=B1=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D1=81=D0=BB=D0=B8=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=B5 =D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=
=D0=BD=D0=B0, =D0=B7=D0=B0=D1=89=D0=BE=D1=82=D0=BE =D0=BD=D0=B5 =D1=81=D1=
=82=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D0=BB=D0=B8 =D0=B2=
=D1=81=D0=B8=D1=87=D0=BA=D0=B8 "
+"=D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=B8 =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F. =D0=9F=D1=80=D0=BE=D0=B1=
=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D0=BF=D1=8A=D1=80=D0=B2=D0=BE =D0=B4=D0=
=B0 =D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F=D1=82=D0=B0 =D0=BE=D1=82 =E2=
=80=9E%s=E2=80=9C."
+
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
+msgstr "=D0=98=D0=B7=D0=B1=D0=B5=D1=80=D0=B5=D1=82=D0=B5 =D0=BF=D0=BE=D0=
=BD=D0=B5 =D0=B5=D0=B4=D0=B8=D0=BD =D0=BA=D0=BB=D0=BE=D0=BD =D0=B7=D0=B0=
 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"=D0=92=D1=8A=D0=B7=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=
=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=
=D1=82=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D0=B5 =D1=82=D1=80=D1=83=D0=B4=D0=BD=D0=BE.\n"
+"\n"
+"=D0=A1=D0=B8=D0=B3=D1=83=D1=80=D0=BD=D0=B8 =D0=BB=D0=B8 =D1=81=D1=82=D0=
=B5, =D1=87=D0=B5 =D0=B8=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=B4=D0=B0 =D1=
=82=D1=80=D0=B8=D0=B5=D1=82=D0=B5?"
+
+#: lib/remote_branch_delete.tcl:227
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8 =D0=BE=D1=82 =E2=80=9E%s=E2=80=9C"
+
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
+msgstr "=D0=9D=D0=B5 =D0=B5 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=
 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5."
+
+#: lib/remote_branch_delete.tcl:305
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "=D0=9F=D1=80=D0=B5=D1=82=D1=8A=D1=80=D1=81=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C=E2=80=A6"
+
+#: lib/choose_repository.tcl:32
+msgid "Git Gui"
+msgstr "=D0=93=D0=9F=D0=98 =D0=BD=D0=B0 Git"
+
+#: lib/choose_repository.tcl:91 lib/choose_repository.tcl:396
+msgid "Create New Repository"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=BE=D0=B2=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=
=D1=89=D0=B5"
+
+#: lib/choose_repository.tcl:97
+msgid "New..."
+msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=E2=80=A6"
+
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:480
+msgid "Clone Existing Repository"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0=D1=89=D0=
=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/choose_repository.tcl:115
+msgid "Clone..."
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=E2=80=A6=
"
+
+#: lib/choose_repository.tcl:122 lib/choose_repository.tcl:1019
+msgid "Open Existing Repository"
+msgstr "=D0=9E=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0=D1=89=D0=BE=
 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#: lib/choose_repository.tcl:128
+msgid "Open..."
+msgstr "=D0=9E=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5=E2=80=A6"
+
+#: lib/choose_repository.tcl:141
+msgid "Recent Repositories"
+msgstr "=D0=A1=D0=BA=D0=BE=D1=80=D0=BE =D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=
=B0=D0=BD=D0=B8"
+
+#: lib/choose_repository.tcl:147
+msgid "Open Recent Repository:"
+msgstr "=D0=9E=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BF=D0=BE=D0=BB=
=D0=B7=D0=B2=D0=B0=D0=BD=D0=BE =D0=BD=D0=B0=D1=81=D0=BA=D0=BE=D1=80=D0=BE=
:"
+
+#: lib/choose_repository.tcl:315 lib/choose_repository.tcl:322
+#: lib/choose_repository.tcl:329
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D1=81=D1=
=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE =E2=80=9E%s=E2=80=
=9C:"
+
+#: lib/choose_repository.tcl:391 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/choose_repository.tcl:401
+msgid "Directory:"
+msgstr "=D0=94=D0=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F:"
+
+#: lib/choose_repository.tcl:431 lib/choose_repository.tcl:552
+#: lib/choose_repository.tcl:1053
+msgid "Git Repository"
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=
=B0 Git"
+
+#: lib/choose_repository.tcl:456
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "=D0=92=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0 =D0=B4=D0=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_repository.tcl:460
+#, tcl-format
+msgid "File %s already exists."
+msgstr "=D0=92=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_repository.tcl:475
+msgid "Clone"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#: lib/choose_repository.tcl:488
+msgid "Source Location:"
+msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=82=
=D0=BE=D1=87=D0=BD=D0=B8=D0=BA=D0=B0:"
+
+#: lib/choose_repository.tcl:497
+msgid "Target Directory:"
+msgstr "=D0=A6=D0=B5=D0=BB=D0=B5=D0=B2=D0=B0 =D0=B4=D0=B8=D1=80=D0=B5=D0=
=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F:"
+
+#: lib/choose_repository.tcl:507
+msgid "Clone Type:"
+msgstr "=D0=92=D0=B8=D0=B4 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5:"
+
+#: lib/choose_repository.tcl:512
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D0=BE (=
=D0=B1=D1=8A=D1=80=D0=B7=D0=BE, =D1=87=D0=B0=D1=81=D1=82=D0=B8=D1=87=D0=
=BD=D0=BE =D1=81=D0=BF=D0=BE=D0=B4=D0=B5=D0=BB=D1=8F=D0=BD=D0=B5 =D0=BD=
=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5, =D1=82=D0=B2=D1=8A=D1=
=80=D0=B4=D0=B8 =D0=B2=D1=80=D1=8A=D0=B7=D0=BA=D0=B8)"
+
+#: lib/choose_repository.tcl:517
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "=D0=9F=D1=8A=D0=BB=D0=BD=D0=BE (=D0=B1=D0=B0=D0=B2=D0=BD=D0=BE=
, =D0=BF=D1=8A=D0=BB=D0=BD=D0=BE=D1=86=D0=B5=D0=BD=D0=BD=D0=BE =D1=80=D0=
=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=D0=B5)=
"
+
+#: lib/choose_repository.tcl:522
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "=D0=A1=D0=BF=D0=BE=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BE (=D0=BD=
=D0=B0=D0=B9-=D0=B1=D1=8A=D1=80=D0=B7=D0=BE, =D0=BD=D0=B5 =D1=81=D0=B5 =
=D0=BF=D1=80=D0=B5=D0=BF=D0=BE=D1=80=D1=8A=D1=87=D0=B2=D0=B0, =D0=BD=D0=
=B5 =D0=BF=D1=80=D0=B0=D0=B2=D0=B8 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=
=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=D0=B5)"
+
+#: lib/choose_repository.tcl:558 lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:751 lib/choose_repository.tcl:821
+#: lib/choose_repository.tcl:1059 lib/choose_repository.tcl:1067
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "=D0=A2=D0=BE=D0=B2=D0=B0 =D0=BD=D0=B5 =D0=B5 =D1=85=D1=80=D0=B0=
=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5 =D0=BD=D0=B0 Git: %s"
+
+#: lib/choose_repository.tcl:594
+msgid "Standard only available for local repository."
+msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=
=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0 =D0=BC=D0=BE=
=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=B0=D1=82 =D1=81=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=
=BD=D0=BE"
+
+#: lib/choose_repository.tcl:598
+msgid "Shared only available for local repository."
+msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=
=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0 =D0=BC=D0=BE=
=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=B0=D1=82 =D1=81=D0=BF=D0=BE=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=
=BE"
+
+#: lib/choose_repository.tcl:619
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "=D0=92=D0=B5=D1=87=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D1=83=D0=B2=D0=B0 =D0=BC=D0=B5=D1=81=D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=
=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_repository.tcl:630
+msgid "Failed to configure origin"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BD=D0=
=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE-=D0=B8=
=D0=B7=D1=82=D0=BE=D1=87=D0=BD=D0=B8=D0=BA"
+
+#: lib/choose_repository.tcl:642
+msgid "Counting objects"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/choose_repository.tcl:643
+msgid "buckets"
+msgstr "=D0=BA=D0=BB=D0=B5=D1=82=D0=BA=D0=B8"
+
+#: lib/choose_repository.tcl:667
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "=D0=9E=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5/=D0=B8=D0=BD=D1=
=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0/=D1=81=D0=B8=D0=
=BD=D0=BE=D0=BD=D0=B8=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=
=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=BA=D0=
=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B8: %s"
+
+#: lib/choose_repository.tcl:703
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BA=D0=B0=D0=BA=D0=B2=D0=BE =D0=B4=
=D0=B0 =D1=81=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0 =D0=BE=D1=
=82 =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_repository.tcl:705 lib/choose_repository.tcl:919
+#: lib/choose_repository.tcl:931
+msgid "The 'master' branch has not been initialized."
+msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=BD=D0=B8=D1=8F=D1=82 =D0=BA=D0=
=BB=D0=BE=D0=BD =E2=80=94 =E2=80=9Emaster=E2=80=9C =D0=BD=D0=B5 =D0=B5 =
=D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=B0=
=D0=BD."
+
+#: lib/choose_repository.tcl:718
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "=D0=9D=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=
=D0=B6=D0=B0=D1=82 =D1=82=D0=B2=D1=8A=D1=80=D0=B4=D0=B8 =D0=B2=D1=80=D1=
=8A=D0=B7=D0=BA=D0=B8. =D0=9F=D1=80=D0=B5=D0=BC=D0=B8=D0=BD=D0=B0=D0=B2=
=D0=B0 =D1=81=D0=B5 =D0=BA=D1=8A=D0=BC =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=
=B0=D0=BD=D0=B5."
+
+#: lib/choose_repository.tcl:730
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C"
+
+#: lib/choose_repository.tcl:761
+msgid "Copying objects"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/choose_repository.tcl:762
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:786
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BA=D0=
=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=D0=B1=D0=B5=
=D0=BA=D1=82: %s"
+
+#: lib/choose_repository.tcl:796
+msgid "Linking objects"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B2=D1=80=D1=8A=D0=B7=D0=BA=D0=B8 =D0=BA=D1=8A=D0=BC =D0=BE=D0=B1=
=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5"
+
+#: lib/choose_repository.tcl:797
+msgid "objects"
+msgstr "=D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/choose_repository.tcl:805
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D1=81=D1=
=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=82=D0=B2=
=D1=8A=D1=80=D0=B4=D0=B0 =D0=B2=D1=80=D1=8A=D0=B7=D0=BA=D0=B0 =D0=BA=D1=
=8A=D0=BC =D0=BE=D0=B1=D0=B5=D0=BA=D1=82: %s"
+
+#: lib/choose_repository.tcl:860
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr ""
+"=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BE=D0=B1=D0=B5=D0=
=BA=D1=82=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B3=D0=B0=D1=82=
 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B8=D0=B7=D1=82=D0=B5=D0=
=B3=D0=BB=D0=B5=D0=BD=D0=B8. =D0=97=D0=B0 =D0=BF=D0=BE=D0=B2=D0=B5=D1=87=
=D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F "
+"=D0=BF=D0=BE=D0=B3=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D1=82=D0=B5 =D0=B8=D0=
=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D0=B7=D0=BE=
=D0=BB=D0=B0=D1=82=D0=B0."
+
+#: lib/choose_repository.tcl:871
+msgid "Cannot fetch tags.  See console output for details."
+msgstr ""
+"=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5 =D0=
=BC=D0=BE=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82=
 =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D0=B5=D0=BD=D0=B8. =D0=97=D0=B0 =D0=
=BF=D0=BE=D0=B2=D0=B5=D1=87=D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=
=B0=D1=86=D0=B8=D1=8F =D0=BF=D0=BE=D0=B3=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D1=
=82=D0=B5 "
+"=D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D0=
=B7=D0=BE=D0=BB=D0=B0=D1=82=D0=B0."
+
+#: lib/choose_repository.tcl:895
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr ""
+"=D0=92=D1=8A=D1=80=D1=85=D1=8A=D1=82 HEAD =D0=BD=D0=B5 =D0=BC=D0=BE=D0=
=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD. =D0=97=D0=B0 =D0=BF=D0=BE=D0=B2=D0=B5=D1=
=87=D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =
=D0=BF=D0=BE=D0=B3=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D1=82=D0=B5 "
+"=D0=B8=D0=B7=D1=85=D0=BE=D0=B4=D0=B0 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D0=
=B7=D0=BE=D0=BB=D0=B0=D1=82=D0=B0."
+
+#: lib/choose_repository.tcl:904
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5=
 =D0=B7=D0=B0=D1=87=D0=B8=D1=81=D1=82=D0=B8 =E2=80=9E%s=E2=80=9C"
+
+#: lib/choose_repository.tcl:910
+msgid "Clone failed."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BA=D0=
=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BD=D0=B5."
+
+#: lib/choose_repository.tcl:917
+msgid "No default branch obtained."
+msgstr "=D0=9D=D0=B5 =D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=
 =D0=BA=D0=BB=D0=BE=D0=BD =D0=BF=D0=BE =D0=BF=D0=BE=D0=B4=D1=80=D0=B0=D0=
=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5."
+
+#: lib/choose_repository.tcl:928
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BE=D1=82=D0=B3=D0=BE=D0=B2=D0=B0=D1=80=D1=8F=D1=89=D0=BE =
=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C."
+
+#: lib/choose_repository.tcl:940
+msgid "Creating working directory"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=B8=
=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F"
+
+#: lib/choose_repository.tcl:941 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
+msgid "files"
+msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5"
+
+#: lib/choose_repository.tcl:970
+msgid "Initial file checkout failed."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D1=
=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BD=D0=BE =D0=B8=D0=
=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5."
+
+#: lib/choose_repository.tcl:1014
+msgid "Open"
+msgstr "=D0=9E=D1=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5"
+
+#: lib/choose_repository.tcl:1024
+msgid "Repository:"
+msgstr "=D0=A5=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5:"
+
+#: lib/choose_repository.tcl:1073
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D1=
=82=D0=B2=D0=B0=D1=80=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=85=D1=80=D0=B0=
=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE =E2=80=9E%s=E2=80=9C:"
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui =E2=80=94 =D0=B3=D1=80=D0=B0=D1=84=D0=B8=D1=87=D0=B5=D0=
=BD =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81 =D0=B7=D0=B0=
 Git."
+
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "=D0=94=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=
=B0 =E2=80=9E%s=E2=80=9C =D0=BE=D1=82 =E2=80=9E%s=E2=80=9C"
+
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "=D1=84=D0=B0=D1=82=D0=B0=D0=BB=D0=BD=D0=B0 =D0=B3=D1=80=D0=B5=D1=
=88=D0=BA=D0=B0: =E2=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=
=B5 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D0=B5"
+
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=BD=
=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0."
+
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BD=D0=
=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BE=D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=B5=D0=BD git-pull =D0=B7=D0=B0 =
=E2=80=9E%s=E2=80=9C."
+
+#: lib/checkout_op.tcl:229
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D1=81=D1=8A=
=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0.\n"
+"\n"
+"=D0=A2=D0=BE=D0=B9 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D1=82=D1=80=D0=B8=D0=B2=D0=B8=D0=B0=D0=BB=D0=
=BD=D0=BE =D0=BF=D1=80=D0=B5=D0=B2=D1=8A=D1=80=D1=82=D1=8F=D0=BD =D0=B4=
=D0=BE %s.\n"
+"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=B5 =D1=
=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "=D0=A1=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D0=B7=D0=
=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5  =E2=80=9E%s=E2=80=9C =D0=
=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=
=2E"
+
+#: lib/checkout_op.tcl:262
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D0=
=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =E2=80=
=9E%s=E2=80=9C."
+
+#: lib/checkout_op.tcl:274
+msgid "Staging area (index) is already locked."
+msgstr "=D0=98=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D0=B2=D0=B5=D1=
=87=D0=B5 =D0=B5 =D0=B7=D0=B0=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD."
+
+#: lib/checkout_op.tcl:289
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"=D0=A1=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=
=BF=D1=80=D0=B8 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B0=D1=82=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B5 =D0=BE=
=D1=82=D0=B3=D0=BE=D0=B2=D0=B0=D1=80=D1=8F =D0=BD=D0=B0 =D1=81=D1=8A=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 "
+"=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE.\n=
"
+"\n"
+"=D0=9D=D1=8F=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3 =D0=BF=D1=80=D0=
=BE=D1=86=D0=B5=D1=81 =D0=B7=D0=B0 Git =D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=
=B5=D0=BD=D0=B8=D0=BB =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=
=B5=D1=82=D0=BE =D0=BC=D0=B5=D0=B6=D0=B4=D1=83=D0=B2=D1=80=D0=B5=D0=BC=D0=
=B5=D0=BD=D0=BD=D0=BE. =D0=A1=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5=D1=82=D0=BE "
+"=D1=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=
=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B5=D0=BD=D0=BE, =D0=BF=D1=80=
=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BF=D1=80=D0=B5=D0=BC=D0=
=B8=D0=BD=D0=B5 =D0=BA=D1=8A=D0=BC =D0=BD=D0=BE=D0=B2 =D0=BA=D0=BB=D0=BE=
=D0=BD.\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=
=89=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=
=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0.\n"
+
+#: lib/checkout_op.tcl:345
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=
=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D1=81=D0=B5 =D0=BF=
=D1=80=D0=B8=D0=B2=D0=B5=D0=B6=D0=B4=D0=B0 =D0=BA=D1=8A=D0=BC =E2=80=9E=
%s=E2=80=9C=E2=80=A6"
+
+#: lib/checkout_op.tcl:346
+msgid "files checked out"
+msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D1=81=D0=B0 =D0=B8=D0=B7=D1=82=
=D0=B5=D0=B3=D0=BB=D0=B5=D0=BD=D0=B8"
+
+#: lib/checkout_op.tcl:376
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+"=D0=9F=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=8F=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=
=D1=8F=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C (=D0=BD=
=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=B5 =D0=BF=D0=
=BE=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=
=B0=D0=BD=D0=B5)."
+
+#: lib/checkout_op.tcl:377
+msgid "File level merge required."
+msgstr "=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=
=B5 =D0=BF=D0=BE=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=BE =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/checkout_op.tcl:381
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "=D0=9E=D1=81=D1=82=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2=D1=8A=D1=
=80=D1=85=D1=83 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C."
+
+#: lib/checkout_op.tcl:452
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This D=
etached "
+"Checkout'."
+msgstr ""
+"=D0=92=D0=B5=D1=87=D0=B5 =D0=BD=D0=B5 =D1=81=D1=82=D0=B5 =D0=BD=D0=B0=
 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=BD.\n=
"
+"\n"
+"=D0=90=D0=BA=D0=BE =D0=B8=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=B4=D0=B0 =
=D1=81=D1=82=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD, =D1=81=D1=8A=D0=
=B7=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B1=D0=B0=D0=B7=D0=B8=D1=80=D0=B0=D0=
=BD =D0=BD=D0=B0 =E2=80=9E=D0=A2=D0=BE=D0=B2=D0=B0 =D0=BD=D0=B5=D1=81=D0=
=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=
=BB=D1=8F=D0=BD=D0=B5=E2=80=9C."
+
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "=E2=80=9E%s=E2=80=9C =D0=B5 =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=
=D0=B5=D0=BD."
+
+#: lib/checkout_op.tcl:535
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+"=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=
=BE =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C =D0=BA=D1=8A=D0=BC =E2=80=9E%s=E2=
=80=9C =D1=89=D0=B5 =D0=B4=D0=BE=D0=B2=D0=B5=D0=B4=D0=B5 =D0=B4=D0=BE =D0=
=B7=D0=B0=D0=B3=D1=83=D0=B1=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=
=B0 =D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F:"
+
+#: lib/checkout_op.tcl:557
+msgid "Recovering lost commits may not be easy."
+msgstr "=D0=92=D1=8A=D0=B7=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=8F=D0=
=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=B7=D0=B0=D0=B3=D1=83=
=D0=B1=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=
=D0=BD=D0=B8=D1=8F =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B5 =D1=82=D1=
=80=D1=83=D0=B4=D0=BD=D0=BE."
+
+#: lib/checkout_op.tcl:562
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "=D0=97=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9E%s=E2=80=9C?"
+
+#: lib/checkout_op.tcl:571 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "=D0=9E=D1=82=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BE"
+
+#: lib/checkout_op.tcl:635
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully u=
pdated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=B0=D0=
=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD.\n"
+"\n"
+"=D0=A0=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=B0=D1=82=D0=B0 =D0=B4=D0=B8=D1=
=80=D0=B5=D0=BA=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B5 =D1=81=D0=B0=D0=BC=
=D0=BE =D1=87=D0=B0=D1=81=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D0=BE=D0=B1=D0=
=BD=D0=BE=D0=B2=D0=B5=D0=BD=D0=B0: =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=
=D0=B5=D1=82=D0=B5 =D1=81=D0=B0 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=B5=D0=
=BD=D0=B8 "
+"=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE, =D0=BD=D0=BE =D0=BD=D1=8F=
=D0=BA=D0=BE=D0=B9 =D0=BE=D1=82 =D0=B2=D1=8A=D1=82=D1=80=D0=B5=D1=88=D0=
=BD=D0=B8=D1=82=D0=B5, =D1=81=D0=BB=D1=83=D0=B6=D0=B5=D0=B1=D0=BD=D0=B8=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =D0=BD=D0=B0 Git =D0=BD=D0=B5=
 =D0=B5 =D0=B1=D0=B8=D0=BB.\n"
+"\n"
+"=D0=A2=D0=BE=D0=B2=D0=B0 =D1=81=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=
=B8=D0=B5 =D0=B5 =D0=B0=D0=B2=D0=B0=D1=80=D0=B8=D0=B9=D0=BD=D0=BE =D0=B8=
 =D0=BD=D0=B5 =D1=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D1=81=D0=
=B5 =D1=81=D0=BB=D1=83=D1=87=D0=B2=D0=B0. =D0=9F=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =E2=80=9E%s=E2=80=9C =D1=89=D0=B5 "
+"=D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0."
+
+#: lib/branch_create.tcl:23
+msgid "Create Branch"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "=D0=A1=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BD=D0=BE=D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "=D0=98=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0=
"
+
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BF=D0=
=BE =D0=B8=D0=BC=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D1=81=D0=BB=D0=B5=D0=B4=
=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "=D0=9D=D0=B0=D1=87=D0=B0=D0=BB=D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8F"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=B0=D1=
=89 =D0=BA=D0=BB=D0=BE=D0=BD:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "=D0=9D=D0=B5"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "=D0=A1=D0=B0=D0=BC=D0=BE =D1=82=D1=80=D0=B8=D0=B2=D0=B8=D0=B0=D0=
=BB=D0=BD=D0=BE =D0=BF=D1=80=D0=B5=D0=B2=D1=8A=D1=80=D1=82=D0=B0=D1=89=D0=
=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "=D0=9F=D1=80=D0=B5=D0=BC=D0=B8=D0=BD=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BA=D1=8A=D0=BC =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =D1=81=D0=BB=D0=B5=
=D0=B4 =D1=81=D1=8A=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE=
 =D0=BC=D1=83"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "=D0=98=D0=B7=D0=B1=D0=B5=D1=80=D0=B5=D1=82=D0=B5 =D0=BA=D0=BB=D0=
=BE=D0=BD =D0=B7=D0=B0 =D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D1=8A=D1=82, =D0=BA=D0=BE=D0=B9=D1=82=
=D0=BE =D1=81=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D0=B8 =E2=80=9E%s=E2=80=9C=
 =D0=BD=D0=B5 =D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B2=D0=
=B0 =D0=B2 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE=
=D1=82=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5."
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "=D0=92 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D1=81=D0=B5=
 =D0=B8=D0=B7=D0=B2=D1=8A=D1=80=D1=88=D0=B2=D0=B0 =D0=B4=D0=B5=D0=B9=D1=
=81=D1=82=D0=B2=D0=B8=D0=B5, =D0=B8=D0=B7=D1=87=D0=B0=D0=BA=D0=B0=D0=B9=
=D1=82=D0=B5=E2=80=A6"
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "=D0=A3=D1=81=D0=BF=D0=B5=D1=85"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0: =D0=BD=D0=B5=D1=83=D1=81=
=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=
=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=
=B0"
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "=D0=A2=D0=BE=D0=B2=D0=B0 =D0=BD=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=
=B7=D0=B0=D0=BD=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=
=B5"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "=D0=98=D0=B7=D1=80=D0=B0=D0=B7 =D0=B7=D0=B0 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8F"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=
=BD"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=8F=D1=89 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "=D0=95=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B0 =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "=D0=9D=D0=B5 =D0=B5 =D0=B8=D0=B7=D0=B1=D1=80=D0=B0=D0=BD=D0=B0=
 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "=D0=98=D0=B7=D1=80=D0=B0=D0=B7=D1=8A=D1=82 =D0=B7=D0=B0 =D0=B2=
=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B5 =D0=BF=D1=80=D0=B0=D0=B7=D0=B5=D0=
=BD."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81"
+
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "=D0=9A=D1=8A=D0=BC =D1=80=D0=B5=D0=B4:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "=D0=9F=D1=80=D0=B8=D0=B4=D0=B2=D0=B8=D0=B6=D0=B2=D0=B0=D0=BD=D0=
=B5"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit befor=
e this "
+"to amend.\n"
+msgstr ""
+"=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BA=D0=B0=D0=BA=D0=B2=D0=BE =D0=B4=D0=B0 =
=D1=81=D0=B5 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B8.\n"
+"\n"
+"=D0=A9=D0=B5 =D1=81=D1=8A=D0=B7=D0=B4=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D0=
=BF=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BD=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5. =D0=9F=D1=80=
=D0=B5=D0=B4=D0=B8 =D0=BD=D0=B5=D0=B3=D0=BE =D0=BD=D1=8F=D0=BC=D0=B0 =D0=
=B4=D1=80=D1=83=D0=B3=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B8=D1=8F, =D0=BA=D0=BE=D0=B8=D1=82=D0=BE "
+"=D0=B4=D0=B0 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D0=B5.\=
n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort =
the "
+"current merge activity.\n"
+msgstr ""
+"=D0=9F=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D0=B5 =D0=BD=D0=B0 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=
=B4=D0=B0 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D1=82=D0=B5.\n"
+"\n"
+"=D0=92 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=B2=D1=81=D0=B5 =
=D0=BE=D1=89=D0=B5 =D0=BD=D0=B5 =D1=81=D1=82=D0=B5 =D0=B7=D0=B0=D0=B2=D1=
=8A=D1=80=D1=88=D0=B8=D0=BB=D0=B8 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BF=D0=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5. =D0=9D=
=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=BF=D0=BE=D0=BF=D1=80=D0=
=B0=D0=B2=D0=B8=D1=82=D0=B5 "
+"=D0=BF=D1=80=D0=B5=D0=B4=D0=B8=D1=88=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BE=D1=81=D0=B2=D0=B5=D0=BD=
 =D0=B0=D0=BA=D0=BE =D0=BF=D1=8A=D1=80=D0=B2=D0=BE =D0=BD=D0=B5 =D0=BF=D1=
=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D0=B5 =D1=
=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=82=D0=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=
=B0=D0=BD=D0=B5.\n"
+
+#: lib/commit.tcl:48
+msgid "Error loading commit data for amend:"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B4=D0=
=B0=D0=BD=D0=BD=D0=B8=D1=82=D0=B5 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=
=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BA=D0=BE=D0=B8=D1=82=D0=BE =D0=B4=D0=B0 =D1=
=81=D0=B5 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D1=82:"
+
+#: lib/commit.tcl:75
+msgid "Unable to obtain your identity:"
+msgstr "=D0=98=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=86=D0=B8=D1=8F=D1=82=D0=B0 =D0=B2=D0=B8 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=
=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=D0=BF=D1=80=D0=B5=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B0:"
+
+#: lib/commit.tcl:80
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=BE =D0=
=BF=D0=BE=D0=BB=D0=B5 GIT_COMMITTER_IDENT:"
+
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=
=80=D0=B6=D0=B0 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=
=BE =E2=80=9E%s=E2=80=9C."
+
+#: lib/commit.tcl:149
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"=D0=A1=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=
=BF=D1=80=D0=B8 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B0=D1=82=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B5 =D0=BE=
=D1=82=D0=B3=D0=BE=D0=B2=D0=B0=D1=80=D1=8F =D0=BD=D0=B0 =D1=81=D1=8A=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 "
+"=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE.\n=
"
+"\n"
+"=D0=9D=D1=8F=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3 =D0=BF=D1=80=D0=
=BE=D1=86=D0=B5=D1=81 =D0=B7=D0=B0 Git =D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=
=B5=D0=BD=D0=B8=D0=BB =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=
=B5=D1=82=D0=BE =D0=BC=D0=B5=D0=B6=D0=B4=D1=83=D0=B2=D1=80=D0=B5=D0=BC=D0=
=B5=D0=BD=D0=BD=D0=BE. =D0=A1=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5=D1=82=D0=BE "
+"=D1=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=
=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B5=D0=BD=D0=BE =D0=BF=D1=80=
=D0=B5=D0=B4=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=
=89=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=
=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0.\n"
+
+#: lib/commit.tcl:173
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
+"before committing.\n"
+msgstr ""
+"=D0=9D=D0=B5=D1=81=D0=BB=D0=B5=D1=82=D0=B8=D1=82=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B3=D0=B0=D1=82=
 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B8.\n"
+"\n"
+"=D0=92=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C=
 =D0=B8=D0=BC=D0=B0 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=
=B8 =D0=BF=D1=80=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5. =D0=97=
=D0=B0 =D0=B4=D0=B0 =D0=B3=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D1=
=82=D0=B5, =D1=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=BF=D1=8A=D1=80=D0=B2=
=D0=BE =D0=B4=D0=B0 "
+"=D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D0=B8 =D0=B4=
=D0=B0 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=B0 =D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=
=D0=B0 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n=
"
+
+#: lib/commit.tcl:181
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=BE =D1=81=D1=8A=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=
=D0=BB =E2=80=9E%s=E2=80=9C.\n"
+"\n"
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=BD=D0=B5=
 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B4=D0=B5=D0=BD =D1=87=D1=80=D0=B5=D0=B7 =D1=82=D0=B5=
=D0=BA=D1=83=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=
=D0=BC=D0=B0.\n"
+
+#: lib/commit.tcl:189
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=
=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=A2=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B4=D0=BE=D0=B1=D0=
=B0=D0=B2=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D0=BD=D0=B5 1 =D1=84=D0=B0=D0=B9=
=D0=BB =D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0, =D0=
=BF=D1=80=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=
=D0=B5=D1=82=D0=B5.\n"
+
+#: lib/commit.tcl:204
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"=D0=97=D0=B0=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B4=D0=BE=D0=B1=D1=80=D0=
=BE =D1=81=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=98=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=
=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D1=8F =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=82:\n"
+"\n"
+"=E2=81=83 =D0=9F=D1=8A=D1=80=D0=B2=D0=B8 =D1=80=D0=B5=D0=B4: =D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2 =D0=B5=D0=B4=D0=BD=D0=BE=
 =D0=B8=D0=B7=D1=80=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=
=BF=D1=80=D0=BE=D0=BC=D1=8F=D0=BD=D0=B0=D1=82=D0=B0.\n"
+"=E2=81=83 =D0=92=D1=82=D0=BE=D1=80=D0=B8 =D1=80=D0=B5=D0=B4: =D0=BF=D1=
=80=D0=B0=D0=B7=D0=B5=D0=BD.\n"
+"=E2=81=83 =D0=9E=D1=81=D1=82=D0=B0=D0=BD=D0=B0=D0=BB=D0=B8=D1=82=D0=B5=
 =D1=80=D0=B5=D0=B4=D0=BE=D0=B2=D0=B5: =D0=BE=D0=BF=D0=B8=D1=88=D0=B5=D1=
=82=D0=B5 =D0=B7=D0=B0=D1=89=D0=BE =D1=81=D0=B5 =D0=BD=D0=B0=D0=BB=D0=B0=
=D0=B3=D0=B0 =D1=82=D0=B0=D0=B7=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D1=8F=D0=
=BD=D0=B0.\n"
+
+#: lib/commit.tcl:235
+msgid "Calling pre-commit hook..."
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D1=8F=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BA=D1=83=D0=BA=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=B5=
=D0=B4=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6"
+
+#: lib/commit.tcl:250
+msgid "Commit declined by pre-commit hook."
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=
=B5 =D0=BE=D1=82=D1=85=D0=B2=D1=8A=D1=80=D0=BB=D0=B5=D0=BD=D0=BE =D0=BE=
=D1=82 =D0=BA=D1=83=D0=BA=D0=B0=D1=82=D0=B0 =D0=BF=D1=80=D0=B5=D0=B4=D0=
=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/commit.tcl:269
+msgid ""
+"You are about to commit on a detached head. This is a potentially dan=
gerous "
+"thing to do because if you switch to another branch you will lose you=
r "
+"changes and it can be difficult to retrieve them later from the reflo=
g. You "
+"should probably cancel this commit and create a new branch to continu=
e.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"=D0=A9=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D0=BA=D1=
=8A=D0=BC =D0=BD=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD =D0=B2=
=D1=80=D1=8A=D1=85. =D0=A2=D0=BE=D0=B2=D0=B0 =D0=B4=D0=B5=D0=B9=D1=81=D1=
=82=D0=B2=D0=B8=D0=B5 =D0=B5 =D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE, =D0=B7=
=D0=B0=D1=89=D0=BE=D1=82=D0=BE =D0=BF=D1=80=D0=B8 "
+"=D0=BF=D1=80=D0=B5=D0=BC=D0=B8=D0=BD=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE =D0=BA=D1=8A=D0=BC =D0=BA=D0=BE=D0=B9=D1=82=D0=BE =D0=B8 =D0=B4=
=D0=B0 =D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD =D1=89=D0=B5 =D0=B7=D0=B0=D0=B3=D1=
=83=D0=B1=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=
=82=D0=B5 =D1=81=D0=B8 =D0=B8 =D0=BD=D0=B5 =D0=B5 =D1=81=D0=B8=D0=B3=D1=
=83=D1=80=D0=BD=D0=BE, "
+"=D1=87=D0=B5 =D1=89=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BF=
=D0=BE-=D0=BA=D1=8A=D1=81=D0=BD=D0=BE =D0=B4=D0=B0 =D0=B3=D0=B8 =D0=B2=D1=
=8A=D0=B7=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D0=B5 =D1=87=D1=
=80=D0=B5=D0=B7 =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=B0 =D0=BD=D0=B0=
 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5. =D0=
=9D=D0=B0=D0=B9-"
+"=D0=B2=D0=B5=D1=80=D0=BE=D1=8F=D1=82=D0=BD=D0=BE =D1=82=D1=80=D1=8F=D0=
=B1=D0=B2=D0=B0 =D0=BF=D1=8A=D1=80=D0=B2=D0=BE =D0=B4=D0=B0 =D1=81=D1=8A=
=D0=B7=D0=B4=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D0=BA=D0=BB=D0=BE=D0=BD =D0=
=B1=D0=B0=D0=B7=D0=B8=D1=80=D0=B0=D0=BD =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=
=D1=83=D1=89=D0=BE=D1=82=D0=BE =D1=81=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=
=D0=B8=D0=B5 =D0=B8 =D0=B4=D0=B0 "
+"=D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D0=BA=D1=8A=D0=BC =D0=
=BD=D0=B5=D0=B3=D0=BE.\n"
+" \n"
+"=D0=A1=D0=B8=D0=B3=D1=83=D1=80=D0=BD=D0=B8 =D0=BB=D0=B8 =D1=81=D1=82=D0=
=B5, =D1=87=D0=B5 =D0=B8=D1=81=D0=BA=D0=B0=D1=82=D0=B5 =D0=B4=D0=B0 =D0=
=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D1=82=D0=BE=D1=87=D0=BD=D0=
=BE =D1=81=D0=B5=D0=B3=D0=B0?"
+
+#: lib/commit.tcl:290
+msgid "Calling commit-msg hook..."
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D1=8F=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BA=D1=83=D0=BA=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D1=81=
=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BF=D1=80=
=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=E2=80=A6"
+
+#: lib/commit.tcl:305
+msgid "Commit declined by commit-msg hook."
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=
=B5 =D0=BE=D1=82=D1=85=D0=B2=D1=8A=D1=80=D0=BB=D0=B5=D0=BD=D0=BE =D0=BE=
=D1=82 =D0=BA=D1=83=D0=BA=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D1=81=D1=8A=D0=
=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5=D1=82=D0=BE =D0=BF=D1=80=D0=B8 =
=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/commit.tcl:318
+msgid "Committing changes..."
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5."
+
+#: lib/commit.tcl:334
+msgid "write-tree failed:"
+msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=
=B0=D0=BF=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B4=D1=8A=
=D1=80=D0=B2=D0=BE=D1=82=D0=BE (write-tree):"
+
+#: lib/commit.tcl:335 lib/commit.tcl:379 lib/commit.tcl:400
+msgid "Commit failed."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/commit.tcl:352
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =E2=
=80=9E%s=E2=80=9C =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B6=D0=B4=D0=B0 =D0=BF=
=D0=BE=D0=B2=D1=80=D0=B5=D0=B4=D0=B5=D0=BD=D0=BE"
+
+#: lib/commit.tcl:357
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\=
n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=
=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=92 =D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B5 =D1=81=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=
=D1=8F=D0=BD=D0=B8 =D0=BD=D0=B8=D0=BA=D0=B0=D0=BA=D0=B2=D0=B8 =D1=84=D0=
=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5, =D0=B0 =D0=B8 =D0=BD=D0=B5 =D0=B5 =D0=
=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D1=81=D1=8A=D1=81 "
+"=D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=
=89=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=
=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0.\n"
+
+#: lib/commit.tcl:364
+msgid "No changes to commit."
+msgstr "=D0=9D=D1=8F=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=
=B8 =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/commit.tcl:378
+msgid "commit-tree failed:"
+msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B4=D1=8A=D1=80=
=D0=B2=D0=BE=D1=82=D0=BE (commit-tree):"
+
+#: lib/commit.tcl:399
+msgid "update-ref failed:"
+msgstr "=D0=BD=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D0=
=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=83=
=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5 (update-re=
f):"
+
+#: lib/commit.tcl:492
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "=D0=A3=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D0=BE=D0=B4=D0=
=B0=D0=B2=D0=B0=D0=BD=D0=B5 %s: %s"
+
+#: lib/branch_delete.tcl:16
+msgid "Delete Branch"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=BD=
"
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D0=BD=D0=B8 =D0=BA=D0=BB=D0=BE=D0=
=BD=D0=B8"
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5, =D1=81=
=D0=B0=D0=BC=D0=BE =D0=B0=D0=BA=D0=BE =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=
=BD=D0=B8=D1=82=D0=B5 =D1=81=D0=B0 =D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D0=B8=
 =D0=B4=D1=80=D1=83=D0=B3=D0=B0=D0=B4=D0=B5"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "=D0=9D=D0=B5 =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8 =D0=B2 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=
=82=D0=B5 =D1=81=D0=B0 =D1=81=D0=BB=D0=B5=D1=82=D0=B8 =D0=B2 %s:"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D1=82=D1=80=D0=
=B8=D0=B5=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B8:\n"
+"%s"
+
+#: lib/blame.tcl:73
+msgid "File Viewer"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B3=D0=BB=D0=B5=D0=B4 =D0=BD=D0=B0 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5"
+
+#: lib/blame.tcl:79
+msgid "Commit:"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5:"
+
+#: lib/blame.tcl:280
+msgid "Copy Commit"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/blame.tcl:284
+msgid "Find Text..."
+msgstr "=D0=A2=D1=8A=D1=80=D1=81=D0=B5=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=82=
=D0=B5=D0=BA=D1=81=D1=82=E2=80=A6"
+
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr "=D0=9A=D1=8A=D0=BC =D1=80=D0=B5=D0=B4=E2=80=A6"
+
+#: lib/blame.tcl:297
+msgid "Do Full Copy Detection"
+msgstr "=D0=9F=D1=8A=D0=BB=D0=BD=D0=BE =D1=82=D1=8A=D1=80=D1=81=D0=B5=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=
"
+
+#: lib/blame.tcl:301
+msgid "Show History Context"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BE=D1=82=
 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
+
+#: lib/blame.tcl:304
+msgid "Blame Parent Commit"
+msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=BE=D1=82=D0=
=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/blame.tcl:466
+#, tcl-format
+msgid "Reading %s..."
+msgstr "%s =D1=81=D0=B5 =D1=87=D0=B5=D1=82=D0=B5=E2=80=A6"
+
+#: lib/blame.tcl:594
+msgid "Loading copy/move tracking annotations..."
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B0=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8=D1=82=D0=B5 =D0=B7=
=D0=B0 =D0=BF=D1=80=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D0=B2=D0=B0=D0=BD=
=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE/=D0=BF=D1=80=D0=B5=D0=BC=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D0=BD=D0=
=B5=D1=82=D0=BE=E2=80=A6"
+
+#: lib/blame.tcl:614
+msgid "lines annotated"
+msgstr "=D1=80=D0=B5=D0=B4=D0=B0 =D0=B0=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=
=B0=D0=BD=D0=B8"
+
+#: lib/blame.tcl:806
+msgid "Loading original location annotations..."
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B0=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8=D1=82=D0=B5 =D0=B7=
=D0=B0 =D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BD=
=D0=BE=D1=82=D0=BE =D0=BC=D0=B5=D1=81=D1=82=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=
=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=E2=80=A6"
+
+#: lib/blame.tcl:809
+msgid "Annotation complete."
+msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=
=BE =D0=B7=D0=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8."
+
+#: lib/blame.tcl:839
+msgid "Busy"
+msgstr "=D0=9E=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F=D1=82=D0=B0 =D0=
=BD=D0=B5 =D0=B5 =D0=B7=D0=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8=D0=BB=D0=B0=
"
+
+#: lib/blame.tcl:840
+msgid "Annotation process is already running."
+msgstr "=D0=92 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D1=82=D0=B5=
=D1=87=D0=B5 =D0=BF=D1=80=D0=BE=D1=86=D0=B5=D1=81 =D0=BD=D0=B0 =D0=B0=D0=
=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5."
+
+#: lib/blame.tcl:879
+msgid "Running thorough copy detection..."
+msgstr "=D0=98=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D1=8F=D0=B2=D0=B0 =D1=81=D0=
=B5 =D1=86=D1=8F=D0=BB=D0=BE=D1=81=D1=82=D0=B5=D0=BD =D0=BF=D1=80=D0=BE=
=D1=86=D0=B5=D1=81 =D0=BD=D0=B0 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D0=B2=D0=
=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=
=D0=B5=E2=80=A6"
+
+#: lib/blame.tcl:947
+msgid "Loading annotation..."
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B0=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8=E2=80=A6"
+
+#: lib/blame.tcl:1000
+msgid "Author:"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
+
+#: lib/blame.tcl:1004
+msgid "Committer:"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=BB:"
+
+#: lib/blame.tcl:1009
+msgid "Original File:"
+msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=B5=D0=BD =D1=84=D0=B0=D0=B9=D0=BB:"
+
+#: lib/blame.tcl:1057
+msgid "Cannot find HEAD commit:"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=
=B7=D0=B0 =D0=B2=D1=80=D1=8A=D1=85 HEAD =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=
=D0=B5 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D0=B5:"
+
+#: lib/blame.tcl:1112
+msgid "Cannot find parent commit:"
+msgstr "=D0=A0=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B5=
 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=D1=
=82=D0=BA=D1=80=D0=B8=D1=82=D0=BE"
+
+#: lib/blame.tcl:1127
+msgid "Unable to display parent"
+msgstr "=D0=A0=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8F=D1=82 =D0=BD=D0=
=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BF=
=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD"
+
+#: lib/blame.tcl:1269
+msgid "Originally By:"
+msgstr "=D0=9F=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BD=D0=BE =D0=BE=D1=82:"
+
+#: lib/blame.tcl:1275
+msgid "In File:"
+msgstr "=D0=92=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB:"
+
+#: lib/blame.tcl:1280
+msgid "Copied Or Moved Here By:"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=BE =D0=B8=D0=BB=D0=
=B8 =D0=BF=D1=80=D0=B5=D0=BC=D0=B5=D1=81=D1=82=D0=B5=D0=BD=D0=BE =D1=82=
=D1=83=D0=BA =D0=BE=D1=82:"
+
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "=D0=98=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D1=8A=D1=82 =D0=BD=D0=B5 =
=D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=D1=
=82=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD."
+
+#: lib/index.tcl:17
+msgid "Index Error"
+msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: lib/index.tcl:19
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BE=D0=B1=D0=
=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B8=D0=BD=
=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=BD=D0=B0 Git. =D0=90=D0=B2=D1=82=D0=BE=
=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=89=D0=B5 =D0=B7=D0=B0=D0=
=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=D0=B0 =D0=BF=D1=80=D0=BE=
=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 "
+"=D0=B7=D0=B0 =D1=81=D0=B8=D0=BD=D1=85=D1=80=D0=BE=D0=BD=D0=B8=D0=B7=D0=
=B8=D1=80=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 git-gui."
+
+#: lib/index.tcl:30
+msgid "Continue"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B4=D1=8A=D0=BB=D0=B6=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5"
+
+#: lib/index.tcl:33
+msgid "Unlock Index"
+msgstr "=D0=9E=D1=82=D0=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
+
+#: lib/index.tcl:298
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "=D0=98=D0=B7=D0=B2=D0=B0=D0=B6=D0=B4=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 %s =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE"
+
+#: lib/index.tcl:337
+msgid "Ready to commit."
+msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BD=D0=BE=D1=81=D1=82 =D0=B7=D0=
=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5."
+
+#: lib/index.tcl:350
+#, tcl-format
+msgid "Adding %s"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B0 =
=E2=80=9E%s=E2=80=9C"
+
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=
=D1=82 =D0=BB=D0=B8 %d =D0=BD=D0=B0 =D0=B1=D1=80=D0=BE=D0=B9 =D0=BD=D0=B5=
=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=
 =D0=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0?"
+
+#: lib/index.tcl:428
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=BC=D0=B0=D1=85=D0=BD=D0=B0=D1=82=
 =D0=BB=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=
=B2=D1=8A=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C?"
+
+#: lib/index.tcl:430
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "=D0=94=D0=B0 =D1=81=D0=B5 =D0=BC=D0=B0=D1=85=D0=BD=D0=B0=D1=82=
 =D0=BB=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=
=B2 =D1=82=D0=B5=D0=B7=D0=B8 %i =D1=84=D0=B0=D0=B9=D0=BB=D0=B0?"
+
+#: lib/index.tcl:438
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=
=BD=D0=B8, =D0=BA=D0=BE=D0=B8=D1=82=D0=BE =D0=BD=D0=B5 =D1=81=D0=B0 =D0=
=B1=D0=B8=D0=BB=D0=B8 =D0=B2=D0=BA=D0=B0=D1=80=D0=B0=D0=BD=D0=B8 =D0=B2=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0, =D1=89=D0=B5 =D0=B1=D1=8A=D0=
=B4=D0=B0=D1=82 =D0=B1=D0=B5=D0=B7=D0=B2=D1=8A=D0=B7=D0=B2=D1=80=D0=B0=D1=
=82=D0=BD=D0=BE "
+"=D0=B7=D0=B0=D0=B3=D1=83=D0=B1=D0=B5=D0=BD=D0=B8."
+
+#: lib/index.tcl:441
+msgid "Do Nothing"
+msgstr "=D0=9D=D0=B8=D1=89=D0=BE =D0=B4=D0=B0 =D0=BD=D0=B5 =D1=81=D0=B5=
 =D0=BF=D1=80=D0=B0=D0=B2=D0=B8"
+
+#: lib/index.tcl:459
+msgid "Reverting selected files"
+msgstr "=D0=9C=D0=B0=D1=85=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=B2 =D0=B8=D0=B7=D0=B1=D1=
=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=
=B5"
+
+#: lib/index.tcl:463
+#, tcl-format
+msgid "Reverting %s"
+msgstr "=D0=9C=D0=B0=D1=85=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=B2 =E2=80=9E%s=E2=80=9C"
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D0=BE=D1=
=82=D0=BE"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "=D0=A1=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D0=BE=D1=82=D0=BE (=
%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "=D0=94=D1=80=D1=83=D0=B3=D0=BE"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=B8 =D0=BE=D1=82 Git: %s"
+
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BD=D0=B5=D0=BF=D0=B0=D0=BA=D0=B5=D1=
=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "=D0=94=D0=B8=D1=81=D0=BA=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=
=81=D1=82=D1=80=D0=B0=D0=BD=D1=81=D1=82=D0=B2=D0=BE =D0=B7=D0=B0=D0=B5=D1=
=82=D0=BE =D0=BE=D1=82 =D0=BD=D0=B5=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=
=D1=80=D0=B0=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=D1=
=80=D0=B0=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "=D0=91=D1=80=D0=BE=D0=B9 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8"
+
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "=D0=94=D0=B8=D1=81=D0=BA=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=
=81=D1=82=D1=80=D0=B0=D0=BD=D1=81=D1=82=D0=B2=D0=BE =D0=B7=D0=B0=D0=B5=D1=
=82=D0=BE =D0=BE=D1=82 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=D1=80=D0=B0=
=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8"
+
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "=D0=9F=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D0=
=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8 =D0=B7=D0=B0 =D0=BE=D0=BA=D0=B0=D1=81=
=D1=82=D1=80=D1=8F=D0=BD=D0=B5"
+
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5 =D0=B7=D0=B0 =D0=B1=
=D0=BE=D0=BA=D0=BB=D1=83=D0=BA=D0=B0"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=
=D0=B0=D0=BD=D0=BD=D0=B8 =D0=B7=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=
=B8=D1=82=D0=B5"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =
=D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D0=BD=D0=
=B8 =D0=B7=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D1=81=
 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 fsck-obje=
cts"
+
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"=D0=92 =D1=82=D0=BE=D0=B2=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=
=B8=D1=89=D0=B5 =D0=B2 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=B8=
=D0=BC=D0=B0 =D0=BA=D1=8A=D0=BC %i =D0=BD=D0=B5=D0=BF=D0=B0=D0=BA=D0=B5=
=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=
=2E\n"
+"\n"
+"=D0=97d =D0=B4=D0=BE=D0=B1=D1=80=D0=B0 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=
=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=D1=81=D1=82 =D1=81=
=D0=B5 =D0=BF=D1=80=D0=B5=D0=BF=D0=BE=D1=80=D1=8A=D1=87=D0=B2=D0=B0 =D0=
=B4=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D1=
=82=D0=B5 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=
=D0=BD=D0=B8 =D0=B7=D0=B0 "
+"=D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5.\n"
+"\n"
+"=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =
=D0=BB=D0=B8 =D0=BA=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=
=D0=BD=D0=B5=D1=82=D0=BE?"
+
+#: lib/error.tcl:20 lib/error.tcl:116
+msgid "error"
+msgstr "=D0=B3=D1=80=D0=B5=D1=88=D0=BA=D0=B0"
+
+#: lib/error.tcl:36
+msgid "warning"
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5"
+
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D0=BC=D0=BE=D0=B6=
=D0=B5=D1=82=D0=B5 =D0=B4=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B4=D0=B5=D1=
=82=D0=B5, =D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=B5=D1=82=D0=B5 =D0=B3=D0=BE=
=D1=80=D0=BD=D0=B8=D1=82=D0=B5 =D0=B3=D1=80=D0=B5=D1=88=D0=BA=D0=B8."
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merg=
e.\n"
+msgstr ""
+"=D0=9F=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D0=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=
=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=
=B6=D0=B5 =D0=B4=D0=B0 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=A2=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=B2=D1=
=8A=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=
=8F=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5, =D0=
=BF=D1=80=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=
=D0=BD=D0=B5=D1=82=D0=B5 "
+"=D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=BE =D1=83=D1=81=D1=82=D0=
=B0=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD=D0=BE=D1=82=D0=BE =D1=81=D1=8A=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=BE=D1=82=D0=B3=D0=BE=
=D0=B2=D0=B0=D1=80=D1=8F =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0 =D0=B2 =D1=
=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5=D1=82=D0=BE.\n"
+"\n"
+"=D0=9D=D1=8F=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3 =D0=BF=D1=80=D0=
=BE=D1=86=D0=B5=D1=81 =D0=B7=D0=B0 Git =D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=D0=
=B5=D0=BD=D0=B8=D0=BB =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=
=B5=D1=82=D0=BE =D0=BC=D0=B5=D0=B6=D0=B4=D1=83=D0=B2=D1=80=D0=B5=D0=BC=D0=
=B5=D0=BD=D0=BD=D0=BE. =D0=A1=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5=D1=82=D0=BE "
+"=D1=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=
=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B5=D0=BD=D0=BE, =D0=BF=D1=80=
=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D1=81=D0=B5 =D0=B8=D0=B7=D0=B2=D1=8A=D1=
=80=D1=88=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=D0=BE =D1=
=89=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=BD=D0=BE=D0=B2=
=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0.\n"
+"\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"=D0=92 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D1=82=D0=B5=D1=87=D0=
=B5 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BD=D0=BE =D0=B8=D0=BC=
=D0=B0 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8.\n"
+"\n"
+"=D0=9F=D0=BE=D0=B3=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D1=82=D0=B5 =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0 =E2=80=9E%s=E2=80=9C.\n"
+"\n"
+"=D0=A2=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=BA=D0=BE=D1=80=D0=
=B8=D0=B3=D0=B8=D1=80=D0=B0=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=
=B8=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D0=B2 =D0=BD=D0=B5=D0=B3=D0=BE, =D0=B4=
=D0=B0 =D0=B3=D0=BE =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D0=B5 =D0=
=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D0=B8 =D0=B4=
=D0=B0 "
+"=D0=B7=D0=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D1=82=D0=B5=D0=
=BA=D1=83=D1=89=D0=BE=D1=82=D0=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=
=B5 =D1=87=D1=80=D0=B5=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=
=D0=B5. =D0=A7=D0=B0=D0=BA =D1=82=D0=BE=D0=B3=D0=B0=D0=B2=D0=B0 =D0=BC=D0=
=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5=
=D1=82=D0=B5 =D0=BD=D0=BE=D0=B2=D0=BE "
+"=D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doin=
g so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"=D0=92 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D1=82=D0=B5=D1=87=D0=
=B5 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+"\n"
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8A=D1=82 =E2=80=9E%s=E2=80=9C =D0=B5 =D0=BF=
=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD.\n"
+"\n"
+"=D0=A2=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=B2=D1=
=8A=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=BE=D1=
=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5, =D0=BF=D1=80=
=D0=B5=D0=B4=D0=B8 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=
=B5=D1=82=D0=B5 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5. =D0=A2=D0=B0=
=D0=BA=D0=B0 =D1=89=D0=B5 "
+"=D0=BC=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BB=D0=B5=D1=81=D0=BD=D0=BE =D0=
=B4=D0=B0 =D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=
=B8=D1=82=D0=B5 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE,=
 =D0=B0=D0=BA=D0=BE =D0=B2=D1=8A=D0=B7=D0=BD=D0=B8=D0=BA=D0=BD=D0=B5 =D0=
=BD=D1=83=D0=B6=D0=B4=D0=B0.\n"
+
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s =D0=BE=D1=82 =D0=BE=D0=B1=D1=89=D0=BE %s"
+
+#: lib/merge.tcl:122
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "=D0=A1=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =E2=80=
=9E%s=E2=80=9C =D0=B8 =E2=80=9E%s=E2=80=9C=E2=80=A6"
+
+#: lib/merge.tcl:133
+msgid "Merge completed successfully."
+msgstr "=D0=A1=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=B7=D0=
=B0=D0=B2=D1=8A=D1=80=D1=88=D0=B8 =D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=
=BE."
+
+#: lib/merge.tcl:135
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =E2=80=94 =D0=B8=D0=BC=D0=B0 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B8 =D0=B7=D0=B0 =D0=BA=D0=BE=
=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D0=BD=D0=B5."
+
+#: lib/merge.tcl:160
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "=D0=A1=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B2 =E2=80=9E%s=E2=
=80=9C"
+
+#: lib/merge.tcl:179
+msgid "Revision To Merge"
+msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B7=D0=B0 =D1=81=D0=BB=
=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/merge.tcl:214
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"=D0=9F=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5=D1=82=D0=BE =D0=
=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5=
 =D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD=
=D0=BE.\n"
+"\n"
+"=D0=A2=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=B4=D0=B0 =D0=B7=D0=B0=D0=B2=D1=
=8A=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D0=
=BA=D0=B0=D1=82=D0=B0 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B2=D0=B0 =D0=BF=D0=BE=
=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5.\n"
+
+#: lib/merge.tcl:224
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be=
 lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"=D0=94=D0=B0 =D1=81=D0=B5 =D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=
=BD=D0=BE=D0=B2=D0=B8 =D0=BB=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=
=D0=B5=D1=82=D0=BE?\n"
+"\n"
+"=D0=92 =D1=82=D0=B0=D0=BA=D1=8A=D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=
=B9 *=D0=92=D0=A1=D0=98=D0=A7=D0=9A=D0=98* =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=
 =D1=89=D0=B5 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B1=D0=B5=D0=B7=D0=B2=D1=
=8A=D0=B7=D0=B2=D1=80=D0=B0=D1=82=D0=BD=D0=BE =D0=B7=D0=B0=D0=B3=D1=83=D0=
=B1=D0=B5=D0=BD=D0=B8.\n"
+"\n"
+"=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=
=D0=B2=D0=B8 =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE?"
+
+#: lib/merge.tcl:230
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost=
=2E\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D1=82 =
=D0=BB=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5?\n"
+"\n"
+"=D0=92 =D1=82=D0=B0=D0=BA=D1=8A=D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=
=B9 *=D0=92=D0=A1=D0=98=D0=A7=D0=9A=D0=98* =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=
=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=
 =D1=89=D0=B5 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=B1=D0=B5=D0=B7=D0=B2=D1=
=8A=D0=B7=D0=B2=D1=80=D0=B0=D1=82=D0=BD=D0=BE =D0=B7=D0=B0=D0=B3=D1=83=D0=
=B1=D0=B5=D0=BD=D0=B8.\n"
+"\n"
+"=D0=9D=D0=B0=D0=B8=D1=81=D1=82=D0=B8=D0=BD=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=
=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D1=82 =D0=BF=D1=80=
=D0=BE=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5?"
+
+#: lib/merge.tcl:241
+msgid "Aborting"
+msgstr "=D0=9F=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=
=8F=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#: lib/merge.tcl:241
+msgid "files reset"
+msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D1=81=D1=8A=D1=81 =D0=B7=D0=B0=
=D0=BD=D1=83=D0=BB=D0=B5=D0=BD=D0=B8 =D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=BD=
=D0=B8"
+
+#: lib/merge.tcl:269
+msgid "Abort failed."
+msgstr "=D0=9D=D0=B5=D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D1=
=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=
=BD=D0=B5."
+
+#: lib/merge.tcl:271
+msgid "Abort completed.  Ready."
+msgstr "=D0=A3=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=BF=D1=80=D0=B5=D1=
=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5. =
=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BD=D0=BE=D1=81=D1=82 =D0=B7=D0=B0 =D1=
=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=B0=D1=89=D0=BE =D0=B4=D0=B5=D0=B9=D1=81=D1=
=82=D0=B2=D0=B8=D0=B5."
--=20
1.8.4.2
