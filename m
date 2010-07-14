From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3] add configuration variable for --autosquash
	option of interactive rebase
Date: Wed, 14 Jul 2010 13:50:03 +0200
Message-ID: <20100714115003.GA15316@book.hvoigt.net>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org> <20100713112316.GA758@book.hvoigt.net> <AANLkTilFOOK1eXkzWJXlr3zf78xZ82nIK9Jrr1END3-Y@mail.gmail.com> <7vlj9f4b5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 13:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ0Te-0005fp-0o
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 13:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0GNLuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 07:50:07 -0400
Received: from darksea.de ([83.133.111.250]:51832 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753294Ab0GNLuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 07:50:06 -0400
Received: (qmail 18429 invoked from network); 14 Jul 2010 13:50:03 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Jul 2010 13:50:03 +0200
Content-Disposition: inline
In-Reply-To: <7vlj9f4b5a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150980>

Hi,

On Tue, Jul 13, 2010 at 09:08:49AM -0700, Junio C Hamano wrote:
> Santi B=E9jar <santi@agolina.net> writes:
>=20
> > You could also merge this entry with the --autosquash as with --squ=
ash
> > option in git-pull(1):
> >
> > --autosquash::
> > --noautosquash::
> > [original text]
> > +
> > If the '--autosquash' option is enabled by default using the
> > configuration variable `rebase.autosquash` this option can be
> > used to override and disable this setting.
>=20
> Thanks for the suggestion; that probably reads better.

Same from me. Will change the patch accordingly.

cheers Heiko
