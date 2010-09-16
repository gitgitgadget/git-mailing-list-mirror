From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-ls-files.txt: clarify -x/--exclude option
Date: Wed, 15 Sep 2010 20:19:09 -0400
Message-ID: <20100916001909.GB2371@sigill.intra.peff.net>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <1284595008-36464-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow2BU-0007G7-Io
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab0IPASg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:18:36 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60010 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab0IPASf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:18:35 -0400
Received: (qmail 25075 invoked by uid 111); 16 Sep 2010 00:18:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Sep 2010 00:18:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Sep 2010 20:19:09 -0400
Content-Disposition: inline
In-Reply-To: <1284595008-36464-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156282>

On Wed, Sep 15, 2010 at 07:56:48PM -0400, Jay Soffian wrote:

> Since b5227d8, -x/--exclude does not apply to cached files.
> This is easy to miss unless you read the discussion in the
> EXCLUDE PATTERNS section. Clarify that the option applies
> to untracked files and direct the reader to EXCLUDE PATTERNS.

Yeah, I think this is a good idea.

Acked-by: Jeff King <peff@peff.net>

-Peff
