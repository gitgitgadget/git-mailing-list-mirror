From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 22:12:35 -0700
Message-ID: <20050712051235.GA10930@buici.com>
References: <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org> <20050712044352.GA9919@buici.com> <Pine.LNX.4.58.0507112149290.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:14:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsD54-0001vh-Gz
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVGLFNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 01:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVGLFNF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 01:13:05 -0400
Received: from florence.buici.com ([206.124.142.26]:21915 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262364AbVGLFMi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 01:12:38 -0400
Received: (qmail 11096 invoked by uid 1000); 12 Jul 2005 05:12:35 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507112149290.17536@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 09:59:25PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Jul 2005, Marc Singer wrote:
> > 
> > Does it make sense to think about this branch as an flow of commits?
> > Or is it just a starting point for a line of development?
> 
> It's really a flow of commits. Nothing will ever really remember what the 
> starting point was at some later date if you have done commits, and the 
> branch will always follow the _head_ of development on that branch.

That's the important detail.

As an aside, we (a vary large set of developers) have been using SCM
tools for how-many-freakin-years and only now am I seeing something
sane.  Cheers.
