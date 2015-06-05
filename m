From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix translation of "head nodes"
Date: Fri,  5 Jun 2015 19:45:00 +0200
Message-ID: <1433526300-10936-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, tr@thomasrast.ch, jk@jk.gs,
	stimming@tuhh.de, phillip.szelat@gmail.com,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 19:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vgB-0000Yf-6R
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbbFERpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 13:45:10 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33008 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbFERpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:45:09 -0400
Received: by wgez8 with SMTP id z8so62176826wge.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=eFyN4M5S+0a7bqJDOPVl80mNUh+WNC6nMStKPPMLu28=;
        b=ZPwAQ/b5Qd3ski+qkbVlIc5pSDgLZNJPlO0QHqZIjosUcTz14J0XbhFhtno2ZA1jDk
         J6YqyulgAyw6Jxe/U5Gb3abk+qP0Sm9FImcEJEblFTLvcMuYi72yB5pZfFoxOwHYm4Od
         Qk2PUZkiIFImPKBwB5VIBCylRYO07T7XMqoht5CH3n/AcWMB7UIf9ffkugjAmTkNlvRC
         q9FJg3Gwb+iFnhHat2aD4kkMRtJdokmSh/M5x+zGd6Xvqp5b1aHTIUaGbdFDo6CeOE8i
         tZr1ryX0Cs6w5xHkQvaYlCw41/Y/TtO29Pu8wy3vy/F9mcir+9coDLlKDiTG+VsYf97F
         +6yQ==
X-Received: by 10.194.157.168 with SMTP id wn8mr8215909wjb.79.1433526308372;
        Fri, 05 Jun 2015 10:45:08 -0700 (PDT)
Received: from localhost (dslb-092-078-236-214.092.078.pools.vodafone-ip.de. [92.78.236.214])
        by mx.google.com with ESMTPSA id n1sm4280949wix.0.2015.06.05.10.45.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 10:45:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.599.gb39b3fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270868>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7d603c2..945bd13 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5679,11 +5679,11 @@ msgstr "Hauptwurzeln melden"
=20
 #: builtin/fsck.c:613
 msgid "make index objects head nodes"
-msgstr "Objekte in der Staging-Area pr=C3=BCfen"
+msgstr "Index-Objekte in Erreichbarkeitspr=C3=BCfung einbeziehen"
=20
 #: builtin/fsck.c:614
 msgid "make reflogs head nodes (default)"
-msgstr "die Reflogs pr=C3=BCfen (Standard)"
+msgstr "Reflogs in Erreichbarkeitspr=C3=BCfung einbeziehen (Standard)"
=20
 #: builtin/fsck.c:615
 msgid "also consider packs and alternate objects"
--=20
2.4.2.599.gb39b3fc
