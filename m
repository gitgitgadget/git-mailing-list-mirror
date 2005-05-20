From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 09:48:06 -0700
Message-ID: <7vu0kxu9mh.fsf@assigned-by-dhcp.cox.net>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org>
	<7vzmupud54.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 18:48:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZAes-0005o6-9S
	for gcvg-git@gmane.org; Fri, 20 May 2005 18:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVETQsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVETQsR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 12:48:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64964 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261495AbVETQsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 12:48:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520164807.QCZM12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 12:48:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 08:53:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> No, this is wrong.

Understood.  Since I am going to be futzing with diff family,
I'll come up with some more tests while I am at it.


