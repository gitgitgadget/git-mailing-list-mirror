From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 16:11:32 +0200
Message-ID: <8A00EA31-ED43-45CF-A162-66DC45AE41F0@wincent.com>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 16:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kat7g-00073w-S6
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 16:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbYICONI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 10:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbYICONH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 10:13:07 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:55313 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbYICONG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 10:13:06 -0400
Received: from cuzco.lan (98.pool85-53-1.dynamic.orange.es [85.53.1.98])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m83EBXFg009061
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 3 Sep 2008 10:11:38 -0400
In-Reply-To: <20080903131507.GC12936@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94798>

El 3/9/2008, a las 15:15, Jeff King escribi=F3:

> On Wed, Sep 03, 2008 at 09:45:08AM +0200, Johan Herland wrote:
>
>> But what happened to the various suggestions in that original =20
>> thread on
>> adding a safety valve when _leaving_ the detached state (i.e. =20
>> preventing
>> the user from leaving their detached commits unreachable)?
>
> Hrm. I thought we decided on a message like:
>
>  Previous HEAD position was 1234abcd
>
> when leaving the detached HEAD state, but it seems to have =20
> disappeared.

Mightn't "Previous HEAD position was 1234abcd (detached)" be even more =
=20
helpful?

Cheers,
Wincent
