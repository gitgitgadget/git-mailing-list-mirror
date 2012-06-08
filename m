From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: fix cross-directory linkgit references
Date: Thu, 7 Jun 2012 23:58:04 -0400
Message-ID: <20120608035803.GA27438@sigill.intra.peff.net>
References: <1339103003-18447-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 05:58:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScqKz-0002P1-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 05:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab2FHD6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 23:58:08 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47061
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab2FHD6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 23:58:07 -0400
Received: (qmail 24877 invoked by uid 107); 8 Jun 2012 03:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jun 2012 23:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jun 2012 23:58:04 -0400
Content-Disposition: inline
In-Reply-To: <1339103003-18447-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199465>

On Thu, Jun 07, 2012 at 11:03:23PM +0200, Matthieu Moy wrote:

> This if Peff's patch, with
> 
> * One missing -a in Makefile added
> 
> * Rebased on 04ab6ae77657 (api-credentials.txt: add "see also"
>   section) in next to get recently added instances of linkgit:../ and
>   fix them.

Thanks. I noticed that your series was in next, so I planned to rebuild
my patch on top. This looks like exactly what I would have done.

-Peff
