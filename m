From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote-mediawiki: use Git.pm functions for
 credentials
Date: Wed, 5 Jun 2013 11:55:35 -0400
Message-ID: <20130605155534.GC8664@sigill.intra.peff.net>
References: <7vr4gh7m24.fsf@alter.siamese.dyndns.org>
 <1370429880-12696-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, celestin.matte@ensimag.fr, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jun 05 17:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkG3u-00024d-4P
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 17:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab3FEPzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 11:55:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:51657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755902Ab3FEPzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 11:55:37 -0400
Received: (qmail 29877 invoked by uid 102); 5 Jun 2013 15:56:23 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 10:56:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 11:55:35 -0400
Content-Disposition: inline
In-Reply-To: <1370429880-12696-1-git-send-email-benoit.person@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226455>

On Wed, Jun 05, 2013 at 12:58:00PM +0200, benoit.person@ensimag.fr wrote:

> From: Benoit Person <benoit.person@ensimag.fr>
> 
> In 52dce6d, a new credential function was added to Git.pm, based on
> git-remote-mediawiki's functions. The logical follow-up is to use
> those functions in git-remote-mediawiki.
> 
> Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

Thanks, this looks correct to me.

-Peff
