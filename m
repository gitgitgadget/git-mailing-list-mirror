From: Junio C Hamano <junkio@cox.net>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 16:59:27 -0700
Message-ID: <7voeb5qwio.fsf@assigned-by-dhcp.cox.net>
References: <428E5102.60003@pobox.com>
	<Pine.LNX.4.58.0505201626560.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505201641160.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:59:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZHO5-0006T0-Am
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVETX7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVETX7k
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:59:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60289 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261610AbVETX7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 19:59:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520235928.YTJJ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 19:59:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201641160.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 16:51:00 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> (to which the beavis-and-butthead in me says "hehhehhehh.. He said fqua.  
LT> Hehhehh. fire fire fire.")

Earlier this week I've sent out a "Request for Help" listing
some janitorial work, on which this was one of the item.  I
believe Jeff suggested use of argp over GNU getopt(), but other
than that I do not think we had any volunteers (hint hint).  I
haven't looked into any of the RFH items myself yet.

