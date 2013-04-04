From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 4 Apr 2013 22:49:44 +0200
Message-ID: <20130404204944.GB4913@pengutronix.de>
References: <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
 <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
 <20130307185046.GA11622@sigill.intra.peff.net>
 <20130404203344.GA25330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>, kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNr71-0004UY-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760892Ab3DDUtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 16:49:55 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760708Ab3DDUty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:49:54 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UNr6Q-0007Ci-Rr; Thu, 04 Apr 2013 22:49:46 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UNr6O-000358-NX; Thu, 04 Apr 2013 22:49:44 +0200
Content-Disposition: inline
In-Reply-To: <20130404203344.GA25330@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220100>

Hi Jeff,

On Thu, Apr 04, 2013 at 04:33:44PM -0400, Jeff King wrote:
> [...]
> So I do think zdiff3 is useful, and I plan to continue using it.
Thanks for your description. I'm using and liking zdiff3, too. So I'd
really like seeing it in vanilla git.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
