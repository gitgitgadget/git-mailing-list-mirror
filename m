From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 10:48:58 +0100
Message-ID: <201002221048.59188.trast@student.ethz.ch>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org> <6672d0161002220017u7270c637k83a796cfc8730a64@mail.gmail.com> <alpine.DEB.1.00.1002220936030.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:59:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjUub-0002Sb-UO
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 10:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab0BVJtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 04:49:04 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:1685 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab0BVJtB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 04:49:01 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 10:48:59 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 10:48:59 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.1002220936030.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140658>

On Monday 22 February 2010 09:37:54 Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 22 Feb 2010, Bj=F6rn Gustavsson wrote:
>=20
> > On Mon, Feb 22, 2010 at 8:49 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
> > >
> > > In the meantime, please run "git log --oneline --first-parent mas=
ter..pu",
> > > pick "ce8d258 Merge 'jn/maint-fix-pager'" from the output, and us=
e the
> > > second parent ce8d258^2 instead.
> >=20
> > I use a simple Perl script called create-topic-branches.
> > It can be found here:
> >=20
> > http://gist.github.com/275033
>=20
> IIRC Thomas Rast did something similar in the wake of the @{-<n>} wor=
k,=20
> but unfortunately, it did not make it into contrib, it seems.

You mean this one?

  http://permalink.gmane.org/gmane.comp.version-control.git/108330

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
