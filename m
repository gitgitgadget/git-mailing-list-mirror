From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Userdiff patterns for C#
Date: Mon, 16 Aug 2010 13:14:08 -0400
Message-ID: <20100816171408.GA15815@coredump.intra.peff.net>
References: <20100811193739.GC8106@coredump.intra.peff.net>
 <1281978062-5772-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 19:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol3GS-0003sK-6e
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 19:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab0HPROS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 13:14:18 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41726 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab0HPROS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 13:14:18 -0400
Received: (qmail 27355 invoked by uid 111); 16 Aug 2010 17:14:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 16 Aug 2010 17:14:17 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Aug 2010 13:14:08 -0400
Content-Disposition: inline
In-Reply-To: <1281978062-5772-1-git-send-email-gsvick@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153666>

On Mon, Aug 16, 2010 at 05:01:02PM +0000, Petr Onderka wrote:

> Add userdiff patterns for C#. This code is an improved version of
> code by Adam Petaccia from 21 June 2009 mail to the list.
> 
> Signed-off-by: Petr Onderka <gsvick@gmail.com>
> ---
> Added the documentation.

Thanks. I ran a few diffs on what little C# code I have, and it did seem
to be an improvement. So:

Acked-by: Jeff King <peff@peff.net>

-Peff
