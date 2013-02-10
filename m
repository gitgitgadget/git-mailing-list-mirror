From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 13/15] user-manual: Fix 'you - Git' -> 'you--Git' typo
Date: Sun, 10 Feb 2013 10:10:39 -0500
Message-ID: <2dcb9e398e933cfa29eab8b406b2a4bb0206d8c5.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZU-0000h4-FL
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215Ab3BJPLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:37 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:49287 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759010Ab3BJPLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:20 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0000U0FIEJT30@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:17 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0228F8792A5; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509062; bh=8FDML73oSABVrNEgUz+bAotgIRwc1cdMRKkfLsqe0kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=Cc8qNpRxlR6iYCM4WyaSQQTqdJs3tN0jR8gsDi0OjR4I9iiiFdRIt/l15ptR2eOBY
 /IpAe3SrV8RutUpShbvqmZ/HCgxh+Tsrq4jd/Fv9zucOec8qpZXhajIxzyxFCPX0Yh
 t6WQEiiRgBalHL6cd0LeSTrUftnG6g3vQAHKxQTM=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215914>

From: "W. Trevor King" <wking@tremily.us>

Use an em-dash, not a hyphen, to join these clauses.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6446791..dbd0143 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3436,7 +3436,7 @@ $ git log --raw --all
 ------------------------------------------------
 
 and just looked for the sha of the missing object (4b9458b..) in that
-whole thing. It's up to you - Git does *have* a lot of information, it is
+whole thing. It's up to you--Git does *have* a lot of information, it is
 just missing one particular blob version.
 
 [[the-index]]
-- 
1.8.1.336.g94702dd
