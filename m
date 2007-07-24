From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] pretty-options.txt: tiny doc fix
Date: Tue, 24 Jul 2007 20:59:47 +0200
Message-ID: <876449lja4.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 21:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPjg-0000qq-Fk
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 21:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbXGXTHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 15:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755457AbXGXTHm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 15:07:42 -0400
Received: from mx.meyering.net ([82.230.74.64]:58147 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbXGXTHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 15:07:41 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2007 15:07:41 EDT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id EDF3A4DCCE; Tue, 24 Jul 2007 20:59:47 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53631>


Signed-off-by: Jim Meyering <jim@meyering.net>
---
 Documentation/pretty-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 746bc5b..973d8dd 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,9 +1,9 @@
 --pretty[='<format>']::

-	Pretty print the contents of the commit logs in a given format,
+	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
 	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
-	When left out the format default to 'medium'.
+	When omitted, the format defaults to 'medium'.

 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
--
