From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: add missing executable bits
Date: Thu, 20 Oct 2011 17:58:33 -0400
Message-ID: <20111020215833.GA12877@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 23:58:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH0dO-0002An-45
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 23:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab1JTV6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 17:58:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36354
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab1JTV6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 17:58:36 -0400
Received: (qmail 14271 invoked by uid 107); 20 Oct 2011 21:58:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 17:58:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 17:58:33 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184043>


Signed-off-by: Jeff King <peff@peff.net>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t4051-diff-function-context.sh
 mode change 100644 => 100755 t/t9162-git-svn-dcommit-interactive.sh

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
old mode 100644
new mode 100755
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
old mode 100644
new mode 100755
-- 
1.7.7.rc1.28.g5dd2ee
