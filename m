From: Jeff King <peff@peff.net>
Subject: Re: About GSoc idea.
Date: Thu, 26 Mar 2015 12:21:30 -0400
Message-ID: <20150326162130.GE6564@peff.net>
References: <CABJeaiomjkc7dEpT8i0Ecxh41fjOdZFm+du=uf7azq1nJitiuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shanti Swarup Tunga <b112041@iiit-bh.ac.in>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:22:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbAXJ-0006vM-P9
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 17:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbCZQVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 12:21:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:38770 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751278AbbCZQVd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 12:21:33 -0400
Received: (qmail 15894 invoked by uid 102); 26 Mar 2015 16:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 11:21:32 -0500
Received: (qmail 24926 invoked by uid 107); 26 Mar 2015 16:21:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 12:21:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2015 12:21:30 -0400
Content-Disposition: inline
In-Reply-To: <CABJeaiomjkc7dEpT8i0Ecxh41fjOdZFm+du=uf7azq1nJitiuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266335>

On Wed, Mar 25, 2015 at 08:36:41PM +0530, Shanti Swarup Tunga wrote:

>             Duy Nguyen and Stephen Robin , the two developers worked
> on converting git-pull.sh to C code . But in the idea page it is
> written that we should start with git-pull.sh. Should I worked on
> "git-pull.sh" or other shell script for the GSoc.

You don't have to start with git-pull; the ideas page is mostly about
suggesting a direction. However, my impression was that the work that
has been done so far on git-pull is far from complete (I didn't look at
it closely, though). So there may be more to do there, too.

-Peff

PS You may try cc-ing people relevant to what you're posting, which is a
   good way of making sure you get their attention.
