From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n: de.po: translate 2 new messages
Date: Sun, 16 Nov 2014 16:54:17 +0100
Message-ID: <1416153257-2407-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	ralf.thielow@gmail.com, mackyle@gmail.com,
	Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 16:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq29j-0001wx-OT
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 16:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbaKPPyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2014 10:54:21 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:37637 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966AbaKPPyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 10:54:21 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so22956202wgh.40
        for <git@vger.kernel.org>; Sun, 16 Nov 2014 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=i7bL37OjbOBDCpzs6WG7aomZLOfjx1dmtwn356ejGEM=;
        b=NHMNK7ZCfiT4n/qXki0v3iX/5d3/SaJDg65G5RfvBzN72X6zVP/VM0NiFDs56ZK8OY
         2dYy1dUnzpWztLYn2MMHI1TkGYyRPIaATJODkQK/IX1KNM6KIKgdE8dj9jsACdz95bF3
         8NbOnOhOS7xvuaUSIQcIvs24VmZ9QwPYWoJ2g8XOE3uyOOcp59yP/DgGwxo6CMm5FM9V
         sLTFpxNVDYbXLZa40oeQeKaWzZgauotfisVPd5qeleOr19QzRE1tWtyIloZNOTgFBnat
         R5IwF7cI2muvoMMZXFBTZj4ykVyj7LUhC8cnJ5x1Uozvqeq8HNKhRSLu3ccRsGxW9IdE
         lPmQ==
X-Received: by 10.194.109.69 with SMTP id hq5mr32864841wjb.86.1416153259412;
        Sun, 16 Nov 2014 07:54:19 -0800 (PST)
Received: from phillip.fritz.box (i59F45E09.versanet.de. [89.244.94.9])
        by mx.google.com with ESMTPSA id u13sm11554651wiv.10.2014.11.16.07.54.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Nov 2014 07:54:18 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index c807967..5af3f8f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5473,7 +5473,7 @@ msgstr "pr=C3=BCft die Reflogs (Standard)"
=20
 #: builtin/fsck.c:613
 msgid "also consider packs and alternate objects"
-msgstr ""
+msgstr "ziehen Sie au=C3=9Ferdem Pakete und alternative Objekte in Bet=
racht"
=20
 #: builtin/fsck.c:614
 msgid "enable more strict checking"
@@ -8253,7 +8253,7 @@ msgstr "Referenz muss sich auf dem angegebenen We=
rt befinden"
=20
 #: builtin/push.c:495
 msgid "check"
-msgstr ""
+msgstr "=C3=9Cberpr=C3=BCfung"
=20
 #: builtin/push.c:496
 msgid "control recursive pushing of submodules"
--=20
2.1.3
