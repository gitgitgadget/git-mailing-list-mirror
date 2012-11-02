From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: fixup misplacement of --no-post-rewrite
 description
Date: Fri, 2 Nov 2012 09:22:59 -0400
Message-ID: <20121102132259.GD2598@sigill.intra.peff.net>
References: <m2hap88a2g.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:23:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHDT-0002Fc-SM
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab2KBNXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:23:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54435 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab2KBNXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:23:02 -0400
Received: (qmail 4099 invoked by uid 107); 2 Nov 2012 13:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 09:23:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 09:22:59 -0400
Content-Disposition: inline
In-Reply-To: <m2hap88a2g.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208928>

On Fri, Nov 02, 2012 at 01:26:47PM +0100, Andreas Schwab wrote:

> In e858af6 (commit: document a couple of options) the description of the
> --no-post-rewrite option was put inside the paragraph for the --amend
> option.  Move it down after the paragraph.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Thanks, the modified output looks much more sane.

-Peff
