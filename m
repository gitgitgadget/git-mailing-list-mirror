From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Fri, 26 Feb 2010 07:59:16 -0500
Message-ID: <20100226125916.GA12650@coredump.intra.peff.net>
References: <20100224154452.GA25872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 13:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkzmx-0001AY-0a
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 13:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935966Ab0BZM7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 07:59:22 -0500
Received: from peff.net ([208.65.91.99]:44354 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935925Ab0BZM7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 07:59:19 -0500
Received: (qmail 32077 invoked by uid 107); 26 Feb 2010 12:59:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Feb 2010 07:59:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 07:59:17 -0500
Content-Disposition: inline
In-Reply-To: <20100224154452.GA25872@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141129>

On Wed, Feb 24, 2010 at 10:44:52AM -0500, Jeff King wrote:

> A while back I mentioned that we had some leftover GSoC money, and
> suggested joining the Software Freedom Conservancy as a member project:

Thanks for all of the feedback so far. Here is round 2 of the
application, which I hope is close to done. I am cc'ing all of the
people under the "Key Developers" list; if you have affiliations you
feel should be disclosed, please let me know. And of course any other
suggestions or corrections are welcome.

-- >8 --

>    * Detailed description of the project.

Git is a free & open source, distributed version control system
designed to handle everything from small to very large projects with
speed and efficiency.

Every Git clone is a full-fledged repository with complete history and
full revision tracking capabilities, not dependent on network access or
a central server. Branching and merging are fast and easy to do.

Projects using git include the Linux kernel, X.org, Perl, Gnome, Ruby on
Rails, Wine, Android, and more.

>    * FLOSS License(s) used by the project

The core git code is licensed under GPLv2.

The JGit code, a pure-Java implementation of git, is licensed under
the Eclipse Distribution License, which is a new-style BSD
license.

>    * Roadmap for future development.

Git is a stable, widely-used version control system.  The majority
of the key functionality is already implemented.  Consequently the
project does not maintain a formal roadmap, but instead accepts
a wide range of relevant enhancements and fixes directly from
the user community.

Based on prior history, major new releases occur about every 18
months, minor releases about every 2-3 months, and maintenance
releases every few weeks.  Development is highly distributed,
with over 280 individual contributors during the past 12 months,
and over 730 contributors since the project's inception.

>    * link to the website.

http://git-scm.org
http://www.eclipse.org/jgit/

>    * Link to the code repository.

http://git.kernel.org/?p=git/git.git
http://repo.or.cz/w/jgit.git

>    * Have you ever had funds held by the project, or by any individual
>      on behalf of the projects?  How and for what did you spend those
>      funds?

Yes. We received funds from participating in the Google Summer of Code
in 2008 and 2009. Those funds were disbursed to individual project
members, and used for transportation and lodging of members attending
the GSoC mentor summit and the GitTogether, our annual mini-conference
for developers.  The remainder of the funds were sent to the SFC.

>    * Brief history of the project, including past governance decisions.

Git was started by Linus Torvalds in April of 2005. In July of 2005,
Junio C Hamano became the maintainer. Junio maintains sole control of
the codebase, accepting changes from other developers (both frequent
contributers and one-time patch submitters). For participation in the
Google Summer of Code, Shawn Pearce has served as the project
administrator.

JGit was started in 2006 by Shawn Pearce to provide an efficient,
portable implementation of Git for Java based applications.  The
project moved to the Eclipse Foundation in late 2009, but remains a
standalone component and is widely embedded in non-Eclipse software.

>    * Existing for-profit or non-profit affiliations, funding
>      relationships, or other agreements that the project or its leaders
>      have with other organizations.

Git has participated in the Google Summer of Code.

JGit is hosted by the Eclipse Foundation, and is run in accordance
with the foundation's development processes.

>    * Names, email addresses, and affiliations of key developers, past and
>      present.

Junio C Hamano <gitster@pobox.com>
(Part of Junio's git time used to be funded jointly by his employer and
NEC, but the latter is not anymore.)

Shawn O. Pearce <spearce@spearce.org>
(Google employee, Eclipse Foundation project committer, Apache Software
Foundation project committer)

Linus Torvalds <torvalds@linux-foundation.org>
[Linux Foundation?]

Johannes Schindelin <Johannes.Schindelin@gmx.de>
Eric Wong <normalperson@yhbt.net>
Jeff King <peff@peff.net>
Jakub Narebski <jnareb@gmail.com>
Nicolas Pitre <nico@fluxnic.net>
Paul Mackerras <paulus@samba.org>
Johannes Sixt <j6t@kdbg.org>
Robin Rosenberg <robin.rosenberg@dewire.com>

[I'm still not happy with this list. For example, Pasky was certainly a
key person (and while he is not too active lately, it does say "past and
present"). But this list is already getting long, and if they really
care they can run shortlog themselves. I am tempted to cut it off after
Dscho, where there is a big jump in the number of commits:

  $ git shortlog -ns v1.7.0
  7689  Junio C Hamano
  1356  Shawn O. Pearce
  1092  Linus Torvalds
   710  Johannes Schindelin
   459  Eric Wong
   432  Jeff King
   395  Jakub Narebski
   327  Nicolas Pitre
   322  Paul Mackerras
   272  Johannes Sixt

Maybe a note saying the development is very distributed and that they
should look at the repo for full details?]

>    * Information about any past for-profit or non-profit organizational
>      affiliations the project has had.

None.
