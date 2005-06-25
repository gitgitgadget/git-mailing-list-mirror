From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Fix oversimplified optimization for
 add_cache_entry().
Date: Fri, 24 Jun 2005 19:40:40 -0700
Message-ID: <7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 04:34:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm0Ur-0006aY-AA
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 04:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbVFYCkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 22:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbVFYCkq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 22:40:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5526 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S263288AbVFYCkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 22:40:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625024042.BSTX19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Jun 2005 22:40:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 24 Jun 2005 17:57:24 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I really don't want to do this. 
LT> Can you fix the "optimized" one instead?

Will do.

