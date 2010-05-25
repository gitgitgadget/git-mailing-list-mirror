From: Jeff King <peff@peff.net>
Subject: Re: [GSoC 2010] The 1st week
Date: Tue, 25 May 2010 05:06:29 -0400
Message-ID: <20100525090629.GA30863@coredump.intra.peff.net>
References: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>
 <20100525062457.GB10898@coredump.intra.peff.net>
 <AANLkTilEoK-CZR8C16ageafSnA_TNyp3nXHVAm67_LS3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 11:06:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq5v-0007zO-6K
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab0EYJGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:06:35 -0400
Received: from peff.net ([208.65.91.99]:44240 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756267Ab0EYJGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:06:34 -0400
Received: (qmail 18454 invoked by uid 107); 25 May 2010 09:06:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:06:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:06:29 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilEoK-CZR8C16ageafSnA_TNyp3nXHVAm67_LS3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147696>

On Tue, May 25, 2010 at 04:58:11PM +0800, Bo Yang wrote:

> Yeah, the line level browser will touch the parents rewriting things
> and I think the feature of line level history is a super-set of the
> '--follow' things, so you can leave it with me. And in my plan, I will
> complete this in next month. :)

Great, I will not worry about the parent rewriting problem, then. I will
probably polish and submit the multiple-file follow when I get a chance,
though.

-Peff
