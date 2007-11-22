From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: fix a typo in lib/commit.tcl
Date: Thu, 22 Nov 2007 16:20:08 +0100
Message-ID: <200711221620.08347.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 16:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvDlh-0000E2-TZ
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 16:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXKVPOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 10:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKVPOs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 10:14:48 -0500
Received: from slim-3c.inet.it ([213.92.5.125]:61590 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbXKVPOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 10:14:47 -0500
Received: from host225-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.225]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.225+WI725J3yBQv; Thu, 22 Nov 2007 16:14:43 +0100
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65827>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 lib/commit.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 5723812..e62201a 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -184,7 +184,7 @@ You must stage at least 1 file before you can commit.
 
 A good commit message has the following format:
 
-- First line: Describe in one sentance what you did.
+- First line: Describe in one sentence what you did.
 - Second line: Blank
 - Remaining lines: Describe why this change is good.
 }
-- 
1.5.3.5
