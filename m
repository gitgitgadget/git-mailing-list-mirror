From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Thu, 10 Apr 2008 04:03:25 -0400
Message-ID: <20080410080325.GA15791@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080410000349.GA16800@sigill.intra.peff.net> <20080410001152.GB16800@sigill.intra.peff.net> <7vlk3mxi4z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrlY-00027U-9F
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYDJIDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYDJIDa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:03:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3184 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbYDJID3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:03:29 -0400
Received: (qmail 22642 invoked by uid 111); 10 Apr 2008 08:03:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Apr 2008 04:03:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Apr 2008 04:03:25 -0400
Content-Disposition: inline
In-Reply-To: <7vlk3mxi4z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79192>

On Thu, Apr 10, 2008 at 12:51:08AM -0700, Junio C Hamano wrote:

> Thanks for bringing this issue up and proposing a pair of improvements.
> 
> I am very inclined to apply [1/2] to maint.  I am not convinced if [2/2]
> is a good idea in general but if it is silent on pull and verbose on
> one-off fetch without local store, it probably is an improvement.

I think that is the right behavior for 2/2; I was just being a little
lazy earlier. I will try to work up an improved 2/2, but I will probably
be out of touch for a few days. Maybe we will see some comments from the
list in the meantime.

-Peff
