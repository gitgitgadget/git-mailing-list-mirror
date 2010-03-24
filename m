From: Jeff King <peff@peff.net>
Subject: Re: git log: why are --full-diff and --pickaxe-all separate
 options?
Date: Wed, 24 Mar 2010 12:20:06 -0400
Message-ID: <20100324162005.GA6626@sigill.intra.peff.net>
References: <76718491003240852m2a2c12afjca2c71f6c78b2047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 17:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuTJZ-0007CI-TT
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 17:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab0CXQUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 12:20:10 -0400
Received: from peff.net ([208.65.91.99]:49878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab0CXQUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 12:20:09 -0400
Received: (qmail 4109 invoked by uid 107); 24 Mar 2010 16:20:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 24 Mar 2010 12:20:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Mar 2010 12:20:06 -0400
Content-Disposition: inline
In-Reply-To: <76718491003240852m2a2c12afjca2c71f6c78b2047@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143091>

On Wed, Mar 24, 2010 at 11:52:13AM -0400, Jay Soffian wrote:

> But now I wonder why these are separate options. Is there any reason
> they shouldn't be unified?

I agree it is confusing, and the answer is "maybe". A long and gory
explanation can be found here:

  http://article.gmane.org/gmane.comp.version-control.git/34909

Read the later messages in the thread from Junio, too, as he goes back
and forth a bit. I don't remember if anything happened after that, or
why not.

-Peff
