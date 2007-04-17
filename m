From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Tue, 17 Apr 2007 09:36:52 -0400
Message-ID: <20070417133652.GC11907@fieldses.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <20070416181352.GB29569@xp.machine.xx> <20070416182749.GG23764@fieldses.org> <20070417050704.GA19925@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 15:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdnrd-0003xm-J7
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbXDQNgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbXDQNgy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:36:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54805 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbXDQNgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:36:53 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdnrY-0003iH-8l
	for git@vger.kernel.org; Tue, 17 Apr 2007 09:36:52 -0400
Content-Disposition: inline
In-Reply-To: <20070417050704.GA19925@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44765>

On Tue, Apr 17, 2007 at 07:07:04AM +0200, Peter Baumann wrote:
> On Mon, Apr 16, 2007 at 02:27:49PM -0400, J. Bruce Fields wrote:
> > On Mon, Apr 16, 2007 at 08:13:52PM +0200, Peter Baumann wrote:
> > > I'll do this gitk jump very often, too. Just to get the big picture where my
> > > branches are (inside the commit graph). As they stay normaly on the tip, I
> > > exit gitk long before it reached the root commit. What I'd like to have is
> > > something which shows me _visually_ the the branches, e.g.
> > > 
> > > master
> > > | next			commit comment for next
> > > o  |		commit comment for master~1
> > > |  o			commit comment for next~1
> > > o  |	[ ... guess whats next :-)		you get the idea ...]
> > > |  o
> > > |  |
> > > o /
> > > |
> > 
> > git show-branch?
> > 
> > --b.
> 
> No. git-show-branch produces output like the snippet below, which is totally
> non obious to me. Yes, I could figure out what it means, but why the hell
> _should_ I if there are tools for which you have to look just for a second
> on the ouput to _fully_ understand whats happening?

Yeah, I find it pretty opaque too.--b.
