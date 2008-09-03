From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 07:45:52 -0700
Message-ID: <20080903144552.GA27682@spearce.org>
References: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 16:49:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KatdN-0001ic-Fh
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 16:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbYICOpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbYICOpy
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 10:45:54 -0400
Received: from george.spearce.org ([209.20.77.23]:60121 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbYICOpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 10:45:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9874538375; Wed,  3 Sep 2008 14:45:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809031607.19722.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94799>

Jakub Narebski <jnareb@gmail.com> wrote:
> This is partial summary of Git User's Survey 2008 [...]
>=20
> 03. With which programming languages are you proficient?
>=20
> Around 939 people answered this question.  C is most popular with 59%=
;
> Ruby and surprisingly a bit shell script programming have around seco=
nd
> place, with about 52-53%.  More people are proficient with Python tha=
n=20
> in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
> feel proficient in Tcl/Tk, which means shallow pool of possible git-g=
ui
> and gitk contributors.  Java is quite popular with around 42%, which
> gives hope in continued JGit/EGit development.

Yea, I liked seeing that result from our user base.  42% of the
respondants know Java as a language.  Not all of them may like
programming in it for fun, but at least they claim they know it.  :-)

In the IDE part Eclipse received 13% (124 responses), which is
almost close to Emacs (20%, 193 responses).  Sadly only 2% (19
responses) use EGit.  There's probably a lot of reasons for that.
Possibly the "egit_sux" tag on repo.or.cz.  Or our lack of a stable
update site that users can install reasonably stable versions from.


I think we've picked up 3 new contributors recently to the JGit/EGit
project.  Jonas Fonseca has started to use JGit inside of a NetBeans
IDE plugin.  Today he posted 2 patches, hopefully the first of many.

Tor Arne Vestb=EF=BF=BD has been working on improving EGit's resource
decorator.  His fork on repo.or.cz is a few days old, but it has
some really good potential in there.  I'm looking forward to seeing
the final series from his work.

Charles O'Farrell joined us a few weeks back and added support for
ref deletion, along with CLI for "jgit branch -d/-D".  I think his
time is rather limited, but the contributions are most appreciated.

And of course Marek Zawirski is still contributing, but I think
he's back in classes so his time is a little bit more constrained.

Months back I think someone asked about including JGit in a
commerically licensed product.  Since its 3-clause BSD its quite
possible to do.  But I haven't seen anything materialize yet on
that front.

--=20
Shawn.
