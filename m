From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Last mile for 1.0 again
Date: Mon, 4 Jul 2005 21:54:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507042137300.30848-100000@iabervon.org>
References: <7vmzp2gohc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 03:56:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpcfb-0007e1-NK
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 03:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGEB4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 21:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGEB4G
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 21:56:06 -0400
Received: from iabervon.org ([66.92.72.58]:6663 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261749AbVGEB4D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 21:56:03 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpcdT-0001zp-00; Mon, 4 Jul 2005 21:54:07 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzp2gohc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 4 Jul 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> Junio: what's missing from annotate/blame?
> 
> Which one are you talking about?
> 
> What I use to generate http://members.cox.net/junkio/Summary.txt
> is an implementation of an algorithm I consider "complete" in
> that it does rename/copy and complete rewrite correctly.  What
> is missing from the implementation is efficiency.

[perl script]

> How does this work, and what do we do about merges?

I've got that part, but I'm not clear on how the rename/copy and complete
rewrite stuff works.

	-Daniel
*This .sig left intentionally blank*
