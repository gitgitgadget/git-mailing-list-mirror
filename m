From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 21:21:12 -0400
Message-ID: <20080822012112.GA31615@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org> <48ADF542.9010105@zytor.com> <48AE035C.8000504@acm.org> <20080822004052.GA30476@coredump.intra.peff.net> <20080822011515.GY23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Federico Lucifredi <flucifredi@acm.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 03:22:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWLM5-0004lB-3F
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 03:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYHVBVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 21:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYHVBVP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 21:21:15 -0400
Received: from peff.net ([208.65.91.99]:4048 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbYHVBVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 21:21:15 -0400
Received: (qmail 11431 invoked by uid 111); 22 Aug 2008 01:21:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 21:21:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 21:21:12 -0400
Content-Disposition: inline
In-Reply-To: <20080822011515.GY23800@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93243>

On Fri, Aug 22, 2008 at 03:15:15AM +0200, Miklos Vajna wrote:

> On Thu, Aug 21, 2008 at 08:40:52PM -0400, Jeff King <peff@peff.net> wrote:
> > I've never looked at man code before, but there seem to be at least two
> > man packages for Linux. My boxes have man-db 2.5.2.
> 
> Obviously that's not the one Federico maintains. ;-)
> 
> See http://primates.ximian.com/~flucifredi/man/, it's at 1.6f.

Right. What I meant was two-fold:

  1. "I am not going to take your patch challenge, because I don't even
     seem to be running your man pager."

  2. It has been noted in this thread that this will only affect Linux.
     But it is even worse; it will only affect some distributions. So
     people need to get several implementations to agree.

-Peff
