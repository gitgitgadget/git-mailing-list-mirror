From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 20:42:50 -0400
Message-ID: <20080822004250.GB30476@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org> <48ADF542.9010105@zytor.com> <48AE035C.8000504@acm.org> <20080822004052.GA30476@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Federico Lucifredi <flucifredi@acm.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKku-0004FM-K8
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbYHVAmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbYHVAmx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:42:53 -0400
Received: from peff.net ([208.65.91.99]:3171 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbYHVAmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:42:52 -0400
Received: (qmail 11178 invoked by uid 111); 22 Aug 2008 00:42:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 20:42:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 20:42:50 -0400
Content-Disposition: inline
In-Reply-To: <20080822004052.GA30476@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93238>

On Thu, Aug 21, 2008 at 08:40:52PM -0400, Jeff King wrote:

> Well, the drawback is that there exist X-Y such that X and Y both have
> manpages (e.g., cvs-debc on my debian box). So we are assuming that the

Re-reading this, it may not be clear what I meant. I mean there exists a
_manpage_ "X-Y" such that "X" and "Y" are also manpages. So on my system
there are three commands, each with a manpage: cvs, debc, and cvs-debc.

-Peff
