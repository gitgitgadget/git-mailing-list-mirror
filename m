From: Petr Baudis <pasky@suse.cz>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 13:33:40 +0100
Message-ID: <20100212123340.GV4159@machine.or.cz>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
 <20100211214833.GU9553@machine.or.cz>
 <201002120502.43565.chriscool@tuxfamily.org>
 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
 <20100212113538.GV9553@machine.or.cz>
 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
 <20100212121844.GK4159@machine.or.cz>
 <e72faaa81002120424y5d54f6e9y9013d416057d962a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuiS-0002BH-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0BLMdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 07:33:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49208 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab0BLMdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:33:42 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id AADFC86208A; Fri, 12 Feb 2010 13:33:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e72faaa81002120424y5d54f6e9y9013d416057d962a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139695>

On Fri, Feb 12, 2010 at 05:54:29PM +0530, Pavan Kumar Sunkara wrote:
> > =A0However, I'm a bit unsure if you aren't loading too much on your=
self,
> > seeing how much effort it took the other projects to implement *jus=
t the
> > read-only parts* properly. So I still wonder why it wouldn't be bet=
ter
> > to focus purely on the editing and commit creation, while relying o=
n
> > an existing web interface to provide the history browsing, diffs, e=
tc.
>=20
> Yeah, My GSoC project will consist of this. Remaining all
> functionalities will be coded after i finish GSoC.
>=20
> > =A0This could be done in several ways - simply taking a client and =
adding
> > your code to provide the extra functionality there, OR creating a
> > standalone project that would be cross-linked with a given web
> > interface. The latter option is interesting since your extension co=
uld
> > work easily with the web interfaces of choice (and e.g. modifying g=
itweb
> > to provide the appropriate links is trivial, to a degree even possi=
ble
> > purely from config file).
>=20
> I am intended to link it with gitweb.

That sounds great!

> > =A0P.S.: I could volunteer to mentor such a project, if no more act=
ive
> > Git hacker shows interest. Perhaps Jakub Narebski might be interest=
ed?
>=20
> Wow. That's great, If u could get a confirmation that somebody is
> willing to mentor this, then i can start the project even before the
> start of GSoC itself.

Please note that Google provides a funding to a limited number of
projects and the willingness to mentor a project does not mean yet that
we will choose your project in particular for the GSoC program. I can
still provide you with guidance outside of the GSoC frame and your
contributions will still be certainly welcome, but we can decide which
projects to choose for GSoC only when we receive all the applications.

--=20
				Petr "Pasky" Baudis
A great many people think they are thinking when they are merely
rearranging their prejudices. -- William James
