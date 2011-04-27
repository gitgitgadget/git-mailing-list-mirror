From: Drew Northup <drew.northup@maine.edu>
Subject: Re: translation difficulties :: revision and commit
Date: Wed, 27 Apr 2011 16:06:24 -0400
Message-ID: <1303934784.25134.74.camel@drew-northup.unet.maine.edu>
References: <20110427103406.GA7186@jakstys.lt>
	 <alpine.DEB.2.00.1104271327550.23722@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>
To: Motiejus =?UTF-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFB0Y-0007Fw-HE
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab1D0UGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 16:06:41 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:46911 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab1D0UGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:06:41 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3RK6Vtp004218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Apr 2011 16:06:31 -0400
In-Reply-To: <alpine.DEB.2.00.1104271327550.23722@ds9.cixit.se>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3RK6Vtp004218
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304539593.54155@jRo6PSjkZOw/eJIfaIdR7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172267>


On Wed, 2011-04-27 at 13:29 +0100, Peter Krefting wrote:
> Motiejus Jak=C5=A1tys:
>=20
> > I am doing git translation to Lithuanian, and cannot find the diffe=
rence
> > between "revision" and "commit", as I need to create a word for
> > "commit". It is confusing.
>=20
> For Swedish, I used a translation of "check-in" (as when checking in =
at an=20
> airport) for "commit", both in the verb and noun forms.

If you seek to avoid SVN-isms I suggest thinking about the
deconstruction of "commit" in the context we are using it: "to commit
the current state of the working directory as known by Git to the
recorded history." That we are using it as a noun in the Git
documentation is pure jargon, separate from the original verb (which
happens to be transitive in English, making natural noun-ification less
likely).=20
So far as the language element is concerned, it could have been chosen
to be a "flubberbudget" and provided nobody attempted suggesting to
Linus that he'd be insane for calling it that it would have had a decen=
t
chance of staying that way. ;-)

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
