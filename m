From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Use --upload-pack in clone, fetch and ls-remote instead of --exec
Date: Tue, 23 Jan 2007 15:05:34 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070123140534.GA6969@cepheus>
References: <20070123082017.GA10007@cepheus> <20070123082437.GA10053@cepheus> <7vveiynnju.fsf@assigned-by-dhcp.cox.net> <7vlkjunlgk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 15:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MHQ-0004af-FY
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbXAWOFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXAWOFj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:05:39 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62557 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965140AbXAWOFi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 09:05:38 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9MHJ-0003jQ-NX; Tue, 23 Jan 2007 15:05:37 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0NE5ZY5017009;
	Tue, 23 Jan 2007 15:05:35 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0NE5YHi017008;
	Tue, 23 Jan 2007 15:05:34 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkjunlgk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37519>

Junio C Hamano wrote:
> [PATCH] ls-remote and clone: accept --upload-pack=3D<path> as well.
>=20
> This makes them consistent with other commands that take the
> path to the upload-pack program.  We also pass --upload-pack
> instead of --exec to the underlying fetch-pack, although it is
> not strictly necessary.
>=20
> [jc: original motivation from Uwe]
>=20
> Signed-off-by: Junio C Hamano <junkio@cox.net>
Acked-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
