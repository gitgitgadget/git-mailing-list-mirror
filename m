From: Craig Fratrik <cfratrik@gmail.com>
Subject: [PATCH] Noted that vi is the final choice of editor in git help commit
Date: Tue, 13 Jan 2009 14:33:36 -0800
Message-ID: <1231886016-31675-1-git-send-email-cfratrik@gmail.com>
Cc: Craig Fratrik <cfratrik@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 06:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMxu5-0008Ab-DA
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 06:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbZANFBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 00:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbZANFBA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 00:01:00 -0500
Received: from outmail023.snc1.tfbnw.net ([69.63.178.182]:36290 "EHLO
	fallbackmx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750707AbZANFBA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 00:01:00 -0500
X-Greylist: delayed 2043 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 00:00:59 EST
Received: from mx-out.facebook.com ([10.18.255.177])
	by fallbackmx-out.facebook.com [hpfallback009.snc1.facebook.com] (8.13.1/FB.fallback-1.0.0) with ESMTP id n0DMZvaP016553
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:35:57 -0800
Received: from facebook.com ([10.18.255.179])
	by mx-out.facebook.com [email012.ash1.facebook.com] (8.13.7/8.13.6) with ESMTP id n0DMXbOa008834;
	Tue, 13 Jan 2009 14:33:37 -0800
Received: by devrs006.snc1.facebook.com (Postfix, from userid 2001)
	id D7BCD3B006D; Tue, 13 Jan 2009 14:33:36 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.608.ga9645.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105582>

---
 Documentation/git-commit.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b5d81be..1b9e7a5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -318,8 +318,8 @@ ENVIRONMENT AND CONFIGURATION VARIABLES
 ---------------------------------------
 The editor used to edit the commit log message will be chosen from the
 GIT_EDITOR environment variable, the core.editor configuration variable, the
-VISUAL environment variable, or the EDITOR environment variable (in that
-order).
+VISUAL environment variable, the EDITOR environment variable, or finally 'vi'
+(in that order).
 
 HOOKS
 -----
-- 
1.6.0.4.608.ga9645.dirty
