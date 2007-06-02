From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix git-am(1) synopsis formatting
Date: Sat, 2 Jun 2007 19:56:44 +0200
Message-ID: <20070602175644.GA19952@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 20:03:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuXx4-0001PG-SC
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 20:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760616AbXFBSDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760895AbXFBSDk
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 14:03:40 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:42925 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760616AbXFBSDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 14:03:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0F020968106;
	Sat,  2 Jun 2007 20:03:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xnM4-c6JacL; Sat,  2 Jun 2007 20:03:37 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4007B77009C;
	Sat,  2 Jun 2007 19:56:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1187A6DFB62; Sat,  2 Jun 2007 19:54:38 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 22AF162A5D; Sat,  2 Jun 2007 19:56:44 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48940>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-am.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 7658fbd..f3387f5 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,6 @@ SYNOPSIS
          [--3way] [--interactive] [--binary]
          [--whitespace=<option>] [-C<n>] [-p<n>]
          <mbox>|<Maildir>...
-
 'git-am' [--skip | --resolved]
 
 DESCRIPTION
-- 
1.5.2.816.gc5560-dirty

-- 
Jonas Fonseca
