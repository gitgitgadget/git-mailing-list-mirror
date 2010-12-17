From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git in the SFC
Date: Thu, 16 Dec 2010 19:33:15 -0500
Message-ID: <20101217003315.GA18898@sigill.intra.peff.net>
References: <20101217002034.GA18648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bkuhn@sfconservancy.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 01:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTOGN-0005WD-8z
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 01:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0LQAdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 19:33:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab0LQAdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 19:33:18 -0500
Received: (qmail 4259 invoked by uid 111); 17 Dec 2010 00:33:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 17 Dec 2010 00:33:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Dec 2010 19:33:15 -0500
Content-Disposition: inline
In-Reply-To: <20101217002034.GA18648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163846>

I kept the announcement to the minimum, but a few follow-on points for
the community:

On Thu, Dec 16, 2010 at 07:20:35PM -0500, Jeff King wrote:

> I'm pleased to announce that Git is now a member project of the Software
> Freedom Conservancy (SFC). The SFC is a not-for-profit organization that
> provides financial and administrative assistance to open source
> projects.

In case you are wondering, this has basically no bearing on the
development of git code. We are not assigning copyrights to the SFC
(though we could if we so chose), and the only real requirement it makes
on the code is that we continue to develop as an open-source project.
This just gives us a legal entity for doing any monetary things, or
handling contracts or license enforcement should it ever be necessary.

There is a committee of liaisons to the Conservancy consisting of Junio,
Shawn Pearce, and myself. Doing anything (e.g., spending money we have
in our account) requires a majority vote of the committee. The committee
can be expanded with new members by a vote of the existing committee.

All of that is in our contract with the SFC.  There's no official
procedure for doing something like holding a periodic community-wide
election. If somebody wants to organize such a thing, I'm sure the
committee would be happy to recognize the results by adding in whoever
wins the election. For starters, we went with the simplest thing.

> Among other things, the SFC will now handle any project money that Git
> receives (e.g., Google Summer of Code money). They will also accept
> tax-deductible donations on behalf of git that will go to git's project
> fund.

Note that we don't really have a planned use for any money. In the past
it has mostly gone to helping developers (especially students with no
money) make it to the GitTogether. If you do feel like donating money,
you might also consider making a suggestion of what to do with it. :)

You might also consider donating directly to the SFC. Their mission is
good, and git indirectly benefits by having access to their services.
For donations earmarked for git, we give the SFC 10%.

If you have any other questions about what this means for git, or
suggestions on how it could or should impact the community, feel free to
ask. I probably won't have good answers, but Bradley Kuhn from the
Conservancy (cc'd) will.

-Peff
