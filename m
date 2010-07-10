From: Fredrik Skolmli <fredrik@frsk.net>
Subject: [PATCH] Documentation: Spelling fix in protocol-capabilities.txt
Date: Sat, 10 Jul 2010 02:03:40 +0200
Message-ID: <20100710000340.GA17296@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 10 02:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXNvn-0003GR-GH
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 02:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0GJA2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 20:28:30 -0400
Received: from panacea.frsk.net ([92.243.16.10]:45720 "EHLO panacea.frsk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab0GJA23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 20:28:29 -0400
X-Greylist: delayed 1483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2010 20:28:29 EDT
Received: from asterix.samfundet.no
	([129.241.93.108] helo=asterix.frsk.net ident=Debian-exim)
	by panacea.frsk.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1OXNXi-00042B-As; Sat, 10 Jul 2010 02:03:43 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1OXNXg-0007io-VI; Sat, 10 Jul 2010 02:03:41 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 129.241.93.108
X-SA-Exim-Mail-From: fredrik@frsk.net
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on panacea.frsk.net
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=AWL,SPF_PASS autolearn=ham
	version=3.2.5
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on panacea.frsk.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150699>

Date: Sat, 10 Jul 2010 02:00:01 +0200

Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
---
 Documentation/technical/protocol-capabilities.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index fd1a593..b15517f 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -119,7 +119,7 @@ both.
 ofs-delta
 ---------
 
-Server can send, and client understand PACKv2 with delta refering to
+Server can send, and client understand PACKv2 with delta referring to
 its base by position in pack rather than by an obj-id.  That is, they can
 send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
 
-- 
1.7.2.rc2.82.gdab19


-- 
Fredrik Skolmli
