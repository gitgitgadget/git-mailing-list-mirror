From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 17:33:25 +0200
Message-ID: <49F1DBC5.4070305@drmicha.warpmail.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net> <49F1D857.7060100@viscovery.net> <5A5A3681-08E7-4343-BBB1-B1CB52D8B492@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNQy-00067Z-5h
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbZDXPde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbZDXPdd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:33:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43109 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799AbZDXPdc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 11:33:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3AF5B322BC1;
	Fri, 24 Apr 2009 11:33:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 24 Apr 2009 11:33:32 -0400
X-Sasl-enc: ChB0+WJ6UtPxqO0O43PJ/RKliQUHTo2Mi7By9KPgbM8I 1240587211
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7290B2CC48;
	Fri, 24 Apr 2009 11:33:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <5A5A3681-08E7-4343-BBB1-B1CB52D8B492@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117459>

Wincent Colaiuta venit, vidit, dixit 24.04.2009 17:23:
> El 24/4/2009, a las 17:18, Johannes Sixt escribi=F3:
>=20
>> Michael J Gruber schrieb:
>>>
>>> +	The database has an object who's SHA-1 doesn't match the
>=20
> Not related to SHA1 vs SHA-1, but:
>=20
> s/who's/whose/

Yes, but I refrained from doing "while we're at it" stuff. The only
other changes besides sha1/SHA-1 etc. are replacing e.g. "oldsha1" by
"SHA-1-old" and "sha1's" by "SHA-1s" for the plural.

Michael
