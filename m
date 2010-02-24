From: Jeff King <peff@peff.net>
Subject: git as an sfc member project
Date: Wed, 24 Feb 2010 10:44:53 -0500
Message-ID: <20100224154452.GA25872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 16:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkJQ6-0001t6-8n
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 16:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab0BXPo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 10:44:57 -0500
Received: from peff.net ([208.65.91.99]:53150 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755674Ab0BXPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 10:44:56 -0500
Received: (qmail 4043 invoked by uid 107); 24 Feb 2010 15:45:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 10:45:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2010 10:44:53 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140948>

A while back I mentioned that we had some leftover GSoC money, and
suggested joining the Software Freedom Conservancy as a member project:

  http://article.gmane.org/gmane.comp.version-control.git/134435

People seemed to think it was a good idea, so I have gone in that
direction. The short of it is:

  1. They now have our money. :) I was able to donate the money to them
     before the new year, which makes things much easier tax-wise. The
     money is earmarked for git, contingent upon us becoming a member
     project. If, for whatever reason, we do not do so during 2010, then
     the money reverts to the SFC general fund.

  2. I've exchanged emails with Bradley Kuhn, the president of the SFC.
     He was very positive about git becoming a member project. The SFC
     board has a semi-annual meeting to vote on accepting new member
     projects, and they will be meeting soon. We just need to fill out
     the application materials and get them to Bradley in the next
     week.

The materials are below. They're not very long, and I have tried to fill
them out as best I can. There are a few parts that could be elaborated
on (mostly related to JGit, which I have included under the umbrella of
the git project, and about which I am mostly ignorant). And of course I
am open to suggestions and corrections.

-- >8 --

>    * Detailed description of the project.

Git is a free & open source, distributed version control system
designed to handle everything from small to very large projects with
speed and efficiency.

Every Git clone is a full-fledged repository with complete history and
full revision tracking capabilities, not dependent on network access or
a central server. Branching and merging are fast and easy to do.

Projects using git include the Linux kernel, X.org, Perl, Gnome, Ruby on
Rails, Wine, and more.

>    * FLOSS License(s) used by the project

Core git is licensed under GPLv2. JGit, a pure-Java implementation of
git, is licensed under the Eclipse Distribution License.

>    * Roadmap for future development.

Git is currently a stable, widely-used version control system. We
continue to accept enhancements and bug fixes, with a new major release
about every 18 months, minor releases every 2-3 months, and bugfix
releases every few weeks. The development remains highly distributed,
with 281 individual contributors during the past year.

>    * link to the website.

http://git-scm.org

>    * Link to the code repository.

http://git.kernel.org/?p=git/git.git

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

[JGit?]

>    * Existing for-profit or non-profit affiliations, funding
>      relationships, or other agreements that the project or its leaders
>      have with other organizations.

Git has participated in the Google Summer of Code.

[Eclipse affiliations for JGit?]

>    * Names, email addresses, and affiliations of key developers, past and
>      present.

Junio C Hamano <gitster@pobox.com>
Shawn O. Pearce <spearce@spearce.org>
Linus Torvalds <torvalds@linux-foundation.org>
Johannes Schindelin <Johannes.Schindelin@gmx.de>
Eric Wong <normalperson@yhbt.net>
Jeff King <peff@peff.net>
Jakub Narebski <jnareb@gmail.com>
Nicolas Pitre <nico@fluxnic.net>
Paul Mackerras <paulus@samba.org>
Christian Couder <chriscool@tuxfamily.org>

[This is basically "shortlog -ns | head". I am happy to make it shorter
or longer if people think it should be. Affiliations?]

>    * Information about any past for-profit or non-profit organizational
>      affiliations the project has had.

None.
