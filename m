From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Thu, 2 Dec 2010 02:02:29 +0100
Message-ID: <20101202010229.GA4832@neumann>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
	<201012011557.30849.jnareb@gmail.com>
	<20101201150917.GD6537@picasso.cante.net>
	<201012011737.53652.jnareb@gmail.com>
	<87vd3dv2ow.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 02:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNxZG-0001T0-E2
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 02:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab0LBBCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 20:02:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63028 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0LBBCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 20:02:33 -0500
Received: from localhost6.localdomain6 (p5B130DE7.dip0.t-ipconnect.de [91.19.13.231])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LlJ5u-1Omyv241m2-00aToD; Thu, 02 Dec 2010 02:02:31 +0100
Content-Disposition: inline
In-Reply-To: <87vd3dv2ow.fsf@picasso.cante.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:dupZ9Nq4C/xS8LqiBCoYZ/DogjNZHquT/E8cGIP5VAA
 OQKGWjSA/dgwp4of21XMp0ZrmSvEdqLvC0M/Fgh91pbRrrN5ns
 /664QOd5GwAmJuJ7SOilxHpgijuW6jzH8MhKr3/qxZpaq8GWJD
 Z+KDOQ44mt4sdzTpvEz/RDlOzkr+X/7R/6n82e4+ozMqSX9zeF
 p0FYregKZpWuY1ggwmdCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162657>

On Wed, Dec 01, 2010 at 07:10:55PM +0200, Jari Aalto wrote:
> 2010-12-01 18:37 Jakub Narebski <jnareb@gmail.com>:
> > Having related config variables together is IMVHO more important th=
an
> > having config variables sorted alphabetically.
>=20
> That's subjective criteria.

I agree with Jakub; his criteria might be subjective, but it's highly
practical, while your examples are not.

> Most of the time you want to look up X. And alpha order is what docto=
r
> ordered.
>=20
> Same for command line options. You read zillions of scripts and crypt=
ic
> options. You want to consult manual page to see what an option means.=
 Again
> you're searching A-Z.

When I want to look up X or a command line option seen somewhere, I
never search A-Z.  I always search using the pager's or browser's
search function.  And when it found what I was searching for, then I
much prefer to see related options on the same screen.

Best,
G=E1bor
