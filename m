From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Is there interest in reading ~/.gitconfig.d/* and  /etc/gitconfig.d/*?
Date: Sun, 4 Apr 2010 03:59:25 -0400
Message-ID: <19384.18141.329087.730618@winooski.ccs.neu.edu>
References: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
	<alpine.DEB.2.00.1004040922500.30612@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 09:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyKjz-00076C-Cu
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 09:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab0DDH71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 03:59:27 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:60619 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0DDH7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 03:59:25 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NyKjt-0007xE-CZ
	for git@vger.kernel.org; Sun, 04 Apr 2010 03:59:25 -0400
In-Reply-To: <alpine.DEB.2.00.1004040922500.30612@perkele.intern.softwolves.pp.se>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143917>

On Apr  4, Peter Krefting wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>=20
> > However, I'd like to ask if there's any interest in getting a prope=
r &=20
> > documented patch for this. If so I can submit a proper patch, if no=
t I can=20
> > just continue to patch my Git build with my hack.
>=20
> I'd be interested. I also maintain my .gitconfig in a version control=
 system=20
> (sadly not Git itself, because I don't have it available on all hosts=
 I have=20
> the files checked out on), and would like to be able to store the=20
> host-specific settings out of the way (specifically for me that is=20
> user.email).

Isn't it better to have a way to include files instead?

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
