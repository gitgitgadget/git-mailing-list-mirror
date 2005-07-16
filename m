From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH-fix] fetch/pull: short-hand notation for remote repositories.
Date: Sat, 16 Jul 2005 10:33:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507161032410.19183@g5.osdl.org>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net> <7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
 <7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
 <7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net> <7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 19:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtqXu-0004oz-Pi
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 19:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGPRdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 13:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGPRdr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 13:33:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbVGPRdq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2005 13:33:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6GHXZjA006531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Jul 2005 10:33:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6GHXUja013291;
	Sat, 16 Jul 2005 10:33:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Jul 2005, Junio C Hamano wrote:
> 
> *** I see you have already merged my broken one; sorry.

I already noticed the breakage, and fixed that a bit differently.

Feel free to send an updated patch if you prefer your version after my 
commits have percolated out..

		Linus
