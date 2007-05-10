From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] Document 'git-log --decorate'
Date: Thu, 10 May 2007 16:09:38 -0600
Message-ID: <20070510220934.GA13564@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGpZ-0005iv-8T
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901AbXEJWJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbXEJWJl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:09:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60623 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758901AbXEJWJl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 18:09:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1AD0821F150
	for <git@vger.kernel.org>; Thu, 10 May 2007 18:11:41 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 May 2007 18:09:41 -0400
X-Sasl-enc: TEyVyUbPYlSmKm1nNy1OTAr4NmwDHF2tMwWsS07S6V8W 1178834981
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 070541F4CD
	for <git@vger.kernel.org>; Thu, 10 May 2007 18:09:40 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46910>

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 Documentation/git-log.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 49bb539..dd06527 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -51,6 +51,9 @@ include::pretty-formats.txt[]
 	a record about how the tip of a reference was changed.
 	See also gitlink:git-reflog[1].
 
+--decorate::
+    Print out the ref names of any commits that are shown.
+
 <paths>...::
 	Show only commits that affect the specified paths.
 
-- 
1.5.2.rc2
