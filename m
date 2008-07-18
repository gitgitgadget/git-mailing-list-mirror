From: Jeff King <peff@peff.net>
Subject: Re: Considering teaching plumbing to users harmful
Date: Fri, 18 Jul 2008 14:26:16 -0400
Message-ID: <20080718182615.GA9035@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48805207.80504@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJufm-0000UD-CP
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbYGRS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYGRS0T
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:26:19 -0400
Received: from peff.net ([208.65.91.99]:1502 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbYGRS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:26:18 -0400
Received: (qmail 25815 invoked by uid 111); 18 Jul 2008 18:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 18 Jul 2008 14:26:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jul 2008 14:26:16 -0400
Content-Disposition: inline
In-Reply-To: <48805207.80504@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89068>

On Fri, Jul 18, 2008 at 10:19:19AM +0200, Andreas Ericsson wrote:

> In addition, I'd recommend setting
> color.branch=auto
> color.diff=auto
> color.pager=true
> color.status=true
> before starting the "course". It makes the learning experience a whole
> lot nicer.

You might be interested in the "color.ui" config option.

-Peff
