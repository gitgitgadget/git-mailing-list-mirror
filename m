From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 1/5] l10n: add new members to German translation team
Date: Fri,  4 May 2012 21:48:22 +0200
Message-ID: <1336160906-20708-2-git-send-email-ralf.thielow@googlemail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri May 04 21:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOUl-00076o-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556Ab2EDTsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:48:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62404 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544Ab2EDTsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:48:46 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so138033wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7C9Q/9r7jQw6IlGwWl4Faz5t9Xujtt+An7OhFdi3qcE=;
        b=scczQW5l2vN+Gb7qqiDh/sVTaUrLgNntgvi1okBjeQiDDF3+cFtRrUsdEwzw4tPmxD
         mNxyUWyxzr5wo4SOD4GUVA7Lh1Lqtn6rj7aWhdrDoTscjugmQqrQ8Zgc8QkyN/tFGqyI
         FLKN5AVFdsxsCqXWzKytUW4d+cc9JD4wrr5dVUXugVbPuR86FOoE1ZzLGaX8LaaaWyDi
         j/oJglXM6Wbbps79wQuTI9oJuInjEgMwecu/lhVkdrebgqtrg1MIqMbymzu1QaOVZNCt
         6cBY8LTApuj9VxBumYHyKpYjuOBJ6rPemwyEqtivQoVZyZBRHnDpVxCjUq3WJ4ARSxCO
         /PHA==
Received: by 10.180.79.135 with SMTP id j7mr15608525wix.19.1336160925799;
        Fri, 04 May 2012 12:48:45 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id 6sm3408902wiz.1.2012.05.04.12.48.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.72.g0dc6d
In-Reply-To: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197063>

Add Thomas Rast, Jan Kr=C3=BCger and Christian Stimming
to German translation team.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/TEAMS |    3 +++
 1 Datei ge=C3=A4ndert, 3 Zeilen hinzugef=C3=BCgt(+)

diff --git a/po/TEAMS b/po/TEAMS
index 4515f57..cd3440e 100644
--- a/po/TEAMS
+++ b/po/TEAMS
@@ -8,6 +8,9 @@ Leader:		Byrial Jensen <byrial@vip.cybercity.dk>
 Language:	de (German)
 Repository:	https://github.com/ralfth/git-po-de
 Leader:		Ralf Thielow <ralf.thielow@googlemail.com>
+Members:	Thomas Rast <trast@student.ethz.ch>
+		Jan Kr=C3=BCger <jk@jk.gs>
+		Christian Stimming <stimming@tuhh.de>
=20
 Language:	is (Icelandic)
 Leader:		=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
--=20
1.7.10.72.g0dc6d
