From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Remove the period after the git-check-attr summary
Date: Fri,  7 Nov 2008 04:26:55 -0800
Message-ID: <1226060815-7548-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 14:18:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyRDx-0005k2-8m
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 14:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYKGNQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 08:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYKGNQv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 08:16:51 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:33126 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbYKGNQu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 08:16:50 -0500
X-Greylist: delayed 2973 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2008 08:16:50 EST
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1KyQQY-0003AQ-Cn; Fri, 07 Nov 2008 04:27:05 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1KyQQS-0001y6-0b; Fri, 07 Nov 2008 04:26:56 -0800
X-Mailer: git-send-email 1.5.6.5
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100312>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
The period at the end of the git-check-attr summary causes there to be
two periods after the summary in the git(1) manual page, so remove it.

 Documentation/git-check-attr.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 256659a..8c2ac12 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -3,7 +3,7 @@ git-check-attr(1)
 
 NAME
 ----
-git-check-attr - Display gitattributes information.
+git-check-attr - Display gitattributes information
 
 
 SYNOPSIS
-- 
1.5.6.5
