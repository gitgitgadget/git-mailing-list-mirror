From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 02:16:54 -0400
Message-ID: <20080930061654.GA14584@sigill.intra.peff.net>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 30 08:18:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkYYg-00051S-Ei
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 08:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYI3GQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 02:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYI3GQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 02:16:56 -0400
Received: from peff.net ([208.65.91.99]:4693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYI3GQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 02:16:56 -0400
Received: (qmail 29208 invoked by uid 111); 30 Sep 2008 06:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Sep 2008 02:16:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 02:16:54 -0400
Content-Disposition: inline
In-Reply-To: <48E1C39F.4070906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97066>

On Tue, Sep 30, 2008 at 08:13:51AM +0200, Andreas Ericsson wrote:

> Created 6207abc (subwidget: one quite long line of sum...) on <branch>
>
> "commit" is just noise. Parentheses are often used to extemporize when
> using normal written language so it should work well here too.

I do like that better, and there is some precedent in the way we mention
commits in emails (I know Junio even has an alias that formats it as
$hash ($subject)).

By your "..." are you suggesting to truncate the subject?

-Peff
