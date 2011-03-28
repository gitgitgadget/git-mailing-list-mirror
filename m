From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 02/10] Docs: git tag: peoples back -> people's backs
Date: Mon, 28 Mar 2011 14:40:09 +0000
Message-ID: <1301327622-8595-3-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:54:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Elz-0004Dy-Vy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab1C1Py1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab1C1Py0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:26 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=ioRuHaIADIwYWNMpGK1KeUIjiuQcXH2oXY1dX0apJZk=;
        b=l/OtCrrSU/ocAYAUAP8bdjI2oBCTfKGWdgpeGXFG5MupBbR+/Sis9AGU1KvPC5DNyH
         otNTwiErqIfHqLmdmYRauu3JDAe5sTcgbSp363yvJf8zDJsigwLL85PYwePkzXJ4Pn61
         0CcU68Miik69tzbxCs6tvXx08x3c8olrbCGcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=dNAlaLUQi8qhSI2hLzWqZe9RahtHo6FC42vzASEnO85sVwtsJxkmfT+xjGtiw/MvUg
         /4YSYc75ZWfxtnVfttGHxfzVvMViUHTan2i7pYApfYnnOQqoWVWencHFPRG7R8oESqZP
         O+tKi1w4CQlscYExBX8Pas/oIoK8TAmatuFGY=
Received: by 10.14.48.7 with SMTP id u7mr1832919eeb.221.1301327666170;
        Mon, 28 Mar 2011 08:54:26 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170140>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7844ff1..e276393 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -169,7 +169,7 @@ Sorry for the inconvenience.
 ------------
 
 Does this seem a bit complicated?  It *should* be. There is no
-way that it would be correct to just "fix" it behind peoples
+way that it would be correct to just "fix" it behind people's
 backs. People need to know that their tags might have been
 changed.
 
-- 
1.7.4.18.g68fe8
