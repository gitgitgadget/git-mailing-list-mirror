From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 18:12:37 -0700
Message-ID: <20050419011236.GA22091@kroah.com>
References: <20050419001126.GB21170@kroah.com> <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org> <20050419004548.GA21623@kroah.com> <1113871951.3579.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhFM-0007Do-A3
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDSBNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDSBNV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:13:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:56550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261249AbVDSBNG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:13:06 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3J1Cui25866;
	Mon, 18 Apr 2005 18:12:56 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNhI5-5kr-00; Mon, 18 Apr 2005 18:12:37 -0700
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113871951.3579.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 10:52:30AM +1000, David Woodhouse wrote:
> On Mon, 2005-04-18 at 17:45 -0700, Greg KH wrote:
> > Well Russell has stated that he has to for EU Privacy reasons.  And I'd
> > like to do it as I don't have a local suse.de hostname for my laptop and
> > my employer probably doesn't really want my greg@dunce.kroah.org address
> > showing up :)
> 
> Why not? Do they complain that we see 'greg@dunce.kroah.org' when you
> connect to an IRC server?

No, this employer seems quite sane :)
However, irc connections are as "real" as a kernel changelog message to
a lot of people.

> This _isn't_ an email address, and doesn't really need to be treated
> as such. 

Ok, then why display it as one?  Seriously, it doesn't really bother me,
just added it as I thought others would need it.  I know the "shortlog"
program can pick the real names out of the Signed-off-by: lines.

But I'll wait for Russell to wake up and start quoting the proper EU
privacy laws that he feels causes him to be forced to obfuscate his
email addresses in the changelog commits (as he did for the bk ones.)

thanks,

greg k-h
