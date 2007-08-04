From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sun, 05 Aug 2007 00:09:39 +0200
Message-ID: <46B4F923.3090604@lsrfire.ath.cx>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx> <Pine.LNX.4.64.0708042232390.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRom-000059-5f
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764957AbXHDWJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764927AbXHDWJp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:09:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59979
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762704AbXHDWJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 18:09:44 -0400
Received: from [10.0.1.201] (p508EBCE0.dip.t-dialin.net [80.142.188.224])
	by neapel230.server4you.de (Postfix) with ESMTP id C8A968B008;
	Sun,  5 Aug 2007 00:09:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0708042232390.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54913>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 4 Aug 2007, Ren? Scharfe wrote:
>=20
>> I can't offer a fix, but I think I've captured install-doc-quick.sh'=
s
>> problem in a test script (see below).  It fails with e90fdc3 (and
>> master) but succeeds with e90fdc3^.
>=20
> It succeeds here... (without the patch I sent out, of course.)

I assume you tested e90fdc3 and e90fdc3^; what about 4f8f03d (current H=
EAD)?

Thanks,
Ren=E9
