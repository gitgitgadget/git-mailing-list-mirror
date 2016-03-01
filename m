From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/22] ident.c: mark strings for translation
Date: Tue, 1 Mar 2016 09:56:39 -0500
Message-ID: <20160301145639.GL12887@sigill.intra.peff.net>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
 <1456555333-5853-12-git-send-email-pclouds@gmail.com>
 <xmqqsi0bbc18.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaljE-0007oW-A1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbcCAO4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 09:56:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:52484 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754120AbcCAO4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:56:42 -0500
Received: (qmail 28604 invoked by uid 102); 1 Mar 2016 14:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:56:41 -0500
Received: (qmail 8424 invoked by uid 107); 1 Mar 2016 14:56:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:56:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:56:39 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi0bbc18.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288030>

On Mon, Feb 29, 2016 at 10:34:59AM -0800, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
>=20
> All (or at least most of) these look old ones; even the ones blamed
> to 59f92959 (fmt_ident: refactor strictness checks, 2016-02-04) had
> original in the same file without _().
>=20
> I'm inclined to say we should do the whole thing post 2.8.0 release
> for this file.

I guess I'm cc'd as the author of some of these. These all look fine to
me (and the other one for credential-*). I'm happy to have them down no=
w
or post-2.8.0 (it is really not any work for me, but for the
translators).

-Peff
