From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 08/16] t4026 (color): add missing &&
Date: Sat, 25 Sep 2010 23:38:32 -0400
Message-ID: <20100926033831.GA31436@sigill.intra.peff.net>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
 <1285441627-28233-9-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 05:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OziBn-0003i6-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 05:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab0IZDig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 23:38:36 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47611 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168Ab0IZDif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 23:38:35 -0400
Received: (qmail 359 invoked by uid 111); 26 Sep 2010 03:38:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 26 Sep 2010 03:38:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Sep 2010 23:38:32 -0400
Content-Disposition: inline
In-Reply-To: <1285441627-28233-9-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157209>

On Sat, Sep 25, 2010 at 01:06:59PM -0600, Elijah Newren wrote:

> Ever since 8b12413 (color: allow multiple attributes 2010-02-27),
> diff.color.new has been unused in t4026, so also remove the final unsetting
> of that value to make the third to last test pass with appropriate
> chaining.

Thanks, I think this is the right patch from our previous discussion,
but your subject line seems stale. :)

-Peff
