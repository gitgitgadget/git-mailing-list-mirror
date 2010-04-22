From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull behavior changed?
Date: Thu, 22 Apr 2010 10:10:56 +0200
Message-ID: <20100422081055.GG3563@machine.or.cz>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
 <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <86tyr4v12n.fsf@red.stonehenge.com>
 <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 10:11:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4rVH-0005DD-LA
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 10:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0DVILB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 04:11:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46763 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab0DVIK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 04:10:58 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2CE41125A10D; Thu, 22 Apr 2010 10:10:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145508>

On Wed, Apr 21, 2010 at 07:57:17PM -0400, Aghiles wrote:
> On Wed, Apr 21, 2010, Randal L. Schwartz  wrote:
> > =A0 =A0git checkout -b test origin/test
> > =A0 =A0...
> > =A0 =A0git pull
> >
> > And it seems to work. =A0It even announces that my test is tracking=
 origin/test.
>=20
> Yes that syntax works too (although I use origin/master since I am tr=
acking
> the main branch and not the remote "test" branch). Thank you very muc=
h.

So, do I understand it right that there is still no canonical syntax to
check out local branch tracking a remote one of the same name, without
spelling out the branch name twice?

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
