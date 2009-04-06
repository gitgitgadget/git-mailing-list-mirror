From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 21:28:48 +0200
Message-ID: <20090406192848.GJ20356@atjola.homenet>
References: <20090331153039.GA1520@atjola.homenet> <20090406114618.GF20356@atjola.homenet> <20090406164732.GA11724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LquWY-000432-F3
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbZDFT2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 15:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZDFT2y
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:28:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:52333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbZDFT2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:28:53 -0400
Received: (qmail invoked by alias); 06 Apr 2009 19:28:49 -0000
Received: from i59F5A3DA.versanet.de (EHLO atjola.local) [89.245.163.218]
  by mail.gmx.net (mp006) with SMTP; 06 Apr 2009 21:28:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+mT59iRFGmp7HvmOSfZIJhEI2Ao6hX2QmzUcGyTz
	CABBpgnYEpABlu
Content-Disposition: inline
In-Reply-To: <20090406164732.GA11724@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115873>

On 2009.04.06 12:47:33 -0400, Jeff King wrote:
> On Mon, Apr 06, 2009 at 01:46:18PM +0200, Bj=F6rn Steinbrink wrote:
>=20
> > On 2009.03.31 17:30:39 +0200, Bj=F6rn Steinbrink wrote:
> > > While it makes no sense to map some email address to an empty one=
, doing
> > > things the other way around can be useful. For example when using
> > > filter-branch with an env-filter that employs a mailmap to fix up=
 an
> > > import that created such broken commits with empty email addresse=
s.
> > >=20
> > > Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> >=20
> > The umlaut (=F6) in my name is broken in the commit that made it in=
to
> > git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3
>=20
> The mail you sent that presumably became 5288dd58 looks fine (both th=
e
> >From and body are properly marked as iso8859-1), and "git am" applie=
s it
> correctly here. I wonder if Junio did something unusual while applyin=
g.

Hm, ok, so I take it that it wasn't me who broke things. Then I'm
already happy. I don't care much about my name being messed up, but jus=
t
wanted to make sure that it wasn't my fault.

Thanks,
Bj=F6rn
