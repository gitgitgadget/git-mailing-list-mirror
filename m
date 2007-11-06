From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks/post-receive-email: fix typo
Date: Tue, 6 Nov 2007 13:48:07 +0000
Message-ID: <20071106134807.24270.qmail@b28e45c58f5991.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOmg-0004Hy-TS
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbXKFNrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXKFNrr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:47:47 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:37005 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751327AbXKFNrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:47:47 -0500
Received: (qmail 24271 invoked by uid 1000); 6 Nov 2007 13:48:07 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63677>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2aa9bb5..379cedc 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -30,7 +30,7 @@
 #   This is the list that all pushes of annotated tags will go to.  Leave it
 #   blank to default to the mailinglist field.  The announce emails lists the
 #   short log summary of the changes since the last annotated tag.
-# hook.envelopesender
+# hooks.envelopesender
 #   If set then the -f option is passed to sendmail to allow the envelope sender
 #   address to be set
 #
-- 
1.5.3.5
