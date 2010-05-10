From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: chmod +x t5150
Date: Mon, 10 May 2010 05:51:39 -0400
Message-ID: <20100510095139.GA2098@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 11:51:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPeO-0002rg-9i
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0EJJvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:51:42 -0400
Received: from peff.net ([208.65.91.99]:39672 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab0EJJvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:51:41 -0400
Received: (qmail 3039 invoked by uid 107); 10 May 2010 09:51:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 05:51:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 05:51:39 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146782>


Signed-off-by: Jeff King <peff@peff.net>
---
On top of jn/request-pull in next.

Want me to repost my test-lint patch? :)

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t5150-request-pull.sh

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
old mode 100644
new mode 100755
-- 
1.7.1.248.g52f9c
