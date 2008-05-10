From: Jeff King <peff@peff.net>
Subject: Re: git filter-branch --subdirectory-filter
Date: Sat, 10 May 2008 07:44:13 -0400
Message-ID: <20080510114412.GA26461@sigill.intra.peff.net>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com> <20080509013300.GA7836@sigill.intra.peff.net> <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com> <20080509080039.GA15393@sigill.intra.peff.net> <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com> <20080510055332.GB11556@sigill.intra.peff.net> <e5e204700805100438v6984593oada51daa4d456fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Sadler <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 13:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JunVc-0006Yn-TC
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 13:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbYEJLoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYEJLoL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 07:44:11 -0400
Received: from peff.net ([208.65.91.99]:3948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbYEJLoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 07:44:10 -0400
Received: (qmail 14981 invoked by uid 111); 10 May 2008 11:44:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 May 2008 07:44:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2008 07:44:13 -0400
Content-Disposition: inline
In-Reply-To: <e5e204700805100438v6984593oada51daa4d456fd3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81663>

On Sat, May 10, 2008 at 09:38:59PM +1000, James Sadler wrote:

> I have run your script on my repo and now have an obfuscated version.
> When I run 'git filter-branch -subdirectory filter $DIR' on this repo,
> the same problem occurs, i.e. there are fewer commits remaining than I
> would expect.

Great, I'm glad the obfuscation worked.

> If I place this repo somewhere you can download it, would you be kind
> enough to take a look?  I'll detail the steps required to reproduce in
> another post.

Sure.

-Peff
