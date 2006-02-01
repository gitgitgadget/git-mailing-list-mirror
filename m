From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to use git for Linux kernel development ?
Date: Wed, 1 Feb 2006 15:38:42 -0500
Message-ID: <20060201203842.GB5900@fieldses.org>
References: <200602011238.44188.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Oke-0007W5-Dr
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWBAUiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAUiu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:38:50 -0500
Received: from mail.fieldses.org ([66.93.2.214]:3000 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932453AbWBAUit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 15:38:49 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F4OkU-0001yd-My; Wed, 01 Feb 2006 15:38:42 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Content-Disposition: inline
In-Reply-To: <200602011238.44188.laurent.pinchart@tbox.biz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15444>

On Wed, Feb 01, 2006 at 12:38:44PM +0100, Laurent Pinchart wrote:
> I have no idea how to layout my git repository to work on day-to-day 
> development. I need to :
> 
> - commit bug fixes, external patches and internal modifications to a branch 
> (or possibly on separate branches depending on what I commit if needed). The 
> work will be based on Linux kernel 2.6.15 but I'd like to stay up-to-date 
> with the master repository as much as possible.
> - push bug fixes upstream by creating a patchset and submitting it by email.
> - pull changes from upstream and merge them in my various branches when the 
> upstream versions become stable enough.
> - keep branches for all the versions shipped to the customers for bug fixes.
> 
> I'm the only developer working on the Linux kernel in my company, but that 
> might change in a few months, so other developers will need to use git as 
> well.
> 
> Is git able to accomodate my needs ?

Those certainly sound like the kinds of things it's meant for.

> I've been trying to setup a git repository with a few branches over
> the last two days, but I always had to throw everything away and start
> back from zero. I haven't been able to figure out which branches I
> should create and how I should use them.

Maybe you could be more specific about the problems you've had?

--b.
