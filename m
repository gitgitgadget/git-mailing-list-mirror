From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 14:18:17 -0400
Message-ID: <20071025181817.GD31888@fieldses.org>
References: <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org> <1193335339.4522.398.camel@cacharro.xalalinux.org> <20071025180451.GA6349@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Federico Mena Quintero <federico@novell.com>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7IA-00031o-OQ
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbXJYSSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbXJYSSX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:18:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43899 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbXJYSSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:18:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Il7He-0004l9-1N; Thu, 25 Oct 2007 14:18:18 -0400
Content-Disposition: inline
In-Reply-To: <20071025180451.GA6349@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62346>

On Thu, Oct 25, 2007 at 08:04:51PM +0200, Mike Hommey wrote:
> On Thu, Oct 25, 2007 at 01:02:19PM -0500, Federico Mena Quintero wrote:
> > On Thu, 2007-10-25 at 11:21 -0400, Theodore Tso wrote:
> > 
> > > And of course it's inelegant.  You just told us we were dealing with
> > > CVS-brain-damaged corporate developers who can't be bothered to learn
> > > about the fine points of using things the git way.
> > 
> > Ignore the corporate developers who use SCMs only because their company
> > requires them to.  Git is not the right thing for them; some
> > Eclipse-based monstrosity probably is.  It's like the horrendous
> > Oracle-based expense-reporting thing we have to use at Novell; I use it
> > because they make me, not because I'm particularly excited about
> > reporting expenses :)
> > 
> > However, *do think* of the free software developers who have been using
> > CVS forever.  You won't make friends among them if you keep saying, "you
> > use CVS?  You are brain-damaged, then."  CVS has been as good/bad to
> > them as to anyone else, and they are probably delighted to get a better
> > solution.  That solution needs to take into account the concepts to
> > which they have been exposed for the past N years.  Just because your
> > new concepts are better, doesn't mean that their old ones were wrong in
> > their time.
> 
> It's probably just a matter of writing a "git for CVS users" document.

First google hit for "git for CVS users":

	http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html

patches welcomed....

--b.
