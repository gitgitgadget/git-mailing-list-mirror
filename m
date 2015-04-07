From: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] gitk: Update Bulgarian translation (304t)
Date: Tue,  7 Apr 2015 18:33:58 +0300
Message-ID: <1428420838-28295-2-git-send-email-ash@kambanaria.org>
References: <1428420838-28295-1-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 17:34:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfVWF-00028U-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 17:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbbDGPeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 11:34:19 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35272 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbDGPeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 11:34:16 -0400
Received: by wgyo15 with SMTP id o15so49297957wgy.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 08:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=A7uQzmJU6a/BNd30UhkBF19s5VGCt4OEoGPhjf8OPiw=;
        b=NX2g9zXrV+HS4QF2Rz1vqvqyGqG6uYG1t99lO4n8FXoyAQdKEBqIpITfJgw2eWXbTR
         TwUIURB9SKOeWRvpdMMMsdRvJtU5RdIKHhUNzuFmGUdZF51eX07z3t5sygNOx36fP27f
         PMT5gEVYatRatQpP05B4uao+97wKADHZSwpvm9up8qEHJFTmae72ujMJqlll0NH7vySU
         AYRY2KxvXc7L/t2dRVO6qSSvsBHOKplTB2kvjyP8wmiYSDeaKhtf7gqdfWVu+shf8fvS
         mkQFueaLOsEGVjHP9+wD/1tFcOwAxhGb4pWs6yuFiK+Ylp8l5B47asePU7wHPz+F9kkr
         D/eg==
X-Gm-Message-State: ALoCoQmQPmV7+8GoGaDRwCVOH0LDZhcDDr1RaMhRRKiQp1E5J5VkMx6hDX4wMcZ36fqRnUFD+EFn
X-Received: by 10.194.81.104 with SMTP id z8mr40387415wjx.45.1428420855316;
        Tue, 07 Apr 2015 08:34:15 -0700 (PDT)
Received: from dalgonosko.lan (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id go4sm5245173wib.1.2015.04.07.08.34.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 08:34:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428420838-28295-1-git-send-email-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266921>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 1df0716..ddc8e73 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,15 +1,15 @@
 # Bulgarian translation of gitk po-file.
-# Copyright (C) 2014 Alexander Shopov <ash@kambanaria.org>.
+# Copyright (C) 2014, 2015 Alexander Shopov <ash@kambanaria.org>.
 # This file is distributed under the same license as the git package.
-# Alexander Shopov <ash@kambanaria.org>, 2014.
+# Alexander Shopov <ash@kambanaria.org>, 2014, 2015.
 #
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-03-15 14:37+1100\n"
-"PO-Revision-Date: 2014-07-28 07:32+0300\n"
+"POT-Creation-Date: 2015-04-07 07:49+0300\n"
+"PO-Revision-Date: 2015-04-07 07:54+0300\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -415,7 +415,7 @@ msgstr "<Right>, x, l\t=D0=9D=D0=B0=D0=BF=D1=80=D0=B5=
=D0=B4 =D0=B2 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
 #: gitk:3053
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr ""
+msgstr "<%s-n>\t=D0=9A=D1=8A=D0=BC n-=D1=82=D0=B8=D1=8F =D1=80=D0=BE=D0=
=B4=D0=B8=D1=82=D0=B5=D0=BB =D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=B2 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F=D1=82=D0=B0"
=20
 #: gitk:3054
 msgid "<PageUp>\tMove up one page in commit list"
@@ -593,7 +593,7 @@ msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8 =D0=B8=D0=B7=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=D1=82=D0=BE =D0=BD=D0=B0 =E2=80=9Egit blame=E2=80=9C: %s"
 #: gitk:3921
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
-msgstr "=D0=A2=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4 =D0=B8=D0=B4=D0=B2=
=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE %s,  =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D0=B5 =D0=B2=
 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
+msgstr "=D0=A2=D0=BE=D0=B7=D0=B8 =D1=80=D0=B5=D0=B4 =D0=B8=D0=B4=D0=B2=
=D0=B0 =D0=BE=D1=82 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE %s, =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BD=D0=B5 =D0=B5 =D0=B2=
 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
=20
 #: gitk:3935
 msgid "External diff viewer failed:"
@@ -649,12 +649,11 @@ msgstr "=D0=A1=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=
=BD=D0=B5:"
=20
 #: gitk:4068
 msgid "Matches all Commit Info criteria"
-msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BA=D0=BE=D1=8F =D0=B4=D0=B0 =D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=
=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=85=D0=B0=D1=80=D0=B0=
=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8 =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
 #: gitk:4069
-#, fuzzy
 msgid "Matches none Commit Info criteria"
-msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BA=D0=BE=D1=8F =D0=B4=D0=B0 =D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=
=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
+msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BD=D0=B8=D0=BA=D0=BE=D1=8F =D0=BE=D1=82 =D1=85=D0=B0=D1=80=
=D0=B0=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8=D1=82=
=D0=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE"
=20
 #: gitk:4070
 msgid "Changes to Files:"
--=20
2.1.0
