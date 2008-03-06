From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: "bash: git-upload-pack: command not found" ??
Date: Thu, 6 Mar 2008 20:57:44 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20080306195743.GA1614@informatik.uni-freiburg.de>
References: <20080306110600.GA925@cs-wsok.swansea.ac.uk> <20080306124710.GA10266@informatik.uni-freiburg.de> <20080306135456.GG925@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXMEs-0007wo-BE
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 20:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbYCFT6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbYCFT6L
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 14:58:11 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:56451 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756017AbYCFT6K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 14:58:10 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1JXMED-0003UC-FX; Thu, 06 Mar 2008 20:58:09 +0100
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1JXMDo-0000Vm-3z; Thu, 06 Mar 2008 20:57:44 +0100
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080306135456.GG925@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76414>

Hallo Oliver,

Oliver Kullmann wrote:
> >  Does=20
> >=20
> > 	git pull --upload-pack /path/to/git-upload-pack ...
> >=20
> > help?
> >
>=20
> Yes! That solves it (I won't fiddle around with the path settings,
> since I have also local installs etc., and that additional specificat=
ion
> does the job).
Then you might like the config variables remote.<name>.uploadpack and
remote.<name>.receivepack.

Best regards,
Uwe

--=20
Uwe Kleine-K=F6nig

