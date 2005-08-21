From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a new extended SHA1 syntax <name>:<num>
Date: Sun, 21 Aug 2005 11:37:39 -0700
Message-ID: <7vr7cngmq4.fsf@assigned-by-dhcp.cox.net>
References: <7vll2viq05.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508212025350.15353@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 23:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6xLi-0006Bz-OJ
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVHUV1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVHUV1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:27:24 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50891 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751131AbVHUV1X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 17:27:23 -0400
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LIc97m000968
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 11:38:10 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050821183741.KFBK12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 Aug 2005 14:37:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508212025350.15353@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 21 Aug 2005 20:26:35 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This might confuse some people with the <src>:<dest> notation of the 
> renaming fetch...

True.  How about using a tilde '~'?
