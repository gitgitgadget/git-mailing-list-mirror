From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 2 new messages
Date: Tue, 18 Nov 2014 19:10:46 +0100
Message-ID: <1416334246-28034-1-git-send-email-ralf.thielow@gmail.com>
References: <BEECE0DF-BAE9-4131-89A5-91453E7C04D8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 18 19:11:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqnF1-0002xt-CB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbaKRSKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2014 13:10:55 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62815 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbaKRSKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:10:52 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so6965715wgh.30
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZqgpaDJpYh9h2ID3gewztHBQQfXWuUi8xt1H58wRx3c=;
        b=G/LGc+Yz5o6+O8EffKxVKrkOe7IwnztjYVkWnGEILjwkKvNN3bakHKkehLWZYKXsCc
         9OgCkPG2EgBvLEWq2USjlWEDI6FOgQRUPpqHOHqKHqVR0syMwgW1g/IQ78AkNAv9zwt7
         nFWaRv/vzcXDV7CpyCRvEdSTvH9gqC2CngecunkdsAGDwJZyxcgly9t1n26FpNrOorVY
         D+c2kbWS4+odXa852WM5b5tyKkWkuEt1irHc+oTnEe5XHHn/2hVDNla5qkHNigUH9BFw
         Ik3gOevzVokiUg/gnxrfAb51q9rsgWoTaMwoXLdeOGqi43Akh2jlhHlm3qBhg1O8D7NG
         qE9A==
X-Received: by 10.180.99.163 with SMTP id er3mr41298441wib.18.1416334251334;
        Tue, 18 Nov 2014 10:10:51 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id rx8sm56778576wjb.30.2014.11.18.10.10.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 10:10:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.258.gc851c5b
In-Reply-To: <BEECE0DF-BAE9-4131-89A5-91453E7C04D8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 0597cb2..5ad705b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5638,7 +5638,7 @@ msgstr "die Reflogs pr=C3=BCfen (Standard)"
=20
 #: builtin/fsck.c:615
 msgid "also consider packs and alternate objects"
-msgstr ""
+msgstr "ebenso Pakete und alternative Objekte betrachten"
=20
 #: builtin/fsck.c:616
 msgid "enable more strict checking"
@@ -8460,7 +8460,7 @@ msgstr "Referenz muss sich auf dem angegebenen We=
rt befinden"
=20
 #: builtin/push.c:495
 msgid "check"
-msgstr ""
+msgstr "check|on-demand"
=20
 #: builtin/push.c:496
 msgid "control recursive pushing of submodules"
--=20
2.2.0.rc2.258.gc851c5b
