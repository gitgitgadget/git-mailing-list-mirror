From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 17:33:05 -0700
Message-ID: <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
References: <200510162114.27429.blaisorblade@yahoo.it>
	<Pine.LNX.4.64.0510171546580.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 02:33:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERfPv-0001kV-1C
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 02:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVJRAdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVJRAdI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 20:33:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51177 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbVJRAdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 20:33:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018003243.XNX29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 20:32:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10200>

Linus Torvalds <torvalds@osdl.org> writes:

> Yeah, somebody should really fix the command line parsing. 
>
> I think it's only git-checkout-index that _really_ needs fixing, since it 
> has such a fragile thing right now.

Good to hear that you finally said it.

The patch looks good.  Thanks.
