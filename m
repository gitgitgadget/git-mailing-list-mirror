From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: GSoC 2008 Application - Help Wanted!
Date: Mon, 3 Mar 2008 00:06:24 -0500
Message-ID: <20080303050624.GF8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 06:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW2tf-0003dF-CB
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 06:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYCCFG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 00:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbYCCFG3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 00:06:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54409 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYCCFG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 00:06:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW2sP-0001pV-9t; Mon, 03 Mar 2008 00:06:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B72A920FBAE; Mon,  3 Mar 2008 00:06:24 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75884>

I am starting to prepare our application to Google Summer of
Code 2008 and would greatly appreciate editing help from everyone
interested.  The page on the Wiki is here

  http://git.or.cz/gitwiki/SoC2008Application

and has mostly been created by copying the 2007 page and updating
the content to reflect last year's involvement.  To make it easier I
am including the Wiki markup below so you can read and reply inline
if that is your preferred approach.

The deadline is March 12 (12 noon PDT/19:00 UTC).

--8<--
Git's application to Google's Summer of Code 2008.

The application questions can be found on
[http://code.google.com/soc/2008/faqs.html#0.1_org_app code.google.com].

Shawn Pearce has volunteered to submit the application and serve
as our group's primary contact.

''' What is your Organization's Name? '''

Git Development Community

''' What is your Organization's Homepage? '''

[http://git.or.cz/]

''' Describe your organization. '''

As Git approaches its third anniversary, it is now the revision
control system of choice for many of the largest and most successful
open source projects, including the Linux kernel and at least eight
Google Summer of Code 2007 projects: ikiwiki, One Laptop Per Child,
Samba, Thousand Parsec, The Wine Project, VideoLAN, XMMS2, and X.org.

This achievement is the product of the Git development community,
a loose-knit team of developers, technical writers, and end users
with a passion for high quality open-source development.

''sp>'' Is this really a good description of us?

''' Why is your organization applying to participate in GSoC 2008? What
do you hope to gain by participating? '''

During GSoC 2007 Git had two successful student projects.  Although
both students contributed useful code to the community, the biggest
benefit we received was the increased visibility and the addition of
new long-term contributors.

By participating in GSoC 2008 the Git community hopes to attract
more new talent to our community, and convert that talent into
long-term contributors.

''' Did your organization participate in past GSoCs? If so, please
summarize your involvement and the successes and challenges of your
participation. '''

During GSoC 2007 we had two student projects ("GIT library project",
"Replace most core scripts with C versions") mentored by two of our
active developers.

The first project produced a Python binding to the internal Git
APIs, showing it is possible to embed our private library in a
developer friendly interface.  This work has not yet been merged
into a release tree as it still requires additional effort to
resolve memory management issues in the underlying private library.

The second project ported two core Git functions from Bourne shell
to C, as well as cleaned up the implementation to follow our current
best practices.  The student involved with this project is still
an active contributor almost one year later.

''sp>'' Talk about our challenges.

''' If your organization has not previously participated in GSoC,
have you applied in the past? If so, for what year(s)? '''

Yes, 2007 (applied and accepted).

''' Who will your organization administrator be? Please include Google
Account information. '''

Shawn O. Pearce (have Google Account)

''' What license does your project use? '''

GPL (GNU Public License)

''' What is the URL for your ideas page? '''

[http://git.or.cz/gitwiki/SoC2008Ideas]

''' What is the main development mailing list for your organization? '''

git@vger.kernel.org

''' What is the main IRC channel for your organization? '''

#git on irc.freenode.org.

''' Does your organization have an application template you would like
to see students use? If so, please provide it now. '''

[[SoC2008Template]]

''' Who will be your backup organization administrator? Please include
Google Account information. '''

Johannes Schindelin (have Google Account)

''' Who will your mentors be? Please include Google Account
Information. '''

 * Shawn O. Pearce (have Google Account)
 * Johannes Schindelin (have Google Account)

''' What criteria did you use to select these individuals as
mentors? Please be as specific as possible. '''

All mentors volunteered for the specific project(s) that they could
contribute the most to.  All mentors are active contributers within
the Git development community.

Active contributers are defined to be those who have submitted and
have had accepted into a shipped release a substantial amount of
new code or fixes within the last 4 months (Nov 2007 - Mar 2008).
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

Students will also be strongly encouraged by our mentors to work
through their project by completing several small milestones
throughout the summer.  This strategy of project organization will
help students to feel like they have accomplished something useful
sooner, as well as making it easier for the Git community to pick
up an abandoned project.

''' What is your plan for dealing with disappearing mentors? '''

Most of our suggested projects have more than one mentor available.
As a community we plan on making sure all of the active projects have
at least two mentors willing and available to work with the student,
reducing the likelihood that the project becomes mentor-less during
GSoC '08.

In the unlikely event that a mentor disappears during the summer
another mentor will be arranged to step in.  The Git community
has plenty of good people within that would be more than happy to
help a student finish their project.  It is very probable that the
replacement mentor would already be familiar with the student and
the project, as many community members routinely review code and
discussions on the mailing list.

''' What steps will you take to encourage students to interact with
your project's community before, during and after the program? '''

Students will be required to join the main development mailing
list, and post their patches for discussion to same.  All current
contributors already do this, so students will see the experienced
hands performing the same tasks, and will therefore be able to learn
by example.  We feel that the list based discussions will help the
students to become, and stay, a member of the community.

Mailing list traffic is currently around 80-100 messages per day,
and is focused on Git feature development.  Keeping current by
at least skimming list messages is an important part of the Git
development process.

Students will be required to post their work as a Git repository on
repo.or.cz (an open community hosting server), or on another publicly
available server, so that their work is immediately available for
everyone to review, experiment with, and make use of.  Nearly all
members of the Git community post their active work to repo.or.cz
or similar servers.

Mentors will also exchange email with students on at least a
weekly basis, if not more frequently.  Students will be required
to provide weekly progress reports back to their mentors, so that
the mentors are aware of the tasks that a student might be stuck on
or are having difficulty with.  The intent of the progress reports
is to give the mentors a chance to provide suggestions for problem
resolution back to the student.

Frequent email and IRC interaction with mentors and other developers
will be strongly encouraged by suggesting students post their
questions and ideas to the mailing list, and to discuss them on #git.
Most developers either already hold "office-hours" on IRC, or have
agreed to do so during GSoC '08.

''' What will you do to ensure that your accepted students stick with
the project after GSoC concludes? '''

GSoC will be a good introduction to Git (both the technology and the
community) for the students.  Once they know Git and are "hooked",
we are confident they won't easily leave the arena, for a number
of reasons.

The interaction between community members has always been very
friendly, and new people are have always been warmly welcomed;
especially those with interesting new ideas and viewpoints.
Jovial working friendships have been easily formed between the
community members, and students will most certainly also be warmly
welcomed into that environment.

Hacking on Git is an excellent way to hone one's development skills,
as the community is filled with a wide range of very experienced
programmers who are ready and willing to help a contributor improve
the quality of their work.  We hope that students will realize this
unique opportunity during GSoC and continue staying active within
the community even after GSoC '08 completes.

-- 
Shawn.
