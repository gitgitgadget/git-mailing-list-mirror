From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Summer of Code '07 application
Date: Fri, 9 Mar 2007 10:39:34 -0500
Message-ID: <20070309153934.GA1131@spearce.org>
References: <20070308050746.GA29778@spearce.org> <20070309022118.GC32211@spearce.org> <20070309060128.GC5026@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 16:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPhC4-000838-Iy
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 16:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbXCIPjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 10:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXCIPjj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 10:39:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60447 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030453AbXCIPji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 10:39:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPhBr-0005uF-Fj; Fri, 09 Mar 2007 10:39:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE40920FBAE; Fri,  9 Mar 2007 10:39:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070309060128.GC5026@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41799>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Mar 08, 2007 at 09:21:18PM -0500, Shawn O. Pearce wrote:
> > I have updated the wiki with the final draft, and taken into account
> > the copy editing that people were trying to do last night in parallel
> > with me overwriting their changes all of the time.  ;-)
> 
> I see a few more minor language fixes--do you want them by wiki or
> email?

Wiki would probably just be quicker.  Feel free to edit away.
 
> > ''' Describe your organization. '''
> 
> The first paragraph (in particular, first sentence) is a little
> generic--couldn't it mostly apply to all of the GSoC projects?  You
> might turn it around and start with the second paragraph, which is stuff
> only git can boast of:
> 
> 	As Git approaches its second anniversary, it is now the revision
> 	control system of choice for many of the largest and most
> 	succesful open source projects, including the Linux kernel and
> 	at least 5 Google Summer of Code 2006 projects: One Laptop Per
> 	Child, Tangram, The Wine Project, XMMS2, and X.org.  Many more
> 	are considering Git adoption.
> 
> 	This achievement is the product of the Git development
> 	community, a loose-knit team of developers, technical writers,
> 	and end users with a passion for high quality open-source
> 	development.

Yes.  Last night when I went to bed I realized I should try to
improve this answer.  I think its one of the more important ones
in the application; we need to show we are looking at GSoC as a
way to attract new talent to the community, not as a way to get
free paid coders for a few months.  GSoC is more about getting
students involved in open source, and keeping them involved.
We all obviously want to attract new talent, and keep them here
once we've got 'em.  ;-)
 
> > ''' Why is your organization applying to participate in GSoC 2007? What
> > do you hope to gain by participating? '''
> 
> Here also maybe leading with the specifics would make it stronger?:
> 
> 	Prior Google Summer of Code projects have asked for new features
> 	in Git, including submodule support (needed by Gentoo) native
> 	Windows port (needed by KDE and The Mozilla Foundation).....

Yes, good...
 
> (Would it be worth listing more examples here, or does the application
> already include a comprehensive list?)

The application has a link to our SoC2007Ideas page, so I don't
think it is worth including all of them here.  Anyone at Google who
is sifting through the applications can easily follow the link to
the ideas page if they want to see what else we are looking to do.
What I was trying to do here was to highlight the fact that last
year Google supported some of these projects, and we are also trying
to support them too, so maybe Google can help us help them.  ;-)
 
> It seems to me that the Git community has been pretty good at attracting
> and mentoring new contributors.  The maintainers have been really
> conscientious about explaining the project architecture and giving
> feedback on contributions.

Also good... I've tried to include this in the answer.

> I'm not sure how to make that really clear, or where to fit it in.
> Maybe in the answer to one of these two?:
> 
> > ''' What steps will you take to encourage students to interact with
> > your project's community before, during and after the program? '''
> 
> > ''' What will you do to ensure that your accepted students stick with
> > the project after GSoC concludes? '''

> I wonder if it'd be easy to come up with some more specifics to support
> these kinds of statements.  Could even point to particular exchanges in
> the mail archives if there's anything short that obviously demonstrates
> the point.  Also I think it's not so much "friendliness" as willingness
> (and ability) to communicate what's important very clearly.

Locating specifics might be good.  I can't think of any off the
top of my head.  Maybe if I went waaaaay back and found some of
my initial emails (Feb 17th timeframe), I could use myself as
an example.  I know I got beat up a bit by Junio about how I did
a bug fix in git-reset.  ;-)

-- 
Shawn.
