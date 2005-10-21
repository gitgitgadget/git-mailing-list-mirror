From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH Cogito] Fix README asciidoc formatting
Date: Fri, 21 Oct 2005 03:18:21 +0200
Message-ID: <20051021011821.GD30889@pasky.or.cz>
References: <20051002105601.GB9934@diku.dk> <20051011214318.GY22079@pasky.or.cz> <20051012142223.GA29333@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 03:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESlYV-0000Ti-76
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 03:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVJUBSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 21:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVJUBSX
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 21:18:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42423 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750889AbVJUBSX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 21:18:23 -0400
Received: (qmail 32426 invoked by uid 2001); 21 Oct 2005 03:18:21 +0200
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20051012142223.GA29333@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10403>

Dear diary, on Wed, Oct 12, 2005 at 04:22:23PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Petr Baudis <pasky@suse.cz> wrote Tue, Oct 11, 2005:
> > Dear diary, on Sun, Oct 02, 2005 at 12:56:01PM CEST, I got a letter
> > where Jonas Fonseca <fonseca@diku.dk> told me that...
> > > BTW, what about adding some notatation info for those boxes? It looks
> > > very creative for an introduction document.
> > 
> > What do you mean by "notation info"?
> 
> I mean some kind of explanatory caption accompanying the ASCII
> illustrations. At least I lack an explanation of what you mean
> by '<' in
> 
> 	+--------+
> 	$ branch <
> 	+--------+
> 
> If you could please "massage that gently into my frontal cortex" I would
> be very happy.

'<' denotes the head, it might be possible to deduce from

		+--------+
		|  master<
		$  origin<
		$ r-unoji<
		$upmirror|
		+--------+

	Note that 'upmirror' has no head associated, it has just the
	"remote branch" ...

but I added explicit explanation.

> Also you use '<-M-' for merging? Why not use '<-U- for updating instead
> of '< < < <'.

Good point, changed that to <-F- (it's a fetch).

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
