From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 05/15] Ignore po/*.msg
Date: Sun, 2 Sep 2007 17:31:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021731370.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsMo-0004v8-0X
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbXIBQcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXIBQb7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:31:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:52654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932458AbXIBQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:31:59 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:31:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 02 Sep 2007 18:31:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZLtMMQDVZDpEMFa+L3RdA/nvebIL4HnWiUju5o/
	D5fHWghhrtM2w+
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57352>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/.gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 po/.gitignore

diff --git a/po/.gitignore b/po/.gitignore
new file mode 100644
index 0000000..a89cf44
--- /dev/null
+++ b/po/.gitignore
@@ -0,0 +1,2 @@
+*.msg
+*~
-- 
1.5.3.2.g46909
