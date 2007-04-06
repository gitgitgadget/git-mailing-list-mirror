From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 0/5] cvsimport: Improve documentation
Date: Fri,  6 Apr 2007 23:52:38 +0200
Message-ID: <11758963633237-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwMs-0006EF-Tz
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbXDFVxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbXDFVxK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:10 -0400
Received: from mail.lenk.info ([217.160.134.107]:59327 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXDFVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:09 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN2-0006IQ-CH; Fri, 06 Apr 2007 23:53:24 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMk-0001c4-3k; Fri, 06 Apr 2007 23:53:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMN-000385-Sq; Fri, 06 Apr 2007 23:52:43 +0200
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43928>

I played around with git-cvsimport the last days a bit and stumbled
upon a few inconsistencies in the documentation. This patch
series tries to fix them.

 Documentation/git-cvsimport.txt |   79 ++++++++++++++++++++--------------------
 git-cvsimport.perl              |   17 ++++----
 2 files changed, 50 insertions(+), 46 deletions(-)
