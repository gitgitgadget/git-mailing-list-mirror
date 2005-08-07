From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk SHA link hovers
Date: Sun, 7 Aug 2005 22:04:14 +1000
Message-ID: <17141.63678.126439.379030@cargo.ozlabs.ibm.com>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<17140.47152.672091.474748@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508061056200.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff Epler <jepler@unpythonic.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 14:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1juc-0004V3-R3
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 14:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbVHGMFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 08:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbVHGMFq
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 08:05:46 -0400
Received: from ozlabs.org ([203.10.76.45]:65478 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751764AbVHGMFq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 08:05:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4720467F1E; Sun,  7 Aug 2005 22:05:45 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508061056200.3258@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> This makes the cursor change when you hover over a SHA1 link with the new 
> "hypertext" gitk commit ID linking feature.

I committed something based on this but with extra stuff to make the
cursor changes work with the change from the normal cursor to the
watch cursor and back.

Paul.
