From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RESEND PATCH] french translation of gitk
Date: Tue, 12 Jan 2010 22:21:22 +1100
Message-ID: <20100112112122.GD6685@brick.ozlabs.ibm.com>
References: <20091202112403.52abcd75@eleanor>
 <c558c59b3fe779e8577fe06233d3da5d2711127f.1259795550.git.ni.s@laposte.net>
 <20091229223758.GB12965@vidovic>
 <20100108142218.386bf6a2@eleanor>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Guy Brand <gb@unistra.fr>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 12:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUeqW-0003kZ-9Y
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 12:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab0ALLXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 06:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032Ab0ALLXb
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 06:23:31 -0500
Received: from ozlabs.org ([203.10.76.45]:51370 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab0ALLXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 06:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id BACAEB7C6D; Tue, 12 Jan 2010 22:23:29 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20100108142218.386bf6a2@eleanor>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136715>

On Fri, Jan 08, 2010 at 02:22:18PM +0100, Emmanuel Trillaud wrote:

> Hi all,=20
> Thank Nicolas for beeing the ambassador this translation :-)
>=20
> Le Tue, 29 Dec 2009 23:39:39 +0100,
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> a =E9crit :
>=20
> > Hi,
> >=20
> > I may be wrong but I think this patch wasn't merged and I didn't se=
e any
> > comment on it.
> >=20
> > Could you please merge this patch?
> >=20
> >=20
> > -- >8 --
> > Subject: [PATCH] gitk: french translation
> > From: Emmanuel Trillaud <etrillaud@gmail.com>
> >=20
> > Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
> > Signed-off-by: Thomas Moulard <thomas.moulard@gmail.com>
> > Signed-off-by: Guy Brand <gb@unistra.fr>
> > Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> > ---
> [snip]
>=20
> I got the following errors when trying to 'make' gitk with your lates=
t patch :
>=20
> $ LANG=3DC make
> Generating catalog po/fr.msg
> msgfmt --statistics --tcl po/fr.po -l fr -d po/
> po/fr.po:23:24: invalid multibyte sequence

[etc]

I get those errors too.  Could somebody resend a corrected patch,
please?

Paul.
