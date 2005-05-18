From: Petr Baudis <pasky@ucw.cz>
Subject: Re: gitweb wishlist
Date: Wed, 18 May 2005 11:45:46 +0200
Message-ID: <20050518094545.GC25416@pasky.ji.cz>
References: <20050511012626.GL26384@pasky.ji.cz> <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 11:46:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYL7I-00013Y-8x
	for gcvg-git@gmane.org; Wed, 18 May 2005 11:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVERJpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 05:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVERJpz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 05:45:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4992 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262144AbVERJps (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 05:45:48 -0400
Received: (qmail 26624 invoked by uid 2001); 18 May 2005 09:45:46 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 18, 2005 at 04:55:51AM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
> On Wed, 2005-05-11 at 03:26 +0200, Petr Baudis wrote:
> 
> >   I think I would prefer the link from the repository index to go not to
> > the log page, but some "summary" page, which would have some short
> > information about the repository (owner, description, list of branches
> > if gitweb supports that, list of tags, link to the latest tree and link
> > to the log).
> 
> I did this now. The top-link shows now the repository listing with a
> nice "last change" field. The default link points to an overview page
> which also list the tags.
> (The owner filed in that list is not correct until now, cause the
> cron-job needs to be adapted.)

Thanks, this is exactly how I envisioned it. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
