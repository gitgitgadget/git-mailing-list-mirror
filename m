From: Jeff King <peff@peff.net>
Subject: [PATCH] git-am: fix typo in usage message
Date: Mon, 19 May 2008 16:09:06 -0400
Message-ID: <20080519200905.GB23239@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 22:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyBgE-0002Bg-VB
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764285AbYESUJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764282AbYESUJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:09:09 -0400
Received: from peff.net ([208.65.91.99]:3494 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764275AbYESUJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:09:08 -0400
Received: (qmail 4062 invoked by uid 111); 19 May 2008 20:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 19 May 2008 16:09:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2008 16:09:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82444>


Signed-off-by: Jeff King <peff@peff.net>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 75886a8..b48096e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -11,7 +11,7 @@ git-am [options] --skip
 --
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
-b,binary        pass --allo-binary-replacement to git-apply
+b,binary        pass --allow-binary-replacement to git-apply
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
-- 
1.5.5.1.447.g3a459
