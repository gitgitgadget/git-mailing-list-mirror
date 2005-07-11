From: Petr Baudis <pasky@suse.cz>
Subject: Re: arch 2.0 first source available (git related)
Date: Tue, 12 Jul 2005 01:31:50 +0200
Message-ID: <20050711233150.GB5981@pasky.ji.cz>
References: <1120867947.5882.2.camel@dev1.seyza.com> <20050709113942.GB26343@pasky.ji.cz> <1120918813.4901.27.camel@dev1.seyza.com> <20050711193944.GA5981@pasky.ji.cz> <1121117816.16511.5.camel@dev1.seyza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 01:37:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds7pG-0006LB-Jf
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVGKXgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVGKXeE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 19:34:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8336 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262280AbVGKXby (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 19:31:54 -0400
Received: (qmail 20958 invoked by uid 2001); 11 Jul 2005 23:31:50 -0000
To: Thomas Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <1121117816.16511.5.camel@dev1.seyza.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 11, 2005 at 11:36:56PM CEST, I got a letter
where Thomas Lord <lord@emf.net> told me that...
> On Mon, 2005-07-11 at 21:39 +0200, Petr Baudis wrote:
> > Dear diary, on Sat, Jul 09, 2005 at 04:20:13PM CEST, I got a letter
> > where Thomas Lord <lord@emf.net> told me that...
> > > The prereq graph is, indeed, an improvement.  
> > ..snip..
> 
> > But object retrieval can be potentially as much as linear to the depth
> > of the prereq graph, right? 
> 
> Potentially but not, by far, in the common case.
> 
> Moreover, that depth is an arbitrary parameter which user's can
> freely vary -- that's part of the point.

But if the depth will be less than that, won't the user end up with some
(plenty) of the objects duplicated?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
