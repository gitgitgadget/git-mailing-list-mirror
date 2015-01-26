From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typo
Date: Mon, 26 Jan 2015 19:16:55 +0100
Message-ID: <1422296215-4095-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bebe@bebehei.de, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 19:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFoDq-0001sz-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 19:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbbAZSRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2015 13:17:09 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:44773 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbbAZSRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 13:17:08 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so8926wid.2
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=QE6ShPbfPVCLaQcizhS30sVZCBobAKD6/TX3uBHwFbg=;
        b=f33HIlsEbEJfgLuoz2SNcNo3Ghdb3XgA7I+dvvUo3SVafVmTq3IzGUlFzmRNZ+QTuN
         WLgTvseQFMWq1/mmSAb4LsGpIEmw+EOO2zg10zwQTY6iM9TWbd6YzRkTlyDw+A9F36Gd
         whWBmkWo8I6K/jal2lquGnTL8uewbQnGopUZQRmB2zwvDv4OsDLayCwwtF5UlIKcR0V/
         pdn6hk65p6eOZuZiwZAtM0flP8MTgUkjdIOQHViOsCs86VolbB4ZF1a1M/2E7qPZq5Er
         yxheeVscQmIV2tfRvXt8ULDF6fL04xnyB63zWlsFn6AyjU+yv/epDdy6CpIgKtITQ5C8
         BDgw==
X-Received: by 10.194.108.202 with SMTP id hm10mr48045726wjb.72.1422296226655;
        Mon, 26 Jan 2015 10:17:06 -0800 (PST)
Received: from localhost (dslb-088-073-235-175.088.073.pools.vodafone-ip.de. [88.73.235.175])
        by mx.google.com with ESMTPSA id dn2sm14916527wib.14.2015.01.26.10.17.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Jan 2015 10:17:06 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.218.gc1bb7d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263039>

=46rom: Benedikt Heine <bebe@bebehei.de>

Signed-off-by: Benedikt Heine <bebe@bebehei.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index b2d4639..596f486 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4295,8 +4295,8 @@ msgstr ""
 "    git config --global user.name \"Ihr Name\"\n"
 "    git config --global user.email ihre@emailadresse.de\n"
 "\n"
-"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diesen Commit "
-"=C3=A4ndern mit:\n"
+"Nachdem Sie das getan haben, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=
=BCr diesen Commit "
+"=C3=A4ndern:\n"
 "\n"
 "    git commit --amend --reset-author\n"
=20
--=20
2.3.0.rc1.218.gc1bb7d0
