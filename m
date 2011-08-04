From: Jeff King <peff@peff.net>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Thu, 4 Aug 2011 01:05:28 -0600
Message-ID: <20110804070528.GA11805@sigill.intra.peff.net>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Gregory <j.gregory@epigenesys.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 04 09:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qos0D-0002pr-Vi
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 09:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab1HDHFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 03:05:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41514
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab1HDHFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 03:05:32 -0400
Received: (qmail 16590 invoked by uid 107); 4 Aug 2011 07:06:05 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 03:06:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 01:05:28 -0600
Content-Disposition: inline
In-Reply-To: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178703>

On Mon, Aug 01, 2011 at 12:57:58PM +0100, James Gregory wrote:

> I'm not sure if this is the right place to post bug reports - if not,
> please can you let me know.

This is the right place.

> I've found (what appears to be) a problem in git-fast-export. I've
> filed a bug in Launchpad, but I'm not sure if anyone from the Git
> community actively monitors it so I'm reporting it here to see if it
> can be fixed.

I don't think anybody monitors Launchpad explicitly; thanks for the
pointer.

> The bug can be viewed online at:
> https://bugs.launchpad.net/ubuntu/+source/git/+bug/815828
> and I've done my best to describe the bug in some detail. If you need
> me to elaborate on the problem further, don't hesitate to let me know.

Definitely looks like a bug. Is it possible for you to make the
offending repo available either publicly or to me in private? There's
not enough information in your report for me to reproduce the problem
here.

-Peff
