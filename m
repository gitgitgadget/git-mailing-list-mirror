From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 18:43:28 +0200
Message-ID: <20080331164328.GA31518@atjola.homenet>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803310757550.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 18:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgN7M-00042o-TS
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 18:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYCaQnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 12:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbYCaQnd
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 12:43:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:52313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752605AbYCaQnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 12:43:32 -0400
Received: (qmail invoked by alias); 31 Mar 2008 16:43:30 -0000
Received: from i577ADF86.versanet.de (EHLO atjola.local) [87.122.223.134]
  by mail.gmx.net (mp019) with SMTP; 31 Mar 2008 18:43:30 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+UUgMauYGUqr37PvIH/V87SBl+HU0/TPkM5LKdM6
	wOwV6RyzXoOfqe
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803310757550.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78591>

On 2008.03.31 08:02:51 -0700, Linus Torvalds wrote:
>=20
>=20
> On Sun, 30 Mar 2008, Junio C Hamano wrote:
> >=20
> > By the way, Linus, is your MUA UTF-8 challenged?  I see Bj=C3=B6rn'=
s name on
> > the To: header mangled.
>=20
> My MUA is not utf-8 challenged per se, but it doesn't seem to like Bj=
=C3=B6rn's=20
> headers.
>=20
> For example, I see "=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>" perfectly=20
> correctly (Content-Type: text/plain; charset=3DUTF-8), but Bj=C3=B6rn=
's emails=20
> tend to be (Content-Type: text/plain; charset=3Diso-8859-1) but then =
he has=20
> his email address in utf-8, and that seems to be what makes my MUA=20
> unhappy about it.

Hm, that's weird. My header shows my name as iso-8859-1, same as the
body. I checked the copy that I got from the list to eliminate any weir=
d
local-copy effects.

=46rom:	=3D?iso-8859-1?Q?Bj=3DF6rn?=3D Steinbrink <B.Steinbrink@gmx.de>

So maybe your MUA is iso-8859-1 challenged instead? I'll send this one
out as UTF-8.

Bj=C3=B6rn
