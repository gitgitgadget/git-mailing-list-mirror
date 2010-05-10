From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: rename duplicate t4205
Date: Mon, 10 May 2010 05:47:39 -0400
Message-ID: <20100510094739.GA3389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 11:47:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPaT-0001DE-H8
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab0EJJrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:47:42 -0400
Received: from peff.net ([208.65.91.99]:38281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841Ab0EJJrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:47:41 -0400
Received: (qmail 2957 invoked by uid 107); 10 May 2010 09:47:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 05:47:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 05:47:39 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146780>


Signed-off-by: Jeff King <peff@peff.net>
---
On top of by/log-follow. Conflicts with wp/pretty-enhancement in next.

 ...copies.sh => t4206-log-follow-harder-copies.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4205-log-follow-harder-copies.sh => t4206-log-follow-harder-copies.sh} (100%)

diff --git a/t/t4205-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
similarity index 100%
rename from t/t4205-log-follow-harder-copies.sh
rename to t/t4206-log-follow-harder-copies.sh
-- 
1.7.1.248.g52f9c
