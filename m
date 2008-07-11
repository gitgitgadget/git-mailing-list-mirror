From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tutorial: clarify "pull" is "fetch + merge"
Date: Thu, 10 Jul 2008 22:41:37 -0400
Message-ID: <20080711024137.GA14967@sigill.intra.peff.net>
References: <dc5b80bf0807100652y394e655lfcdd819cc4506afa@mail.gmail.com> <alpine.DEB.1.00.0807101524440.18205@racer> <dc5b80bf0807100729h3e247f68qc48dafc9d0bb154f@mail.gmail.com> <alpine.DEB.1.00.0807101654080.18205@racer> <dc5b80bf0807100912rac7b730ga1ac035057d71d64@mail.gmail.com> <20080710164520.GZ10347@genesis.frugalware.org> <dc5b80bf0807101127q63e3132fw207baf0d88db3d9d@mail.gmail.com> <7vskuho3lm.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ian Katz <ifreecarve@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 04:44:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH8ci-0005Gq-Sr
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 04:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYGKCl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 22:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbYGKCl6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 22:41:58 -0400
Received: from peff.net ([208.65.91.99]:3713 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbYGKCl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 22:41:57 -0400
Received: (qmail 25347 invoked by uid 111); 11 Jul 2008 02:41:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 22:41:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 22:41:37 -0400
Content-Disposition: inline
In-Reply-To: <7vskuho3lm.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88074>

On Thu, Jul 10, 2008 at 02:01:57PM -0700, Junio C Hamano wrote:

> This adds a missing demonstration of the longhand form, and a new
> paragraph to explain why some people might want to fetch before pull.

A few English/typo nits below.

> +Alice can peek what Bob did without merging first, using the "fetch"

s/peek/& at/

> +command; this allows Alice to inspect what bob did, using a special

s/bob/\u&/

> -With this, Alice can perform the first operation alone using the
> +With this, Alice can perform the first part of "pull" operation alone using the

Should be either 'the "pull" operation' or 'a "pull" operation'.

-Peff
