From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #02; Fri, 6)
Date: Wed, 11 Nov 2015 14:11:52 -0500
Message-ID: <20151111191151.GA29543@sigill.intra.peff.net>
References: <xmqq4mgy3dcr.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaK==GhD4nUTh4nnd_NPTNsUG15kS61hAhmP=K6MdHmYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwaoJ-00061h-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbbKKTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:11:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:56175 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751013AbbKKTLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:11:55 -0500
Received: (qmail 22590 invoked by uid 102); 11 Nov 2015 19:11:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 13:11:55 -0600
Received: (qmail 7975 invoked by uid 107); 11 Nov 2015 19:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 14:12:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2015 14:11:52 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kaK==GhD4nUTh4nnd_NPTNsUG15kS61hAhmP=K6MdHmYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281177>

On Wed, Nov 11, 2015 at 10:59:26AM -0800, Stefan Beller wrote:

> On Fri, Nov 6, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > I'll be offline for a few weeks, and Jeff King graciously agreed to
> > help shepherd the project forward in the meantime as an interim
> > maintainer.  Please be gentle.
> >
> 
> Jeff,
> gently asking where I can find our interims maintainers tree. :)

Sorry, I was traveling Monday and Tuesday this week, so I haven't pushed
anything yet. I hope to do a cycle today and push out the result. My
plan is to push my workspace up to git://github.com/peff/git.git,
including topic branches and the usual master/next/etc.

I can also push the latter to git://github.com/git/git.git, but I won't
be pushing to kernel.org.

-Peff
