From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Google Summer of Code '07 application
Date: Fri, 9 Mar 2007 01:01:28 -0500
Message-ID: <20070309060128.GC5026@fieldses.org>
References: <20070308050746.GA29778@spearce.org> <20070309022118.GC32211@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 07:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPY9v-0002HJ-G6
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 07:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992992AbXCIGAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 01:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992993AbXCIGAv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 01:00:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56832 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992992AbXCIGAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 01:00:50 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HPYAS-0005OS-SN; Fri, 09 Mar 2007 01:01:28 -0500
Content-Disposition: inline
In-Reply-To: <20070309022118.GC32211@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41787>

On Thu, Mar 08, 2007 at 09:21:18PM -0500, Shawn O. Pearce wrote:
> I have updated the wiki with the final draft, and taken into account
> the copy editing that people were trying to do last night in parallel
> with me overwriting their changes all of the time.  ;-)

I see a few more minor language fixes--do you want them by wiki or
email?

> ''' Describe your organization. '''
> 
> The Git development community is a loosely knitted team of
> developers, documentation writers and end-users with the common goal
> of building and maintaining a high quality revision control system.
> As an offshoot of the Linux kernel team, we take great pride in
> our open development methodology and emphasis on quality.
> 
> Git is currently used by at least 5 of the GSoC 2006 projects
> (One Laptop Per Child, Tangram, The Wine Project, XMMS2, X.org),
> not to mention the Linux kernel, and in the past year has been (or
> is still being) considered for conversion by at least another 6
> (FreeBSD Project, Gentoo, KDE, OpenOffice.org, OpenSolaris, The
> Mozilla Foundation).

The first paragraph (in particular, first sentence) is a little
generic--couldn't it mostly apply to all of the GSoC projects?  You
might turn it around and start with the second paragraph, which is stuff
only git can boast of:

	As Git approaches its second anniversary, it is now the revision
	control system of choice for many of the largest and most
	succesful open source projects, including the Linux kernel and
	at least 5 Google Summer of Code 2006 projects: One Laptop Per
	Child, Tangram, The Wine Project, XMMS2, and X.org.  Many more
	are considering Git adoption.

	This achievement is the product of the Git development
	community, a loose-knit team of developers, technical writers,
	and end users with a passion for high quality open-source
	development.

> ''' Why is your organization applying to participate in GSoC 2007? What
> do you hope to gain by participating? '''
> 
> Although Git has developed from absolutely nothing to one of the most
> useful version control systems in less than 2 years, there are still
> many new and exciting features that users continue to ask about.
> We hope to engage several students in projects that will bring some
> of these features to life, or to create useful features that have
> not even been considered yet.
> 
> Of particular interest are the features that the other prior GSoC
> projects have asked for, such as submodule support (Gentoo) or a
> native Windows port (KDE, The Mozilla Foundation).

Here also maybe leading with the specifics would make it stronger?:

	Prior Google Summer of Code projects have asked for new features
	in Git, including submodule support (needed by Gentoo) native
	Windows port (needed by KDE and The Mozilla Foundation).....

(Would it be worth listing more examples here, or does the application
already include a comprehensive list?)

Also I'm not sure we answered the question quite as directly as we could
here.  Maybe just something like this?:

	The future development and maintenance of these and other
	features depends on our continued ability to attract new
	developers.

But that's a little generic.

It seems to me that the Git community has been pretty good at attracting
and mentoring new contributors.  The maintainers have been really
conscientious about explaining the project architecture and giving
feedback on contributions.

I'm not sure how to make that really clear, or where to fit it in.
Maybe in the answer to one of these two?:

> ''' What steps will you take to encourage students to interact with
> your project's community before, during and after the program? '''

> ''' What will you do to ensure that your accepted students stick with
> the project after GSoC concludes? '''

This comes close:

> GSoC will be a good introduction to git (both the technology and the
> community) for the students.  Once they know git and are "hooked",
> we are confident they won't easily leave the arena, for a number
> of reasons.
> 
> The interaction between community members has always been very
> friendly, and new people are warmly welcomed, especially those with
> interesting new ideas and viewpoints.  Jovial working friendships
> have been easily formed between the community members, and students
> will certainly be warmly welcomed into that environment.

I wonder if it'd be easy to come up with some more specifics to support
these kinds of statements.  Could even point to particular exchanges in
the mail archives if there's anything short that obviously demonstrates
the point.  Also I think it's not so much "friendliness" as willingness
(and ability) to communicate what's important very clearly.

--b.
