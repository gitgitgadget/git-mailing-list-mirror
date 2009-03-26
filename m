From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Grammar fix for "git merge" man page
Date: Thu, 26 Mar 2009 10:39:04 +0100
Message-ID: <1238060344-15265-1-git-send-email-win@wincent.com>
References: <20090326022006.GB5835@coredump.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 10:41:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmm5p-0006PG-Rp
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbZCZJkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZCZJkO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:40:14 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:59521 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZCZJkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:40:13 -0400
Received: from localhost.localdomain (179.pool85-53-16.dynamic.orange.es [85.53.16.179])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2Q9d5Am012867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Mar 2009 05:39:07 -0400
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <20090326022006.GB5835@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114756>

As spotted by the eagle eyes of Jeff King.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-merge.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 427ad90..c04ae73 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -40,7 +40,7 @@ include::merge-options.txt[]
 include::merge-strategies.txt[]
 
 
-If you tried a merge which resulted in a complex conflicts and
+If you tried a merge which resulted in complex conflicts and
 want to start over, you can recover with 'git-reset'.
 
 CONFIGURATION
-- 
1.6.2.1
