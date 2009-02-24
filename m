From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 10:28:35 +0100
Message-ID: <49A3BDC3.8030809@gmail.com>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtTD-0000OG-4o
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbZBXJTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbZBXJTM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:19:12 -0500
Received: from hoat.troll.no ([62.70.27.150]:53923 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZBXJTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:19:10 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9988820F3B;
	Tue, 24 Feb 2009 10:19:08 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 9078520EBF;
	Tue, 24 Feb 2009 10:19:08 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n1O9J8PG018564;
	Tue, 24 Feb 2009 10:19:08 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 24 Feb 2009 10:19:08 +0100 (CET)
In-Reply-To: <200902240806.38710.robin.rosenberg.lists@dewire.com>
References: <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
References: <49A33862.90507@gmail.com>
References: <200902240806.38710.robin.rosenberg.lists@dewire.com>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111247>

Robin Rosenberg wrote:
> tisdag 24 februari 2009 00:59:30 skrev Tor Arne Vestb=F8 <torarnv@gma=
il.com>:
>> Ferry Huberts wrote:
>>> Add an ignored icon to the label decorations page and make
>>> sure that it is actually decorated: from now on do not ignore
>>> ignored resources during decoration.
>> The reason this was not added in the original series was because tha=
t's
>> kind of the point of ignoring a resource -- you don't want any
>> information about it. Also, none of the other team plugins provide
>> decorations for ignored resources-
>=20
> "Ignored" in this context does not mean unimportant.  It means we wil=
l
> not track it in git, which is quite important.

True, it's important. Untracked already has a decoration (the '?'), and=
=20
tracked files have the yellow database icon. I'm just saying the=20
convention so far in Eclipse has been to use non-decoration (no ? or=20
yellow db icon) to signal ignored resources.

Tor Arne
