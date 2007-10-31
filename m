From: Mike Hommey <mh@glandium.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 09:35:06 +0100
Organization: glandium.org
Message-ID: <20071031083506.GA23316@glandium.org>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com> <20071031015708.GA24403@coredump.intra.peff.net> <47282A0D.9010400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In94o-0003oN-V0
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbXJaIhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbXJaIhN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:37:13 -0400
Received: from vawad.err.no ([85.19.200.177]:36711 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbXJaIhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 04:37:11 -0400
Received: from aputeaux-153-1-85-235.w86-205.abo.wanadoo.fr ([86.205.43.235] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1In94G-0004yw-U0; Wed, 31 Oct 2007 09:36:58 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1In92Y-00065F-TC; Wed, 31 Oct 2007 09:35:07 +0100
Content-Disposition: inline
In-Reply-To: <47282A0D.9010400@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2007 at 08:09:01AM +0100, Andreas Ericsson <ae@op5.se> wrote:
> Jeff King wrote:
> >On Wed, Oct 31, 2007 at 02:49:16AM +0100, Jakub Narebski wrote:
> >
> >>>...which is a quoting mechanism, and it's not even one commonly used in
> >>>emails (i.e., people have written "parse a URL from this text" scripts
> >>>for RFC-encoded URLs, but _not_ for shell quoting).
> >>I don't think RFC-encoding is quoting mechanism used in emails, either.
> >
> >That's funny, because I have hundreds of mails where that is the case,
> >and none where people used shell-quoting.  Most URLs don't _need_ any
> >encoding, so we don't notice either way. But are you honestly telling me
> >that if you needed to communicate a URL with a space via email, you
> >would write:
> >
> >  'http://foo.tld/url with a space'
> >
> >rather than:
> >
> >  http://foo.tld/url+with+a+space
> >
> >?
> >
> 
> I think 99% of all URL's communicated via email are copy-pasted from a
> webbrowsers location bar. I believe most git urls (or grls, or whatever
> you wanna call them) communicated via email are copy-pasted from ones
> config, or written out manually.

Or copied from gitweb.

Mike
