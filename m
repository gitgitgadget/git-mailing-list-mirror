From: Jeff King <peff@peff.net>
Subject: Re: [GSoC 2010] The 1st week
Date: Tue, 25 May 2010 02:24:57 -0400
Message-ID: <20100525062457.GB10898@coredump.intra.peff.net>
References: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 08:25:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGnZf-00050P-P2
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab0EYGZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 02:25:04 -0400
Received: from peff.net ([208.65.91.99]:47750 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227Ab0EYGZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 02:25:03 -0400
Received: (qmail 15919 invoked by uid 107); 25 May 2010 06:25:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 02:25:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 02:24:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147666>

On Mon, May 24, 2010 at 10:57:15PM +0800, Bo Yang wrote:

> What's done:
> 1. Get familiar with Git code base and have read the code of 'git
> blame', revision walk, 'git log'.
> 2. Try to make some patches for git:
>     1. * by/blame-doc-m-c (2010-05-06) 1 commit, in 'next'
>     2. * by/log-follow (2010-05-10) 4 commits, in 'next'
>     3. the '--graph improvement', in discuss and I think ready for inclusion.
> 3. Start to write some code for the line level browser feature. And it
> is in the 'playaround' branch in http://repo.or.cz/w/line.git . Now,
> the code can parse multiple line ranges for multiple files in only one
> revision.

You didn't mention

  4. Contributing to other discussion of --follow on the list.

It is a small thing, perhaps, but I am very happy to see a GSoC student
actively participating in the community.

Speaking of which, I haven't finished polishing the --follow patches
from our earlier thread. I was taking a look at making history
simplification (including --parents) work. Are you going to be doing any
work on that this summer? If so, I will probably just drop it for now
and let you deal with it. :)

-Peff
