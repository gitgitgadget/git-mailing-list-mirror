From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Wed, 24 Jan 2007 11:06:28 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070124100628.GA7872@informatik.uni-freiburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org> <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.20498.635623.173653@lisa.zopyra.com> <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.27694.845530.663964@lisa.zopyra.com> <20070123202231.GA2765@cepheus> <17846.28847.436225.732284@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 11:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9f1Y-0002B7-Jk
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXAXKGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 05:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXAXKGd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:06:33 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36187 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942AbXAXKGc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 05:06:32 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9f1T-0002yE-A6; Wed, 24 Jan 2007 11:06:31 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0OA6SuO007988;
	Wed, 24 Jan 2007 11:06:29 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0OA6Si9007987;
	Wed, 24 Jan 2007 11:06:28 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <17846.28847.436225.732284@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37618>

Bill Lear wrote:
> On Tuesday, January 23, 2007 at 21:22:32 (+0100) Uwe Kleine-K=F6nig w=
rites:
> >> % export PAGER=3Dless
> >> % unset LESS
> >> % git diff
> >>=20
> >> I get 30 lines of output in my current repository, as I should.
> >>=20
> >> If I then do this:
> >>=20
> >> % LESS=3D-FRS git diff
> >What about:
> >
> >	LESS=3D-FRSX git diff
>=20
> Well, I see output when there is output to show, yes, but it still
> blanks the screen --- or, I should say, scrolls all the way to the
> bottom --- when there is no difference to show.
Ah, OK, now I got it.  Sorry, I understood you wrong.  Seems like
something that needs fixing in less.  At least I cannot find an option
for that.  But I'm not sure that all people would consider that being a
bug.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D72+PS+point+in+inch
