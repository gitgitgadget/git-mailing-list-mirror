From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 09 Nov 2007 22:13:28 +0100
Message-ID: <4734CD78.4000704@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <Pine.LNX.4.64.0711090122470.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 22:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqbAy-0001RX-OR
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 22:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbXKIVNu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXKIVNu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 16:13:50 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:41862
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751385AbXKIVNt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 16:13:49 -0500
Received: from [10.0.1.201] (p57B7F63C.dip.t-dialin.net [87.183.246.60])
	by neapel230.server4you.de (Postfix) with ESMTP id C9067873BA;
	Fri,  9 Nov 2007 22:13:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711090122470.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64260>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Fri, 9 Nov 2007, Ren? Scharfe wrote:
>=20
>>  strbuf.c |   24 ++++++
>>  strbuf.h |    3 +
>>  pretty.c |  276 ++++++++++++++++++++++++++++++++++-----------------=
-----------
>=20
> I would be so grateful if you could (trivially) split up this patch i=
nto=20
> the addition of strbuf_expend() (with a small example in the commit=20
> message), and a patch that uses it in pretty.c.

Makes sense.  Will do next time.

Thanks,
Ren=E9
