From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/4] t9903: add tests for git-prompt pcmode
Date: Mon, 24 Jun 2013 18:21:34 +0200
Message-ID: <20130624162134.GA2136@goldbirke>
References: <cover.1371780085.git.erdavila@gmail.com>
 <3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
 <20130622130604.GK20052@goldbirke>
 <CAOz-D1L3mrqTKwpnRVEEfZayFNX+eKVNC1-Ewy45tmf9MPQhtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>
To: Eduardo D'Avila <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:24:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9Yd-0004Lb-In
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3FXQX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:23:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64209 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3FXQXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:23:55 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MfZE3-1UcV5I08Pj-00OVqJ; Mon, 24 Jun 2013 18:21:35 +0200
Content-Disposition: inline
In-Reply-To: <CAOz-D1L3mrqTKwpnRVEEfZayFNX+eKVNC1-Ewy45tmf9MPQhtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:K2n6bL5GwdutiONLYP855UZytxDaqWc93EddWEm8lnU
 sKEpfcxd2fCzfNhEKoLb3eVtuczaMLL6BGoJ41iunuo0aMFaJC
 /G4sSZlrF3fxssl1mzDes+mWtnFPo4LWTgJZeRBftx+rU8XLd1
 uOunutb2oAEA81j0TkHAQFTZcN3ogQcbELu81NDlcXRb+YO/Nd
 ufv4aOvXLtLbmChTcsR69b3B6XZX9tJeU1kNWLfG+KmNWoygNu
 EQLw+TQtU882qNwmwyaP3XJJU8HLdCfjZguEyLivXolItCsAou
 /yC7GjD71v7Q7oUFMVVEFLmLZQQJUCswz2XNbf6aA+LyxpNDlL
 NHytxyd5SGd302qhs+sM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228845>

On Sat, Jun 22, 2013 at 01:32:38PM -0300, Eduardo D'Avila wrote:
> These tests where important to make sure that I wouldn't break anythi=
ng during
> the refactorization. Having them pass before *and* after refactorizat=
ion
> guarantees that nothing was broken (except for some subtle case that =
might have
> not be included in the tests).
>=20
> However, I agree that they became redundant.
>=20
> Would it make sense to include a patch that only removes the zsh
> tests, after the
> refactorization?

That would be fine with me.


Thanks,
G=E1bor
