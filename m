From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Thu, 2 Dec 2010 10:32:58 +0100
Message-ID: <20101202093258.GA7035@neumann>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
	<201012011557.30849.jnareb@gmail.com>
	<20101201150917.GD6537@picasso.cante.net>
	<201012011737.53652.jnareb@gmail.com>
	<87vd3dv2ow.fsf@picasso.cante.net> <20101202010229.GA4832@neumann>
	<87oc94spax.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 10:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO5XK-0001tu-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 10:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab0LBJdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 04:33:03 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:62488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335Ab0LBJdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 04:33:01 -0500
Received: from localhost6.localdomain6 (p5B130C9F.dip0.t-ipconnect.de [91.19.12.159])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LodLS-1OmIk52NYI-00gkPr; Thu, 02 Dec 2010 10:33:00 +0100
Content-Disposition: inline
In-Reply-To: <87oc94spax.fsf@picasso.cante.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ULrdTlMwi9JRDdeXqW1AHaY+2UGwEWfxdXQfry2EI3L
 5ZGRzxFSS85HpcToxvF6gU27kma+gHbIzAf9BB7plVMJOutany
 U1ZyN3QL3qkoNBFQ5K8petdbO8iz4N4Q97BrRxtEUly/7eey62
 z4ATb6VsFNucvBLua850vo1o4MkyOeNnengfVgLkAdUBWIF8HL
 zA/VJthSFPKULkqT9aZQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162688>

Don't cull the Cc list.


On Thu, Dec 02, 2010 at 07:43:02AM +0200, Jari Aalto wrote:
> 2010-12-02 03:02 SZEDER G=E1bor <szeder@ira.uka.de>:
> > On Wed, Dec 01, 2010 at 07:10:55PM +0200, Jari Aalto wrote:
> >> Same for command line options. You read zillions of scripts and cr=
yptic
> >> options. You want to consult manual page to see what an option mea=
ns. Again
> >> you're searching A-Z.
> >
> > When I want to look up X or a command line option seen somewhere, I
> > never search A-Z.  I always search using the pager's or browser's
> > search function.  And when it found what I was searching for, then =
I
> > much prefer to see related options on the same screen.
>=20
> That=E4s real slow method.

Based on my own experience, I disagree, ...

> You don't need specific search function (or reliance on those
> availability[*]) when you can just tap
>=20
>     PgUp
>     PgDown
>=20
> to locate the information by visual cues (A-Z).

=2E.. and therefore I much prefer using the search function.

> [*] less(1) is not the default manual page pager everywhere.

I assume that nowadays search-capable pagers are much more widespread
than non-search-capable ones.


G=E1bor
