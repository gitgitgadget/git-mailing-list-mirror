From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Wed, 30 Dec 2015 15:57:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512301556490.14434@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <alpine.DEB.2.20.1512201519590.6483@virtualbox> <56773264.2050806@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-587991926-1451487458=:14434"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 15:59:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEIDN-0004SP-Am
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 15:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbbL3O6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 09:58:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:64706 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbbL3O6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 09:58:14 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MOw4N-1aIxQj3SmV-006OMS; Wed, 30 Dec 2015 15:57:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56773264.2050806@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:F9XgnG2QPrYbbzIgaR0cRUbL5iCeeRP2eJys7hMy7QcqBEsdqfs
 AAhm9ag+gh0JXvEwp9ySwK+sTZ1MgUGnRI/SFh/QAqObY5HO8+ae9Q2/684IHSqPgeTwXoi
 b7I6bBOt/y13dNt31uoUHTbc8LXe25lkPW+rlGb1zv3xT4Fe48IPgcFTmC2uxk41OBordC0
 wB4ifEUeCPQKyKrHDFrHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6v+aR4QGsII=:z8g7gXhobXrRv1Hu+pjEtC
 Eqd4GFU90LTjy8DJBogU0oZgsJcemdJmQW8pFH3Zy9wFzl0vT/nQH8WhnLLxygAiJf25pDkTz
 ZSUUlrvw0WmdkKHFD8JG99FwL4q6AU1631yHU8XxniwonSoNw7/k1f9fdYT2U+37AziCDrT+3
 +LvuF8aOwXdfYW+zlvb6lI+an2kkLXDVUQXG8OxMBDCk/iYUET2WSQ9Mdl2EwXglRmcs9YMO4
 J2/U/LubGmsQp7MGD2hXypevUgl7WtseJLm5z2cf3EFLdsaccBiofS6NmgmQSuKYskLcSrNQz
 ajcHffYZhFDVf+1VEopvjkondGmad850Yqx/TC+nR7rDM4Km/MBWiV6vFrLy7gbWRwn2i7jEr
 y1OcOHnHIaCbUD/zPXYMnkC3lwhxa5gBbbuwiA2kdx59cacDyemQs7Vi7dvdO3oxilPG6g3RK
 1cELvwsOXvKqqdLrOW1arp+A/bl8BerapaO2IqEe0uX0BPY4DjSgJ/ePCIhR9VKkztSWrfaHd
 wv5YSTKBCD1qO+8KjDXzJFW/pds/Vs42lHarax5b0lpFaayg6cN01exe16PiZ1zUR6XPxUX6L
 hiRB0K2LvAFZJX82YcAZDkm1sXAAWBLXTaCZ/ueiMi+9m0SN3v83/qLneru0W4dtQG15HZvQY
 by8FHHrf2SMLGiXTRRqsqirfQ9kCdYQKuy0XG3VtVaX88ySB844IEvqPqB8631m6Hg6B7cFQ2
 v7ap5x9ePrMN2pnBnMmhb2UqdN7xLwDV0ArSKTdZCpzZKcpE27HsyjbYkg7k5n92zjuD0BYb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283185>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-587991926-1451487458=:14434
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sun, 20 Dec 2015, Torsten B=F6gershausen wrote:

> On 2015-12-20 15.21, Johannes Schindelin wrote:
>
> > I have to point out that the adjust_shared_perm() call must come after
> > the *fclose()* call, to avoid modifying files to which we currently
> > have open file handles.
>=20
> I had the same concern, but couldn't find anything that gives a hint
> that we can't adjust the permissions on an open file.

Oops, okay! I misremembered. This makes our task much easier now.

Thanks!
Dscho
--8323329-587991926-1451487458=:14434--
