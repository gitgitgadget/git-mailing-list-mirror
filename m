From: jidanni@jidanni.org
Subject: [PATCH] Documentation/urls-remotes.txt: Multiple fetch lines are allowed
Date: Tue, 06 Jan 2009 09:06:45 +0800
Message-ID: <87vdstnsyi.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 02:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK0QU-0007ec-G8
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 02:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZAFBGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 20:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZAFBGu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 20:06:50 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:50378
	"EHLO homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752544AbZAFBGt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 20:06:49 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id E159FD2710;
	Mon,  5 Jan 2009 17:06:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104612>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/urls-remotes.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 41ec777..d38f189 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -22,7 +22,7 @@ or even by a manual edit to the `$GIT_DIR/config` file.  The URL of
 this remote will be used to access the repository.  The refspec
 of this remote will be used by default when you do
 not provide a refspec on the command line.  The entry in the
-config file would appear like this:
+config file would appear as below. Multiple fetch lines are allowed.
 
 ------------
 	[remote "<name>"]
-- 
1.6.0.6
