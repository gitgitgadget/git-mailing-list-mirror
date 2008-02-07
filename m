From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 18:52:14 +0000
Message-ID: <20080207185214.GA28753@bit.office.eurotux.com>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com> <alpine.LFD.1.00.0802071133230.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNBrm-0002BK-Hy
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 19:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYBGSwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 13:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYBGSwW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 13:52:22 -0500
Received: from os.eurotux.com ([216.75.63.6]:34382 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbYBGSwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 13:52:21 -0500
Received: (qmail 10069 invoked from network); 7 Feb 2008 18:52:19 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 7 Feb 2008 18:52:19 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802071133230.2732@xanadu.home>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72986>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2008 at 11:35:40AM -0500, Nicolas Pitre wrote:
> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>=20
> > On Thu, Feb 07, 2008 at 09:53:05AM -0500, Nicolas Pitre wrote:
> > > What are they forced into if they indeed only want to _use_ Git?
> >=20
> > The msys git installer forces me to accept the GNU GPL in order to
> > proceed.
> >=20
> > Of course, I can use another installer, or compile my own set of
> > binaries. I just wanted to bring that case to attention, nothing else.
> >=20
> > > They nevertheless must be made aware of the rules they have to follow=
 in=20
> > > case the idea of redistributing it crosses their mind.
> >=20
> > I don't dispute that, only that I can't continue with the install unless
> > I click on "I Accept" to the GNU GPL.
>=20
> Then, simply changing the button text from "I accept" to "Continue"=20
> should be OK?

It has two radio-buttons with:

* "I accept the agreement"
* "I do not accept the agreement"

The latter one is the one selected by default, and until the user
selects the "I accept", the "Next>" button is greyed-out.

What I would suggest would be to remove both radio-buttons, and just leave
the "Next>" button active.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHq1NeinSul6a7oB8RAj+TAJsGbviOPq5DKk1L1CKmHfnGpU/gDgCfeVz+
vwzhpb9Qr/iGSHYlqdCUuFg=
=p5cy
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
