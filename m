From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] config: test for --replace-all with one argument and
	fix documentation.
Date: Tue, 17 Mar 2009 12:02:27 +0100
Message-ID: <20090317110227.GA2666@pengutronix.de>
References: <1237283197.10001.9.camel@equipo-loli> <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302> <94a0d4530903170341g27f215d4t8c3ad25e7f362590@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carlos Rica <jasampler@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjX5X-0002US-AR
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbZCQLCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 07:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbZCQLCe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:02:34 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35440 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbZCQLCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 07:02:33 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjX42-0000Ca-FJ; Tue, 17 Mar 2009 12:02:30 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjX3z-0006Ar-C0; Tue, 17 Mar 2009 12:02:27 +0100
Content-Disposition: inline
In-Reply-To: <94a0d4530903170341g27f215d4t8c3ad25e7f362590@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113459>

Hello,

On Tue, Mar 17, 2009 at 12:41:29PM +0200, Felipe Contreras wrote:
> On Tue, Mar 17, 2009 at 12:24 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Tue, 17 Mar 2009, Carlos Rica wrote:
> >
> >> Option --replace-all only allows at least two arguments, so
> >> documentation was needing to be updated accordingly. A test showin=
g
> >> that the command fails with only one parameter is also provided.
> >>
> >> Signed-off-by: Carlos Rica <jasampler@gmail.com>
> >
> > Looks obviously correct to me. =A0I am actually unsure if I can ACK=
 this
> > patch, as most of builtin-config.c does not look all that familiar =
to me
> > anymore ;-)
>=20
> Hehe... interesting, my first possibility of ack'ing :D (I guess)
>=20
> Acked-by: Felipe Contreras <felipe.contreras@gmail.com>
It's not nice to ack in public that someone else doesn't know something
anymore. :-)

SCNR
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
