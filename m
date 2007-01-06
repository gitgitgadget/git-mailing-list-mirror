From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Sat, 6 Jan 2007 17:52:42 -0500
Message-ID: <20070106225242.GJ4655@fieldses.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87mz51gd7e.wl%cworth@cworth.org> <20070106185836.GH4655@fieldses.org> <200701062048.15163.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 23:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3KP9-0001bW-O2
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXAFWwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 17:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbXAFWwo
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 17:52:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:55696 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbXAFWwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 17:52:44 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3KP4-0006Ml-DY; Sat, 06 Jan 2007 17:52:42 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200701062048.15163.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36103>

On Sat, Jan 06, 2007 at 08:48:15PM +0000, Alan Chandler wrote:
> On Saturday 06 January 2007 18:58, J. Bruce Fields wrote:
> > If we use the word "branches" for things that you can check out and
> > commit to, then "remote-tracking branches" are not actually branches.
> > Argh!
> >
> > What would be better terminology here?
> 
> Why can't we use the terms 'local branch' and 'remote branch'.  We can 
> only commit to local branches - you need to push to remote ones.

We'd have to replace "branch" by "local branch" in a lot of
documentation, but that could work.

Though what do you call a branch in a remote repository then, if not a
remote branch?  I suppose it doesn't matter.

--b.
