From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Fri, 26 Feb 2010 07:49:11 -0500
Message-ID: <20100226124911.GE10198@coredump.intra.peff.net>
References: <20100224154452.GA25872@coredump.intra.peff.net>
 <20100224162205.GA20340@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkzd9-0004gZ-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 13:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936001Ab0BZMtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 07:49:14 -0500
Received: from peff.net ([208.65.91.99]:57028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935858Ab0BZMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 07:49:13 -0500
Received: (qmail 32041 invoked by uid 107); 26 Feb 2010 12:49:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Feb 2010 07:49:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 07:49:11 -0500
Content-Disposition: inline
In-Reply-To: <20100224162205.GA20340@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141128>

On Wed, Feb 24, 2010 at 08:22:05AM -0800, Shawn O. Pearce wrote:

> > Projects using git include the Linux kernel, X.org, Perl, Gnome, Ruby on
> > Rails, Wine, and more.
> 
> <plug type="shameless" for="$DAY_JOB">
> You could also mention the Android Open Source Project.  Every one  

Heh. I actually pulled most of the list from git-scm.org, and I remember
reading Android and thinking it should go on the list, but somehow it
didn't...

Fixed.

> > Core git is licensed under GPLv2. JGit, a pure-Java implementation of
> > git, is licensed under the Eclipse Distribution License.
> 
> Slightly reworded:

Thanks, yours is much better.

> > >    * Roadmap for future development.
> [...]
> I'm not sure this really answers their question.  I think we
> should make it clear WTF is going on with Git and its "roadmap".
> How about this instead?

No, it doesn't answer their question. Yours is much better again (you
figured out what I was trying to say and actually said it ;) ).

> [JGit stuff]

All added in.

> Also, JGit has Robin Rosenberg <robin.rosenberg@dewire.com> as
> a key developer.  If you are listing JGit on the application,
> I think he deserves the credit too.

Good point (I obviously didn't even do a shortlog on jgit).

-Peff
