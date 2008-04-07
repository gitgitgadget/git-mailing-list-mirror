From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [REGRESSION] git-gui
Date: Mon, 7 Apr 2008 11:10:52 +0300
Message-ID: <20080407081052.GA5413@mithlond.arda.local>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <871w5it8r7.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, maillist@steelskies.com
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimS5-0001tY-RB
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbYDGIKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2008 04:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYDGIKz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:10:55 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:43886 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396AbYDGIKy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 04:10:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A00379835; Mon, 7 Apr 2008 10:10:53 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JimRI-0001Po-CZ; Mon, 07 Apr 2008 11:10:52 +0300
Mail-Followup-To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, maillist@steelskies.com
Content-Disposition: inline
In-Reply-To: <871w5it8r7.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78960>

David K=E5gedal kirjoitti (7.4.2008 klo 9.38):

> "Jonathan del Strother" <maillist@steelskies.com> writes:
>=20
> > Anyone else got any opinions on an appropriate shortcut?  How about
> > '=3D' and '-' (+ and - without the shift), or are those not
> > necessarily together either?  (Are there really layouts where '['
> > and ']' aren't next to each other?)
>=20
> A Swedish keyboard has [] on alt-gr (Modeshift) 8 and 9.  Plus and
> minus are unshifted and =3D is on shift-0.
>=20
> So with a Swedish layout, it is annoying when zoom in is on =3D rathe=
r
> than +, just because someone assumed that it would be harder to press
> the more logical plus key.

The above also applies to Finnish and Norwegian keyboards, probably to
many more. The key pair '=3D' and '-' would be a poor UI decision. In
principle one should never assume that a key is in certain place in the
keyboard; it's much better idea to be logical with _characters_. So if
a key pair much be defined for different aspects of the same
functionality, let's choose logical pairs from common characters: +- []
{} () <> zZ aA bB ... (To me all these are OK.)
