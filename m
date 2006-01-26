From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH 1/2] [CLEANUP] remove unneeded header
Date: Thu, 26 Jan 2006 12:25:44 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126112544.GB7706@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 26 12:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F25G8-0001kO-T7
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 12:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWAZLZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 06:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWAZLZq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 06:25:46 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:20644 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932300AbWAZLZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 06:25:45 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F25G4-0000ew-E9
	for git@vger.kernel.org; Thu, 26 Jan 2006 12:25:44 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0QBPiWp008395
	for <git@vger.kernel.org>; Thu, 26 Jan 2006 12:25:44 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0QBPi65008394
	for git@vger.kernel.org; Thu, 26 Jan 2006 12:25:44 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15159>

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 mailsplit.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

435f396a46d9bd29a9465573f028cdfbddc3c7d6
diff --git a/mailsplit.c b/mailsplit.c
index 14c1358..c529e2d 100644
--- a/mailsplit.c
+++ b/mailsplit.c
@@ -11,7 +11,6 @@
 #include <sys/stat.h>
 #include <string.h>
 #include <stdio.h>
-#include <assert.h>
 #include "cache.h"
 
 static const char git_mailsplit_usage[] =
-- 
1.1.4.g3e6c

-- 
Uwe Zeisberger

http://www.google.com/search?q=gravity+on+earth%3D
