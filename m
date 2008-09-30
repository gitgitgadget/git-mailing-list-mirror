From: Jeff King <peff@peff.net>
Subject: Re: Implementation of a "textconv" filter for easy custom diff.
Date: Tue, 30 Sep 2008 12:45:46 -0400
Message-ID: <20080930164545.GA20305@sigill.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Sep 30 18:47:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkiNI-0005Mm-E2
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYI3Qpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYI3Qpu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 12:45:50 -0400
Received: from peff.net ([208.65.91.99]:3672 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbYI3Qpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 12:45:49 -0400
Received: (qmail 10473 invoked by uid 111); 30 Sep 2008 16:45:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Sep 2008 12:45:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 12:45:46 -0400
Content-Disposition: inline
In-Reply-To: <vpqk5ctfyp6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97132>

On Tue, Sep 30, 2008 at 05:19:49PM +0200, Matthieu Moy wrote:

> Well, if you have time and you think your code is better than mine, I
> can let you continue on this (and you can pick the parts you want in
> mine). Otherwise, I'd be interested in seeing your draft to
> incorporate the good things in my version.

I am about 90% done cleaning it up for preparation (there is a bit of
refactoring, and I want to make sure I get that just right). I'll post
it in the next day or so.

-Peff
