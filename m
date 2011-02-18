From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git svn clone failing
Date: Fri, 18 Feb 2011 07:56:52 -0500
Message-ID: <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vampire <Vampire@Masters-of-Disaster.de>
X-From: git-owner@vger.kernel.org Fri Feb 18 13:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPvK-0008IG-9L
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab1BRM6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 07:58:55 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:46840 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1BRM6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 07:58:54 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1ICuthV031573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Feb 2011 07:57:00 -0500
In-Reply-To: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1ICuthV031573
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1298638676.32304@/0nTsm2WRg4H059cvXIKJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167206>


On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
> Hi,
>=20
> I'm trying to issue the following command:
>=20
> git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/core/ .
>=20
> But unfortunately this fails after some time with the message:
>=20
> RA layer request failed: Server sent unexpected return value (403
> Forbidden) in response to REPORT request for
> '/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn line 4354
>=20
> Regards
> Bj=C3=B6rn

Bj=C3=B6rn,
Have you made sure your subversion client is up-to-date? Does this work
as a plain svn clone? Have you contacted the server admin?
Without context we cannot act on this.

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
