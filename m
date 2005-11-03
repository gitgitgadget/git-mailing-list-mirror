From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 18:30:13 +0100
Message-ID: <20051103173012.GA21428@bohr.gbar.dtu.dk>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103083840.GA28300@ebar091.ebar.dtu.dk> <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 18:31:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXiuq-0002pD-H8
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 18:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVKCRaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 12:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVKCRaR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 12:30:17 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:47841 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751313AbVKCRaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 12:30:16 -0500
Received: (qmail 26160 invoked by uid 5842); 3 Nov 2005 18:30:13 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11078>

On Thu, Nov 03, 2005 at 12:05:42PM -0500, Daniel Barkalow wrote:
> On Thu, 3 Nov 2005, Junio C Hamano wrote:
> 
> > "Peter Eriksen" <s022018@student.dtu.dk> writes:
> > 
> > > Here's one I've done too many times:
> > >
> > > ~/git/git-core]cat .git/remotes/origin
> > > URL: git://git.kernel.org/pub/scm/git/git.git
> > > Pull: master:origin
> > >
> > > ~/git/git-core]git-checkout maint
> > > ~/git/git-core]git pull
> > 
> > You are merging my master into your "maint", probably a copy of
> > my (previous) maint.
> 
> I think the situation is that he really wanted to update master, but 
> forgot that he was on the maint branch. So now he's in a merge of things 
> he didn't actually want to merge and wants to get back to not having junk 
> all over the place (some files that need to be merged, some files that 
> have been merged, new files, removed files, etc).

I really should have stated that from the beginning.  Yes, I forgot, I
had checked out some other branch and thought (the first I times assumed)
that it would merge into master.  So it's really just an accident,
which I would think, is not that uncommon for newcommers.

Peter
