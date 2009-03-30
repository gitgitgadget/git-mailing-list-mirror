From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 16:47:20 +0200
Message-ID: <49D0DB78.2010204@drmicha.warpmail.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-5-git-send-email-santi@agolina.net> <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com> <49D0C3B8.2050801@drmicha.warpmail.net> <20090330134544.GA31827@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoInM-00087C-5N
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbZC3Ord convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbZC3Ord
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:47:33 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52799 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977AbZC3Orc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 10:47:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 05E40307D3A;
	Mon, 30 Mar 2009 10:47:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 30 Mar 2009 10:47:30 -0400
X-Sasl-enc: vtKSYAoy9vz4NIDTvlJ1/BkPu45kbGfdMFHbSvnKplbc 1238424449
Received: from localhost.localdomain (p4FC63759.dip0.t-ipconnect.de [79.198.55.89])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 16BF92D162;
	Mon, 30 Mar 2009 10:47:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090328 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090330134544.GA31827@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115161>

Jeff King venit, vidit, dixit 30.03.2009 15:45:
> On Mon, Mar 30, 2009 at 03:06:00PM +0200, Michael J Gruber wrote:
>=20
>>> I don't see the quoted-printable characters, I see them in utf-8 an=
d 8bit.
>>>
>>> Content-Type: text/plain; charset=3Dutf-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> Maybe some server in between is recoding it.
>>
>> That's weird. I read through gmane/nntp, but others' posts are fine.
>> Yours have
>>
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Transfer-Encoding: QUOTED-PRINTABLE
>=20
> If a subscriber's mailserver does not support the 8BITMIME SMTP
> extension, then vger will (correctly) encode an 8bit message as QP.
> Gmane's mailservers do not seem to support 8BITMIME.
>=20
> You see it only with Santi's message because most messages are alread=
y
> 7bit clean; however, the accent in his name requires git to mark it a=
s
> 8-bit.

Thanks for the explanation! I rechecked, and for sure it also happened
with patches from Tor Arne Vestb=C3=B8 and Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy.
Again I feel blessed by my umlautlessness... and challenged by gmane.
About time to ditch it for reading patches also, or at least to be awar=
e
of it when saving patches.

Michael
