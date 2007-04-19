From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 10:27:33 -0400
Message-ID: <20070419142733.GC4586@fieldses.org>
References: <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <1176984945.30690.30.camel@cauchy.softax.local> <Pine.LNX.4.64.0704191428360.8822@racer.site> <1176986559.30690.43.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Marcin Kasperski <Marcin.Kasperski@softax.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 16:27:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeXc3-0005JX-2W
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 16:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbXDSO1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbXDSO1k
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 10:27:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50323 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418AbXDSO1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 10:27:39 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HeXbh-0001ij-AC; Thu, 19 Apr 2007 10:27:33 -0400
Content-Disposition: inline
In-Reply-To: <1176986559.30690.43.camel@cauchy.softax.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45024>

On Thu, Apr 19, 2007 at 02:42:39PM +0200, Marcin Kasperski wrote:
> > > I agree that git introduces plenty of excellent concepts. What it needs
> > > is better docs (also, clearly known **SINGLE** master doc, just sth like
> > > subversion book),
> > 
> > Does that mean you are volunteering?
> 
> No, as I do not have necessary knowledge. But I can volunteer to review
> one.

That would be great--see Documentation/user-manual.txt.  (Or
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html.)

Patches welcomed, but so is general review.  It's not my highest
priority, unfortunately, so I may be a little slow to address comments,
but I'll get to them eventually.

I don't expect it to ever be a *single* master doc--I still want to
leave a lot of the details to the man pages, for example, and I expect
there'll always be a need for some shortcut howto's and tutorials.   I
suppose we could include much of that into appendices some day if it
helped findability.

--b.
