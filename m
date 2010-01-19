From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Feature idea: Ignore content
Date: Tue, 19 Jan 2010 20:14:36 +0100
Message-ID: <4B56049C.6070705@dirk.my1.cc>
References: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com> <alpine.DEB.2.00.1001191504020.23165@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 19 20:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJsg-0007bB-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0ASTgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826Ab0ASTgq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:36:46 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:32861 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0ASTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:36:46 -0500
Received: from [84.176.95.159] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1NXJXB-0007uH-BG; Tue, 19 Jan 2010 20:14:37 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.2.00.1001191504020.23165@ds9.cixit.se>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137491>

Am 19.01.2010 15:05 schrieb Peter Krefting:
> Ramkumar Ramachandra:
>=20
>> Instead of moving that out to a separate file and ignoring that file=
,=20
>> is it a good idea to add a feature to Git to allow ignoring content=20
>> instead of whole files?
>=20
> You should be able to do that by setting up a filter. Please see=20
> gitattributes(5) for more information (search for "filter").
>=20

Hi Ramkumar,

please have a look at this thread:
http://marc.info/?t=3D125882165900001&r=3D1&w=3D2
especially Bj=F6rn's suggestion to use a 'clean filter'. It worked fine
for me with a similar problem: I wanted Git to ignore a certain pattern
in my files.

HTH,
Dirk
