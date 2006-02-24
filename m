From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 16:57:27 -0500
Message-ID: <20060224215727.GL15970@fieldses.org>
References: <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org> <87d5hpvc8p.wl%cworth@cworth.org> <7vu0b1pntl.fsf@assigned-by-dhcp.cox.net> <87zmkhrf4y.wl%cworth@cworth.org> <43FED93D.1000601@op5.se> <87oe0wrg29.wl%cworth@cworth.org> <Pine.LNX.4.63.0602242246430.11479@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:57:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkwU-0001d6-9F
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWBXV5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWBXV5f
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:57:35 -0500
Received: from mail.fieldses.org ([66.93.2.214]:4268 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932593AbWBXV5f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 16:57:35 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FCkwJ-0006DG-N0; Fri, 24 Feb 2006 16:57:27 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602242246430.11479@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16744>

On Fri, Feb 24, 2006 at 10:48:46PM +0100, Johannes Schindelin wrote:
> git-seek shares so many characteristics with git-seek, you could make 
> git-seek just another command line option to checkout (like "--temporary" 
> and "--go-back").

Well, as a user interface, git-seek seems a bit simpler (e.g., easier to
remember).--b.
