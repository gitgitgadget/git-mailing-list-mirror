From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problem in Patches with commit-messages containing non-ascii
Date: Fri, 03 Dec 2010 14:08:20 +0100
Message-ID: <4CF8EBC4.7060107@drmicha.warpmail.net>
References: <4CF8D243.50108@gmx.com> <20101203135944.31d7cfbf@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFydGluIEtyw7xnZXI=?= <martin.krueger@gmx.com>,
	git@vger.kernel.org
To: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Dec 03 14:10:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVPN-00067X-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 14:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab0LCNKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 08:10:39 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54879 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754392Ab0LCNKi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 08:10:38 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED54156D;
	Fri,  3 Dec 2010 08:10:37 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 03 Dec 2010 08:10:37 -0500
X-Sasl-enc: /IOy/O1wOJPYotSwLQambCgRT/5KQ+1q7MvbTLTmqhO0 1291381837
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 58215400D83;
	Fri,  3 Dec 2010 08:10:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101203135944.31d7cfbf@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162797>

Jan Kr=C3=BCger venit, vidit, dixit 03.12.2010 13:59:
> --- Martin Kr=C3=BCger <martin.krueger@gmx.com> wrote:
>=20
>> Consider this log-Message:
>> commit ea2cd63dfe9b3ac3581b6cff8b13a52e69066242
>> Author: martin <martin@chad.upnx.de>
>> Date:   Fri Nov 19 18:58:58 2010 +0100
>>
>>     Methoden =C3=BCberall angepasst.
>>     Ausser Aussnahmen
>>
>=20
> FWIW, support for multi-line summaries is very limited. Several
> tools assume that the log message has this format:
>=20
> <Summary in one line>
> <Blank line>
> <Details>
>=20
> So one could argue that your patch fixes something that isn't really
> supported anyway.
>=20
>> [...]
>>
>> Applyin leads to a correct commit-Messsage:
>>
>> commit 62d06e3415ec0726dbd58c11ed93771502b77805
>> Author: martin <martin@chad.upnx.de>
>> Date:   Fri Nov 19 18:58:58 2010 +0100
>>
>>     Methoden =C3=BCberall angepasst.Ausser Aussnahmen
>=20
> How is that correct? It's different from the original commit message.
>=20
> -Jan

Also, it is "Au=C3=9Fer Ausnahmen" even after the latest spelling refor=
m ;)

Michael
