From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Many gits are offline this week
Date: Sun, 7 Oct 2007 15:04:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710071457580.23070@iabervon.org>
References: <20071005010448.GQ2137@spearce.org> <863awq5p1y.fsf@blue.stonehenge.com>
 <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com>
 <86tzp54sez.fsf@blue.stonehenge.com> <20071007170153.GX2137@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IebQG-0005n9-02
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 21:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXJGTEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbXJGTEG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 15:04:06 -0400
Received: from iabervon.org ([66.92.72.58]:39663 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359AbXJGTEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 15:04:05 -0400
Received: (qmail 9470 invoked by uid 1000); 7 Oct 2007 19:04:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2007 19:04:03 -0000
In-Reply-To: <20071007170153.GX2137@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60211>

On Sun, 7 Oct 2007, Shawn O. Pearce wrote:

> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> > >>>>> "Paolo" == Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:
> > 
> > Paolo> is there any material (slides, docs) you can share before the talks?
> > 
> > I've had the slides reviewed by Smarter People Than Me on #git already, so
> > hopefully most of it is accurate. :)  They're temporarily at
> > 
> >   http://www.stonehenge.com/pic/Git-2.0.3-to-be.pdf
> > 
> > I still hope to have a few hours to go in and add a few sadly missing
> > graphics, particularly on the rebase vs merge section.
> 
> What, no mention of git-gui as a porcelain?  It has more users
> than qgit according to the survey.  Maybe rephrase the porcelains
> on slide 15 as:
> 
>   Other porcelain exists:
>     - StGit ("stacked git"), guilt
>     - tig (curses-based viewer)
>     - qgit, git-gui

For that matter, gitweb is essentially a limited porcelain. And this 
points out that all VCSes have alternative porcelains, but git is unusual 
in having convenient plumbing to support and encourage this.

	-Daniel
*This .sig left intentionally blank*
