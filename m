From: Jeff King <peff@peff.net>
Subject: [PATCH] RelNotes/2.0.0: fix typo
Date: Mon, 28 Apr 2014 23:56:51 -0400
Message-ID: <20140429035651.GA13022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WezAB-0007Pt-3E
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbaD2D4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:56:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:40947 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754537AbaD2D4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:56:53 -0400
Received: (qmail 10308 invoked by uid 102); 29 Apr 2014 03:56:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 22:56:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 23:56:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247519>

Signed-off-by: Jeff King <peff@peff.net>
---
I read through the whole thing and didn't notice any other corrections.
Feel free to just squash this in if you are doing other changes to the
file. :)

 Documentation/RelNotes/2.0.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.txt
index ffd4899..a748a92 100644
--- a/Documentation/RelNotes/2.0.0.txt
+++ b/Documentation/RelNotes/2.0.0.txt
@@ -179,7 +179,7 @@ Unless otherwise noted, all the fixes since v1.9 in the maintenance
 track are contained in this release (see the maintenance releases'
 notes for details).
 
- * The remote-helepr interface to fast-import/fast-export via the
+ * The remote-helper interface to fast-import/fast-export via the
    transport-helper has been tightened to avoid leaving the import
    marks file from a failed/crashed run, as such a file that is out of
    sync with the reality confuses a later invocation of itself.
-- 
1.9.1.656.ge8a0637
