From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 21:22:32 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070123202231.GA2765@cepheus>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org> <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.20498.635623.173653@lisa.zopyra.com> <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.27694.845530.663964@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 21:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9SAQ-000326-5v
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbXAWUWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 15:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbXAWUWt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:22:49 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33110 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933004AbXAWUWt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 15:22:49 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9SAJ-0002pm-Po; Tue, 23 Jan 2007 21:22:47 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0NKMiim026659;
	Tue, 23 Jan 2007 21:22:44 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0NKMVe0026658;
	Tue, 23 Jan 2007 21:22:31 +0100 (MET)
To: Bill Lear <rael@zopyra.com>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <17846.27694.845530.663964@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37565>

Hello Bill,

>=20
> % export PAGER=3Dless
> % unset LESS
> % git diff
>=20
> I get 30 lines of output in my current repository, as I should.
>=20
> If I then do this:
>=20
> % LESS=3D-FRS git diff
What about:

	LESS=3D-FRSX git diff

?

HTH
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsin%28pi%2F2%29
