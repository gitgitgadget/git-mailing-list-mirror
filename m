From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Wed, 07 Nov 2007 09:53:22 +0100
Message-ID: <47317D02.3050703@op5.se>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de> <20071106202600.GH6361@ins.uni-bonn.de> <7vtznzf5jb.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711062317330.4362@racer.site> <4749D87D-9660-472B-97CF-8E649435AFD7@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:53:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpgfN-0000tm-2s
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbXKGIx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 03:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbXKGIx0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:53:26 -0500
Received: from mail.op5.se ([193.201.96.20]:48332 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbXKGIx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:53:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EED43173064D;
	Wed,  7 Nov 2007 09:53:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQWMM3ydfksk; Wed,  7 Nov 2007 09:53:13 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 21E0B173064A;
	Wed,  7 Nov 2007 09:53:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4749D87D-9660-472B-97CF-8E649435AFD7@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63790>

Wincent Colaiuta wrote:
> El 7/11/2007, a las 0:17, Johannes Schindelin escribi=F3:
>=20
>> Even if our code is quite a good documentation for our coding style,
>> some people seem to prefer a document describing it.
>=20
> Great idea, Johannes, especially your nice concise summary of=20
> conventions for shell-scripts (which is an area where we most often s=
ee=20
> list traffic on which way to write things).
>=20

That was ripped from a mail Junio sent to the list though ;-)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
