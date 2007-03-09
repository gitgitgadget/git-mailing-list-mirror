From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Summer of Code '07 application
Date: Thu, 8 Mar 2007 21:21:18 -0500
Message-ID: <20070309022118.GC32211@spearce.org>
References: <20070308050746.GA29778@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 03:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPUjZ-0000qi-1I
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 03:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbXCICVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 21:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbXCICVZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 21:21:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42300 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965217AbXCICVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 21:21:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPUjF-0001kx-Dg
	for git@vger.kernel.org; Thu, 08 Mar 2007 21:21:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 03A5E20FBAE; Thu,  8 Mar 2007 21:21:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070308050746.GA29778@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41778>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> I'm drafting the application right now.  It is due March 12th.
> Time is a 'ticking!
> 
> http://git.or.cz/gitwiki/Soc2007Application

I have updated the wiki with the final draft, and taken into account
the copy editing that people were trying to do last night in parallel
with me overwriting their changes all of the time.  ;-)

I would like to thank those who were hacking on the this application
on the Wiki (Jakub and someone else), and Junio, for his useful
comments by email and on IRC last night.

I think the application is ready to go, but I would really appreciate
it if someone else can review it and agree.  ;-)

The notes "({have,need} Google Account)" are just notes to me to
include the Gmail address of each individual when I copy and paste
this into Google's web application.  (I have all of those stored
in a different file.)

---
''' What is your Organization's Name? '''

Git Development Community

''' What is your Organization's Homepage? '''

[http://git.or.cz/]

''' Describe your organization. '''

The Git development community is a loosely knitted team of
developers, documentation writers and end-users with the common goal
of building and maintaining a high quality revision control system.
As an offshoot of the Linux kernel team, we take great pride in
our open development methodology and emphasis on quality.

Git is currently used by at least 5 of the GSoC 2006 projects
(One Laptop Per Child, Tangram, The Wine Project, XMMS2, X.org),
not to mention the Linux kernel, and in the past year has been (or
is still being) considered for conversion by at least another 6
(FreeBSD Project, Gentoo, KDE, OpenOffice.org, OpenSolaris, The
Mozilla Foundation).

''' Why is your organization applying to participate in GSoC 2007? What
do you hope to gain by participating? '''

Although Git has developed from absolutely nothing to one of the most
useful version control systems in less than 2 years, there are still
many new and exciting features that users continue to ask about.
We hope to engage several students in projects that will bring some
of these features to life, or to create useful features that have
not even been considered yet.

Of particular interest are the features that the other prior GSoC
projects have asked for, such as submodule support (Gentoo) or a
native Windows port (KDE, The Mozilla Foundation).

''' Did your organization participate in GSoC 2005 or 2006? If so,
please summarize your involvement and the successes and failures
of your student projects. '''

No.

''' If your organization has not previously participated in GSoC,
have you applied in the past? If so, for what year(s)? '''

We did not apply in the past.  This is our first application.

''' Who will your organization administrator be? Please include Google
Account information. '''

Shawn O. Pearce (have Google Account)

''' What license does your project use? '''

GPL (GNU Public License)

''' What is the URL for your ideas page? '''

[http://git.or.cz/gitwiki/SoC2007Ideas]

''' What is the main development mailing list for your organization? '''

git@vger.kernel.org

''' What is the main IRC channel for your organization? '''

#git on irc.freenode.org.

''' Does your organization have an application template you would like
to see students use? If so, please provide it now. '''

''' Who will be your backup organization administrator? Please include
Google Account information. '''

 * Martin Langhoff (have Google Account)

''' Who will your mentors be? Please include Google Account
Information. '''

 * Petr Baudis (have Google Account)
 * Brian Gernhardt (have Google Account)
 * Martin Langhoff (have Google Account)
 * Shawn O. Pearce (have Google Account)
 * Johannes Schindelin (have Google Account)
 * Martin Waitz (need Google Account)

''' What criteria did you use to select these individuals as
mentors? Please be as specific as possible. '''

All mentors volunteered for the specific project(s) that they could
contribute the most to.  All mentors are active contributers within
the Git development community.

Active contributers are defined to be those who have submitted and
have had accepted into a shipped release a substantial amount of
new code or fixes within the last 4 months (Nov 2006 - Mar 2007).
Substantial amount of code is defined to be equal in size (or
larger) to what might be reasonably expected of a student working
on a Google Summer of Code project.

All mentors are well known within the Git development community
for their accomplishments and contributions.

''' What is your plan for dealing with disappearing students? '''

Every reasonable effort will be made to maintain contact with
students and ensure they are making progress throughout the summer.

In the unfortunate event that a student abandons and does not
complete his/her GSoC project, the Git community will try to pick up
and continue the work without the student.  This is one reason why we
will require frequent publishing of project materials to repo.or.cz.

''' What is your plan for dealing with disappearing mentors? '''

In the unlikely event that a mentor disappears during the summer
another mentor will be arranged to step in.  The Git community
has plenty of good people within that would be more than happy
to help a student finish their project.  It is very probable that
the replacement mentor would already be familiar with the student
and the project, as many community members routinely review code
and discussions on the mailing list.

''' What steps will you take to encourage students to interact with
your project's community before, during and after the program? '''

Students will be required to join the main development mailing list,
post weekly project updates to same, and post patches for discussion
to same.  All current contributors already do this, so students
will see the experienced hands doing the same thing. We feel that
this will help the students to stay a part of the community.

Mailing list traffic is currently around 80-100 messages per day
(maximum), and is focused completely on Git feature development.
Keeping current by at least skimming list messages is an important
part of the Git development process.

Students will be required to post their work as a Git repository on
repo.or.cz (an open community hosting server) so that their work
is immediately available for everyone to review, experiment with,
and hopefully make use of.

Mentors will also exchange email with students on at least a weekly
basis, if not more frequently.  Frequent email and IRC interaction
with mentors and other Git interested developers will be strongly
encouraged.

''' What will you do to ensure that your accepted students stick with
the project after GSoC concludes? '''

GSoC will be a good introduction to git (both the technology and the
community) for the students.  Once they know git and are "hooked",
we are confident they won't easily leave the arena, for a number
of reasons.

The interaction between community members has always been very
friendly, and new people are warmly welcomed, especially those with
interesting new ideas and viewpoints.  Jovial working friendships
have been easily formed between the community members, and students
will certainly be warmly welcomed into that environment.

Hacking on Git is an excellent way to hone one's development skills,
as the community is filled with a wide range of very experienced
programmers who are ready and willing to help a contributor improve
the quality of their work.  We hope that students will realize this
unique opportunity during GSoC and continue staying active within
the community.

-- 
Shawn.
