From: Jeff King <peff@peff.net>
Subject: Re: git version numbers
Date: Mon, 30 May 2011 10:25:44 -0400
Message-ID: <20110530142544.GB31490@sigill.intra.peff.net>
References: <20110528201321.GA26017@Imperial-SD-Longsword>
 <20110530033428.GB27691@sigill.intra.peff.net>
 <20110530060653.GB3723@Imperial-SD-Longsword>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3Pj-0000YI-P3
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab1E3OZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 10:25:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49852
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab1E3OZq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 10:25:46 -0400
Received: (qmail 15186 invoked by uid 107); 30 May 2011 14:25:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 10:25:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 10:25:44 -0400
Content-Disposition: inline
In-Reply-To: <20110530060653.GB3723@Imperial-SD-Longsword>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174747>

On Mon, May 30, 2011 at 04:06:55PM +1000, Tim Mazid wrote:

> While we're on the topic, though, when I was scouring the web for
> information, I found a post [1] which spoke against the traditional
> numbering versioning system.  Personally, I disagree and find the
> "dating" version cumbersome and uninformative.  So, I was wondering what
> your [2] take on this is.

I agree with you. I am sympathetic to the position that giant version
numbers can be confusing to end users, but I hope it is clear from my
previous email that each of those numbers has a meaning, and that
developers, system administrators, and clueful users can see from the
version number what they should expect to change. A simpler versioning
scheme loses that information.

-Peff
