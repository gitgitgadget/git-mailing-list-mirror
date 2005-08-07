From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk "hyperlinks"
Date: Sun, 7 Aug 2005 22:05:24 +1000
Message-ID: <17141.63748.734936.78707@cargo.ozlabs.ibm.com>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<17140.47152.672091.474748@cargo.ozlabs.ibm.com>
	<7vpssr9gd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 14:06:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1jud-0004V3-Ci
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 14:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbVHGMFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 08:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbVHGMFr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 08:05:47 -0400
Received: from ozlabs.org ([203.10.76.45]:455 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751777AbVHGMFq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 08:05:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 50C9F67E2E; Sun,  7 Aug 2005 22:05:45 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpssr9gd1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> I did, and will push it out shortly, but I think you need this
> patch.  To make later merges from you easier, I will not put
> this in my "master" branch.

I have committed this plus the hand cursor for the links plus a small
change to make gitk display commit messages correctly according to the
current locale.

Paul.
