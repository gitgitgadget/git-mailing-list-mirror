From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-add.txt: Order options alphabetically
Date: Thu, 2 Dec 2010 02:36:05 +0100
Message-ID: <20101202013605.GA5221@neumann>
References: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
	<1291229622.11917.14.camel@drew-northup.unet.maine.edu>
	<87bp55uw96.fsf@picasso.cante.net>
	<1291232706.11917.35.camel@drew-northup.unet.maine.edu>
	<8739qhuo09.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 02:36:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNy5m-0003qg-VK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 02:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab0LBBgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 20:36:09 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:57411 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0LBBgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 20:36:08 -0500
Received: from localhost6.localdomain6 (p5B130DE7.dip0.t-ipconnect.de [91.19.13.231])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lno43-1Ol2Zl2rOB-00hLvq; Thu, 02 Dec 2010 02:36:06 +0100
Content-Disposition: inline
In-Reply-To: <8739qhuo09.fsf@picasso.cante.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:13SbBr44tICbqONhBro3iR+cn0idJu1iUz59E2AJ9tV
 U7SaIk2buaz5x/yOQvKCG8HMCJPsIU+zPfdgUrXOD976Hr9FyM
 bcFVZh0++dPh8d/Jq0zm36OxoIayi2BU6uPVlh3RJCPAzrnBdP
 hWW1T9x0fbYuK+UdRTHB08UESHCmQa4AMtzf/mEdZkPijFjT1w
 ig0SOYH++Awu5vcRC8x2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162661>

Please don't cull Cc list.


Hi,

On Thu, Dec 02, 2010 at 12:28:06AM +0200, Jari Aalto wrote:
> 2010-12-01 21:45 Drew Northup <drew.northup@maine.edu>:
> > On Wed, 2010-12-01 at 21:29 +0200, Jari Aalto wrote:
> >
> >> 2010-12-01 20:53 Drew Northup <drew.northup@maine.edu>:
> >> > (lacking a commit message to tell me), WHY? [alphabetical]
> >>=20
> >> Quoting <http://permalink.gmane.org/gmane.comp.version-control.git=
/162552>
> >>=20
> >>     - You read from top to bottom, therefore A-Z.
> >>     - GNU project uses it in manual pages. It looks good, it looks
> >>       professional, it looks clean. And it works when searching (=3D=
 no
> >>       oriantation problems regardless of tools; even when you prin=
t on
> >>       paper when you don't have any computerized aids to help your=
 search.).
> >>=20
> >> Jari
> >
> > THAT belongs in a commit message!!!
>=20
> It does not. No need to clutter 10's of message that long in there..

It definitely does.

People doing 'git log -- Documentation/git-add.txt' in the future will
want to see it, just as well as people doing 'git log --
Documentation/git-commit.txt', or 'git log --
Documentation/git-reset.txt', or ....

HtH,
G=E1bor
