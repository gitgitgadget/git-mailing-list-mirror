From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 15 Apr 2008 15:23:02 -0400
Message-ID: <20080415192301.GD31395@sigill.intra.peff.net>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:32:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlqs2-0004M9-1d
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbYDOT3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYDOT3r
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:29:47 -0400
Received: from [208.65.91.99] ([208.65.91.99]:3167 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbYDOT3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 15:29:47 -0400
Received: (qmail 9374 invoked by uid 111); 15 Apr 2008 19:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 15 Apr 2008 15:23:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2008 15:23:02 -0400
Content-Disposition: inline
In-Reply-To: <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79623>

On Mon, Apr 14, 2008 at 12:00:50AM -0700, Junio C Hamano wrote:

> * jk/fetch-status (Wed Apr 9 20:11:52 2008 -0400) 1 commit
>  + git-fetch: always show status of non-tracking-ref fetches

I have been out of touch for a few days. My plan had been to come back
with a new version that suppressed the status on pull, but I haven't
seen anyone screaming about the change, so maybe it should just be left.

-Peff
