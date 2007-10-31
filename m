From: Mike Hommey <mh@glandium.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 10:15:29 +0100
Organization: glandium.org
Message-ID: <20071031091529.GA25025@glandium.org>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com> <20071031015708.GA24403@coredump.intra.peff.net> <47282A0D.9010400@op5.se> <20071031083506.GA23316@glandium.org> <472844D4.8050306@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9hW-0002hq-EZ
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 10:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbXJaJRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 05:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbXJaJRK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 05:17:10 -0400
Received: from vawad.err.no ([85.19.200.177]:57987 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbXJaJRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 05:17:09 -0400
Received: from aputeaux-153-1-85-235.w86-205.abo.wanadoo.fr ([86.205.43.235] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1In9h7-0006Fm-Rs; Wed, 31 Oct 2007 10:17:05 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1In9fd-0006Wa-2v; Wed, 31 Oct 2007 10:15:29 +0100
Content-Disposition: inline
In-Reply-To: <472844D4.8050306@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2007 at 10:03:16AM +0100, Andreas Ericsson <ae@op5.se> wrote:
> >Or copied from gitweb.
> >
> 
> Perhaps, but I've never seen that done. Partly because you can't be sure
> the HTTP url is the same as the git address (perhaps people are used to
> this from CVS and the likes), and partly because you'd, for most cases,
> want to use git:// or ssh transport instead of http.
> 
> It might be nifty to have gitweb print some git-valid locator for a repo
> though, or even a full copy-pastable "git clone git://host/path/to/repo.git"
> command-line thingie. I'll look into it when I have leisure.

Hum... it already does print http and git "Mirror URL"s which are ready to
be copy/pasted to feed git clone arguments.

Mike
