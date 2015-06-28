From: ash@kambanaria.org
Subject: [PATCH] gitk: Update Bulgarian translation (307t)
Date: Sun, 28 Jun 2015 23:28:13 +0300
Message-ID: <1435523293-4453-1-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 22:28:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9JCC-0007nD-AZ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbF1U2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2015 16:28:50 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33098 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbF1U2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 16:28:49 -0400
Received: by wiwl6 with SMTP id l6so83079652wiw.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 13:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=gDYThy3GmaPyzHg4sBikYdcmkAv2mRLzRmLe/Dgh2rw=;
        b=irkXqpznYaNi//D5UfbJR8kDSQPQRZOscssMweZ/kqTc+rCvhNGFu7wjGFbZKYc0Nt
         R4X+vpFd5M6S5+eGVpWx/Y7vLjo2oNqXxNKoiGMktaHKNWkKbJ9FZg9ymEte6a3liu3H
         iKn/6eOml0WkTY6zzE9xaUrbFs36lkAensLtyq+v8muoV1MiqpXv5e4oqqzl4swZtGcN
         4ZkwqYR/tEjsssYHR/cd+ztxL3/If5hnahlDopuscqBl0b5u7zyXwNyjnOqkHCH/2K7i
         1iWGP6Kz+O2SO87tBVs4YMpMRpssS2uxRFn0oRPwNhiC4jEvZF/6lSfcvef2avlHDPS0
         vIzw==
X-Gm-Message-State: ALoCoQkaBZY49QVq4HQns4br4FZX7Toa/bDqnipkVu6EfYvF1QX+g5KSZ3ugeKwjxnMSuoFhIKeq
X-Received: by 10.194.11.73 with SMTP id o9mr22910059wjb.116.1435523327813;
        Sun, 28 Jun 2015 13:28:47 -0700 (PDT)
Received: from dalgonosko.lan (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id e4sm13862964wjy.46.2015.06.28.13.28.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2015 13:28:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272925>

=46rom: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index c4246bf..61073eb 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2015-04-07 07:54+0300\n"
+"POT-Creation-Date: 2015-06-27 20:44+0300\n"
+"PO-Revision-Date: 2015-06-27 20:46+0300\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -328,7 +328,7 @@ msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D1=82=D0=BE=D0=B7=D0=B8 =D0=BA=D0=BB=D0=BE=D0=BD=
"
=20
 #: gitk:2649
 msgid "Copy branch name"
-msgstr ""
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=B8=D0=BC=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B0"
=20
 #: gitk:2656
 msgid "Highlight this too"
@@ -348,7 +348,7 @@ msgstr "=D0=90=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=
=D0=BA=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
=20
 #: gitk:2660
 msgid "Copy path"
-msgstr ""
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =
=D0=BF=D1=8A=D1=82=D1=8F"
=20
 #: gitk:2667
 msgid "Show origin of this line"
@@ -507,9 +507,8 @@ msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t=D0=9A=D1=8A=D0=BC =D1=81=D0=BB=D0=B5=D0=B4=D0=B2=D0=
=B0=D1=89=D0=B0=D1=82=D0=B0 =D0=BF=D0=BE=D1=8F=D0=B2=D0=B0"
=20
 #: gitk:3075
-#, fuzzy
 msgid "g\t\tGo to commit"
-msgstr "<End>\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=
=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=
"
+msgstr "g\t\t=D0=9A=D1=8A=D0=BC =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=
=BD=D0=BE=D1=82=D0=BE =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
=20
 #: gitk:3076
 msgid "/\t\tFocus the search box"
@@ -665,9 +664,8 @@ msgid "Matches all Commit Info criteria"
 msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=B2=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=85=D0=B0=D1=80=D0=B0=
=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8 =D0=BD=D0=B0=
 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE"
=20
 #: gitk:4086
-#, fuzzy
 msgid "Matches no Commit Info criteria"
-msgstr "=D0=A1=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE =D0=BD=D0=B8=D0=BA=D0=BE=D1=8F =D0=BE=D1=82 =D1=85=D0=B0=D1=80=
=D0=B0=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8=D1=82=
=D0=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=
=82=D0=BE"
+msgstr "=D0=9D=D0=B5 =D1=81=D1=8A=D0=B2=D0=BF=D0=B0=D0=B4=D0=B0 =D0=BF=
=D0=BE =D0=BD=D0=B8=D0=BA=D0=BE=D1=8F =D0=BE=D1=82 =D1=85=D0=B0=D1=80=D0=
=B0=D0=BA=D1=82=D0=B5=D1=80=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B8=D1=82=D0=
=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=
=D0=BE"
=20
 #: gitk:4087
 msgid "Changes to Files:"
@@ -1350,6 +1348,8 @@ msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
+"=D0=A2=D0=B0=D0=B7=D0=B8 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BD=D0=
=B0 Tcl/Tk =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D1=8A=D1=80=
=D0=B6=D0=B0 =D0=BE=D1=82 Gitk.\n"
+" =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=B0 =D0=B2=D0=
=B8 =D0=B5 =D0=BF=D0=BE=D0=BD=D0=B5 Tcl/Tk 8.4."
=20
 #: gitk:12269
 msgid "Cannot find a git repository here."
@@ -1363,6 +1363,3 @@ msgstr "=D0=9D=D0=B5=D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=
=D0=BD=D0=B0=D1=87=D0=B5=D0=BD =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=
=D1=82 =E2=80=9E%s=E2=80=9C: =D0=B8=D0=BC=D0=B0 =D0=B8 =D1=82=D0=B0=D0=BA=
=D0=B0=D0=B2
 #: gitk:12328
 msgid "Bad arguments to gitk:"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B8 =D0=BD=D0=B0 gitk:"
-
-#~ msgid "mc"
-#~ msgstr "mc"
--=20
2.4.3
