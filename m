From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typo
Date: Wed, 11 Jun 2014 18:17:35 +0200
Message-ID: <1402503455-20503-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: henkel@vh-s.de, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 18:17:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WulDk-0002Yp-2D
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 18:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbaFKQRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 12:17:48 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:52903 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbaFKQRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 12:17:47 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so5105166wgg.21
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PFtchxhVFQJDD+b8Wjl+2hu6uYERwTTh8StYB9rstV4=;
        b=J94iN/hQ6Ym8Jl5LWngQRxNNtpcFje3jigKxWunRYsn99T5oGWsJrTCJMi8PbUEIkZ
         qJXs1sVpr9gaZnqSlmDZYV2F7otarIANwKQkfBYO3rRJy5e41ZuHu8HxIkotGlFZ9dZy
         eM8eNJ+MUz0llSz9iORAC/xp3P+WQjjW4KMh7MKDkXzHTCi4zxoHWzRtmIT8HQI/IO0n
         dDf52X+LKD4y3A9xxPvlyoojzUy+XwCQLBOZtm0IPHYV2G6ojlm3qWVyfe5Jg4nywJZP
         HmbtYmxPjsRx9bDQ2n7dBNCV4GR673Jzrr/KDIhbXQME9EWM1RkP9lx1yUQ+83Seo5lu
         nzLw==
X-Received: by 10.180.74.6 with SMTP id p6mr16541731wiv.17.1402503464686;
        Wed, 11 Jun 2014 09:17:44 -0700 (PDT)
Received: from localhost (dslb-088-072-176-011.pools.arcor-ip.net. [88.72.176.11])
        by mx.google.com with ESMTPSA id w9sm60247769eev.4.2014.06.11.09.17.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 09:17:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251373>

Reported-by: Hartmut Henkel
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index b777ef4..88d10ed 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10551,13 +10551,13 @@ msgstr "Bitte committen Sie die =C3=84nderung=
en oder benutzen Sie \"stash\"."
 #: git-rebase.sh:577
 #, sh-format
 msgid "Current branch $branch_name is up to date."
-msgstr "Aktueller Branch $branch_name ist auf dem neusten Stand."
+msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
=20
 #: git-rebase.sh:581
 #, sh-format
 msgid "Current branch $branch_name is up to date, rebase forced."
 msgstr ""
-"Aktueller Branch $branch_name ist auf dem neusten Stand, Rebase erzwu=
ngen."
+"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzw=
ungen."
=20
 #: git-rebase.sh:592
 #, sh-format
--=20
2.0.0.415.g8cd8cf8
