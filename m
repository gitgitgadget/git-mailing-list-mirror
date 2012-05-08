From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 05/10] l10n: add new members to German translation team
Date: Tue,  8 May 2012 19:33:40 +0200
Message-ID: <1336498425-17890-6-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJ7-00029S-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab2EHRei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37448 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2EHRec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:32 -0400
Received: by wibhn19 with SMTP id hn19so437604wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c2jtTjMTOGPC1bB7RT8tkVtiNwdJbRyKrjKoA4kTxAo=;
        b=sNpN09IDSFk2AMNagZ+z0cDaUcRJ14zcpdEojUa8gpwP8MFq3rBjjAqXg2/wWooaZS
         c5+OBRjHaK1gq7kqYr65IOGCnVbtTTe6JFwCmZH/ZidC9jh255GNOyIQHUGvPQ+pF8xN
         4CvdGKv9gpII9aj4eQQAd1vM0xvXCFFyl1d9uIoXnutI/HCBVpRodWyMOGzYZ7ksRHBp
         H3uoMGI7slSejRDPSmn5om0V8p6XE7zm21jfolslpDk13HvE/z4ZIgBbIVvy/hoRzrKC
         S3Mz3zWJ1yipsUTOXt8+SQLNlHUrtLOwMcRU0Aw6IeJLOBJu6PnLJrqqxST5KjsI0VTm
         RONQ==
Received: by 10.216.143.200 with SMTP id l50mr11281225wej.58.1336498470986;
        Tue, 08 May 2012 10:34:30 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197404>

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
1.7.10.129.g1ec31a3
