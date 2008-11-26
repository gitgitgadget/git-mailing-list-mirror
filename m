From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Wed, 26 Nov 2008 22:19:19 +0100
Message-ID: <20081126211919.GA22474@strlen.de>
References: <1227701580-9762-1-git-send-email-u.kleine-koenig@pengutronix.de> <20081126203959.GB31563@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RoQ-0007fu-4J
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYKZVTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755283AbYKZVTZ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:19:25 -0500
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40351 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755180AbYKZVTX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 16:19:23 -0500
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1L5Rn5-0005vF-DH; Wed, 26 Nov 2008 22:19:19 +0100
Content-Disposition: inline
In-Reply-To: <20081126203959.GB31563@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101770>

Hi,

On Wed, Nov 26, 2008 at 09:39:59PM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008=
=2E11.26.1313 +0100]:
> > addionally fix the README item for skipping the export of empty pat=
ches
> > not to need an option (-n) as this should be the default.
> [...]
> > -	TODO: -n option to prevent exporting of empty patches
> > +	TODO: prevent exporting of empty patches
>=20
> Is it still a TODO? Looks like your patch fixes it, no?
No, it's still a TODO for the collapse driver.

Best regards
Uwe
