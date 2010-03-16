From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 23:37:53 -0400
Message-ID: <20100316033753.GA30332@coredump.intra.peff.net>
References: <20100315214003.GB11157@pixar.com>
 <20100316023306.GA14253@coredump.intra.peff.net>
 <20100316032857.GA8734@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 04:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrNbm-0004HR-4r
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 04:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978Ab0CPDiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 23:38:11 -0400
Received: from peff.net ([208.65.91.99]:55616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902Ab0CPDiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 23:38:09 -0400
Received: (qmail 6880 invoked by uid 107); 16 Mar 2010 03:38:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Mar 2010 23:38:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Mar 2010 23:37:53 -0400
Content-Disposition: inline
In-Reply-To: <20100316032857.GA8734@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142295>

On Mon, Mar 15, 2010 at 08:28:58PM -0700, Lars Damerow wrote:

> I was thinking about cp's -x option and its description in the man page
> when I chose GIT_ONE_FILESYSTEM. Before I wrote this patch I configured

Ah, I always just used "-x" and didn't know about "--one-file-system".
So in that way, it makes sense.

> Do the overall idea and implementation have enough merit that the patch
> could get accepted?

Yeah, I think it is an improvement overall.

-Peff
