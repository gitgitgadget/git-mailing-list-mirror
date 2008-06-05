From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2 2/2] More informative short description for git-help.txt
Date: Thu,  5 Jun 2008 13:57:05 +0300
Message-ID: <1212663425-20064-2-git-send-email-tlikonen@iki.fi>
References: <20080605105204.GA17979@mithlond.arda.local>
 <1212663425-20064-1-git-send-email-tlikonen@iki.fi>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 12:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4DAX-0007Vt-G5
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbYFEK5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbYFEK5L
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:57:11 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:33843 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754835AbYFEK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:57:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F10058FF9C; Thu, 5 Jun 2008 13:57:06 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4D9V-0005Dy-Eq; Thu, 05 Jun 2008 13:57:05 +0300
X-Mailer: git-send-email 1.5.6.rc1.15.g99b92
In-Reply-To: <1212663425-20064-1-git-send-email-tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83901>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/git-help.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index bfbba9e..4df3791 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -3,7 +3,7 @@ git-help(1)
 
 NAME
 ----
-git-help - display help information about git
+git-help - Display help information about git commands and other topics
 
 SYNOPSIS
 --------
-- 
1.5.6.rc1.17.gfc76f
