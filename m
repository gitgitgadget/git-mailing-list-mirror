From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] remote-hg: Fix biridectionality -> bidirectionality typos
Date: Tue, 08 Jan 2013 12:50:01 -0500
Message-ID: <20130108175001.GG4662@odin.tremily.us>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
 <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
 <20121128202320.GA22522@odin.tremily.us>
 <20130108154737.GA4662@odin.tremily.us>
 <7vboczfunc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=LZFKeWUZP29EKQNE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:50:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdJj-0007Lf-VY
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819Ab3AHRuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:50:05 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:17620 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab3AHRuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:50:04 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB0068IIVDOI10@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 11:50:03 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 49E2377F48E; Tue,
 08 Jan 2013 12:50:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357667401; bh=OAW5aCUt66HZPE+uVUr8eZ720mNiiA4mkok5xQuvd4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l7BL8X4ieAtDBwbF78AD072/uH5HKKKOFjlmxweAqCTWY+us7DHDMYcY1pK3Gw8ML
 S3vwUUwYbtDejX7HHUMmfV0x1gdLnY2w65WWNFN3BSJLvloD2mSezq3ptThxMml4E4
 gq5m50vZbs42SGj+OsSApOoWoyJ2n19WLncBYiXM=
Content-disposition: inline
In-reply-to: <7vboczfunc.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212985>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 08, 2013 at 09:32:07AM -0800, Junio C Hamano wrote:
> Thanks; didn't Documentation/SubmittingPatches ask you not to do PGP
> multipart but send patches in plain text?

Gah.  I need to tell myself to reread that every time I send a patch
:p.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7FxIAAoJEEUbTsx0l5OM+c4P/3o9x0ERsTQLokrGgHJvlJ7h
nyAc0n1W8HnifF7Eji3mB0Jmf63f8N0yR6iqAAPV0srmwc/JpPfs6cdFLjlzfC5u
WdsfwEcquGhZRAVFKGwQVGCMDzDCsxtYpq7SMU0b5TMg2Fuh+wFnQvHn2sGYIzxy
3jMgrFnsqJlelLTg1Z+lmCohQ8o0c6TAKJnK08tfWc+f+RqJvkah3FIxNlCSZdNX
esqmTpP+SaqurrGkjBXSS57MODfkMJj16FhftDpCx+ujv4ZAlgkBg1p7Qviifegm
M33h+VdCdo6FY1RbuhXJmwiIeRm9HdkBk4TSoqYYxUAAzuOF1qmGTOW0X1Q1eg7Q
kOGqSKGvwu9SqLSUlAUQ3cSedVZTvGnkyfbyekRUulsyj1LFxRRnv+oYTf25OMPc
ZMv+m4csSWubdbfahKOpZASoiSJFg85NUUoFO1NOVmjjXCz8ejNtGVkMDWlWQweq
xJCWTWSyzvuokAHeJW9JCYb6yZeRDS/k7Hn5hjf1q0G17Z0B+AsZ2qxUNB3qmR29
d1zxMRdn4P/Q6cMh0OLhkniiPUrUoNlbN6Ykra+NLAeLjtCUVqiQNsLs3EH0sFES
QcMffyJod9W6dWNWew/Pi6qcDJ/vSC8nf/3sM29AVUC4hzpsB//tawnHNwSiEwOc
+8WTBrSEhBGt6pHTgX/s
=YcdD
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
