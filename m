From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit: suggest --amend --reset-author to fix
 commiter identity
Date: Wed, 12 Jan 2011 13:39:04 -0500
Message-ID: <20110112183904.GE31747@sigill.intra.peff.net>
References: <1294754860-17701-1-git-send-email-Matthieu.Moy@imag.fr>
 <1294856954-26841-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 12 19:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd5bP-00062N-4J
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab1ALSjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 13:39:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48019 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab1ALSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:39:07 -0500
Received: (qmail 23084 invoked by uid 111); 12 Jan 2011 18:39:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 18:39:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 13:39:04 -0500
Content-Disposition: inline
In-Reply-To: <1294856954-26841-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165027>

On Wed, Jan 12, 2011 at 07:29:14PM +0100, Matthieu Moy wrote:

> Since the message advise to fix the configuration first, the advantage
> of this command is that it is cut-and-paste ready, while using
> --author='...' requires the user to type his name and email a second
> time.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Sorry, I did a resend the other day, which was plain wrong (I had the
> changes in my tree, but sent before commit--amend-ing).
> 
> This one should be OK.

Yeah, this one looks good.

Acked-by: Jeff King <peff@peff.net>

-Peff
