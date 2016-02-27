From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/3] sha1_file.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:25:42 -0500
Message-ID: <20160227182542.GA12822@sigill.intra.peff.net>
References: <20160225142004.GA17678@sigill.intra.peff.net>
 <1456559373-13589-1-git-send-email-pclouds@gmail.com>
 <xmqq37sehwzu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, d33tah@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:25:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjYu-0000uB-AV
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992462AbcB0SZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 13:25:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:50770 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756618AbcB0SZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:25:46 -0500
Received: (qmail 31542 invoked by uid 102); 27 Feb 2016 18:25:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 13:25:45 -0500
Received: (qmail 14455 invoked by uid 107); 27 Feb 2016 18:25:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 13:25:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:25:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37sehwzu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287716>

On Sat, Feb 27, 2016 at 09:41:09AM -0800, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
> >  Since jk/pack-idx-corruption-safety is already in 'next', can we a=
dd
> >  this patch on top? Surrounding strings are handled separately [1] =
by
> >  another series.
> >
> >  [1] http://thread.gmane.org/gmane.comp.version-control.git/287661/=
focus=3D287678
>=20
> Thanks, I think this makes sense.  Peff--I do not think I missed a
> reason we shouldn't take this?

No, seems fine to me.

-Peff
