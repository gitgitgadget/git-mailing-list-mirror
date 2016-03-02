From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: add space to abbreviation "z. B."
Date: Wed,  2 Mar 2016 18:30:02 +0100
Message-ID: <1456939802-6171-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 18:30:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAbV-0007fZ-G0
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbcCBRaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:30:10 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33559 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbcCBRaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:30:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id l68so90435685wml.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i847pWREmuR44QUV90dS/18eLC4Dl+EzdZdj8e70XME=;
        b=o6hsdITQZJVSgCjrOxFo/6eFVOyaClyb0l34stNMKheweeutTbzDrNIUWlMGaJhu89
         VDiOS/58xAwPdPxc9Ub101TWWOrDEWi/ssxa1Ykk8iPNhlr639MFrhg/m67na8/Qg8u4
         7mm/1CQv/br0PwqfR5JKeQ+bhS9hrvgrpHlfm2R37ehaGjouqt2G+6KBis5g6Zbxzlri
         Xf0epz9S8S0SjmgX0+z29lZq/pLiovnn+StcU8smEgUHMLhU66VYPufHeYLLZmZfRNGh
         UNDwJ1xpsTyZ1CIitw6jbH0oaRn+eGkbWj5iRD30BPKudH8x4WFPvVk5BI9EPNR84jUI
         20ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i847pWREmuR44QUV90dS/18eLC4Dl+EzdZdj8e70XME=;
        b=YptnUJOsVNhQCHun0+meb8usnr3aZyfGkMK9rHMCcArbZcqMKHBphIOgMdsVRTTMZO
         KiLqODHvbUENubfTxvlzX2jWzt8McNn+7LH3E0CeHwS2n6BD3Ul5EJIvbwN/KHUPuPW9
         g6CvLvnybZFgsJQYmQfU8IIlao+I8uX2cNlnN/PXB0SzaONzg4zpSzvsVCYMsZ6T4PEO
         TBPGil0qt46INJsbvV7Qsc1kc5Uf1fVgymsGAgy690gqpUCyBx5eQ7VvIXhZyxdZN8m6
         7M2qfaJ8UzdhE3oNFblsB/DGk+s/bngcORQxEdzLjh1N/wkeDsyzBEA80YZ2oUeu+kn0
         oYhA==
X-Gm-Message-State: AD7BkJKs+K+KDIT9XGzIOw3Mun3jiiW+cOEpEHWWce6m3OMV8+8b8ctdGrJrCmXlwONhMA==
X-Received: by 10.28.223.69 with SMTP id w66mr1138118wmg.89.1456939807448;
        Wed, 02 Mar 2016 09:30:07 -0800 (PST)
Received: from localhost (cable-94-139-5-136.cust.telecolumbus.net. [94.139.5.136])
        by smtp.gmail.com with ESMTPSA id k84sm350976wmc.18.2016.03.02.09.30.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 09:30:06 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.140.gf92f5fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288133>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index 8c5f05d..0c38d36 100644
--- a/po/de.po
+++ b/po/de.po
@@ -9145,7 +9145,7 @@ msgid ""
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor Sie=
 \"push\"\n"
+"die externen =C3=84nderungen zusammen (z. B. 'git pull ...') bevor Si=
e \"push\"\n"
 "erneut ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
@@ -9160,7 +9160,7 @@ msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Checken Sie\n"
 "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen zu=
sammen\n"
-"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
+"(z. B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -9177,7 +9177,7 @@ msgstr ""
 "die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch ein=
en \"push\" "
 "von\n"
 "Commits auf dieselbe Referenz von einem anderen Repository aus verurs=
acht.\n"
-"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git "
+"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z. B. 'git "
 "pull ...')\n"
 "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
--=20
2.8.0.rc0.140.gf92f5fe
