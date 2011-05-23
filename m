From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 23 May 2011 19:50:35 -0400
Message-ID: <20110523235035.GD10488@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
 <7vk4dht3z1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 01:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOetX-00086J-2a
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab1EWXui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:50:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53022
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896Ab1EWXui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:50:38 -0400
Received: (qmail 25078 invoked by uid 107); 23 May 2011 23:52:42 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 19:52:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 19:50:35 -0400
Content-Disposition: inline
In-Reply-To: <7vk4dht3z1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174296>

On Mon, May 23, 2011 at 04:02:58PM -0700, Junio C Hamano wrote:

> Yeah, I think the above is sane and matches more-or-less the conclusion of
> the previous discussion Michael quoted.
> 
> I've only read up to this patch (I wanted to conclude the first round of
> today's integration round before 17:00 local) and they all looked good;
> will queue the whole thing to 'pu' in the meantime.

Thanks. I think there is a minor tweak to 5/5 that I posted elsewhere in
the thread. I'll do more testing with it and post tomorrow. I'm done
gitting for today.

-Peff
