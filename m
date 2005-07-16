From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH-fix] fetch/pull: short-hand notation for remote repositories.
Date: Sat, 16 Jul 2005 10:52:11 -0700
Message-ID: <7vr7dyhc50.fsf@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
	<7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net>
	<7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507161032410.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 19:53:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtqpm-0008GU-RU
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 19:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVGPRwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGPRwO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 13:52:14 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47871 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261775AbVGPRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 13:52:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716175213.GOLI16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 13:52:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507161032410.19183@g5.osdl.org> (Linus Torvalds's message of "Sat, 16 Jul 2005 10:33:30 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I already noticed the breakage, and fixed that a bit differently.
>
> Feel free to send an updated patch if you prefer your version after my 
> commits have percolated out..

As an old timer, I always prefer "case" over "test", so the
version in your tree is actually better to me.  Thanks for the
fix.
