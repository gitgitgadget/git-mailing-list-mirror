From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] git homepage
Date: Fri, 5 Aug 2005 11:11:02 +0200
Message-ID: <20050805091102.GA21703@vrfy.org>
References: <20050805012728.GO24479@pasky.ji.cz> <7v64ulqh24.fsf@assigned-by-dhcp.cox.net> <20050805021214.GQ24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 11:16:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0yIs-0007h8-Pa
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 11:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVHEJPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 05:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVHEJMv
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 05:12:51 -0400
Received: from soundwarez.org ([217.160.171.123]:31166 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262920AbVHEJLF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 05:11:05 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 21B12567A9; Fri,  5 Aug 2005 11:11:02 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050805021214.GQ24479@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 05, 2005 at 04:12:14AM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Aug 05, 2005 at 04:00:03AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > Petr Baudis <pasky@ucw.cz> writes:
> > 
> > > 	http://git.or.cz/
> > 
> > Wonderful.
> > 
> > Once the page contents stabilizes, it would be a good idea to
> > get it added in the page top links of http://www.kernel.org/git
> > page.  Sorry, I do not know who is in charge of configuring the
> > gitweb there.
> 
> I tend to harass Kay Sievers, with measurable effects. :-)

You are welcome to do so. :)

> > BTW, it may be technically correct, but the combination of
> > "rsync" and "www" on the 3rd line of http://www.kernel.org/git
> > caught my attention there ;-).
> > 
> >   cg-clone rsync://www.kernel.org/pub/scm/ + project path
> 
> Actually, HTTP should be working again now; but it's rather fresh yet so
> we should keep it rsync anyway for a while yet for the users of older
> GIT/Cogito versions.

Changed both to rsync now. Let me know, when we want to switch to http
again.

Best,
Kay
