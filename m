From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/13] credential helpers, take two
Date: Thu, 24 Nov 2011 06:53:51 -0500
Message-ID: <20111124115351.GA29465@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <CABPQNSaT+4F=EW_agAh_FY0h_ZRgMCzpukdKuvZTdfmz5_Nueg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 12:53:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTXsM-0000Aa-HQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab1KXLxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:53:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49673
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab1KXLxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:53:53 -0500
Received: (qmail 17329 invoked by uid 107); 24 Nov 2011 11:54:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:54:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:53:51 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSaT+4F=EW_agAh_FY0h_ZRgMCzpukdKuvZTdfmz5_Nueg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185911>

On Thu, Nov 24, 2011 at 12:45:39PM +0100, Erik Faye-Lund wrote:

> On Thu, Nov 24, 2011 at 11:58 AM, Jeff King <peff@peff.net> wrote:
> > Here's a revised version of the http-auth / credential-helper series.
> >
> 
> Nice. Do you have the branch somewhere public I can pull it from?

  git://github.com/peff/git.git jk/http-auth-simple

But be aware that I do rebase my topic branches frequently.

-Peff
