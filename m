From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/1] l10n: de.po: use "bla =?UTF-8?B?4oCmIiBpbnN0ZWFk?=
 =?UTF-8?B?IG9mICJibGEuLi4i?=
Date: Tue, 24 Mar 2015 17:29:38 +0100
Message-ID: <551190F2.10808@drmicha.warpmail.net>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com> <CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?B?TWF0dGhpYXMgUsO8c3Rlcg==?= <matthias.ruester@gmail.com>,
	=?UTF-8?B?TWFnbnVzIEfDtnJsaXR6?= <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:29:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaRi8-0007cR-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbbCXQ3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 12:29:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40669 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753792AbbCXQ3l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 12:29:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A6DE6208D1
	for <git@vger.kernel.org>; Tue, 24 Mar 2015 12:29:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 24 Mar 2015 12:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=Iwgm7cDQY4D3yLxEoElGe/amHQA=; b=asv0g/iaxR21yq70Ey
	UAwN9plUqE232+9LoxNi57p1H2L7glM9hby8JGdwMlIhCVsQy7mem4Vwqs9WB8Us
	mJBCNW2Kq9TRfDdKuXLxB7O2CSwkNP6WdjIBo89tjlE9ICqY+nQhVb7O8xRtCrZw
	kpXPqQNn22PDpNcBjyRENFNao=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Iwgm7cDQY4D3yLxEoElGe/
	amHQA=; b=HfD66TjT3OP49idxP0MlhTN2b58DcCDYIN3RIB4f1ydkjrOv2pUriv
	SdiQndABvyPXLTv6IyXTU09EYcXifx/fw8XdldA34M83kxsE+yIPBGZvmsWo7ySC
	JSjoyTBKZcBYMQ/LaPstglikcMXVi+cBd/ODs1W1ih8rFK924yNZY=
X-Sasl-enc: baB7IuP5wzfK8Tg9b16Vx7mXQyALPnjuIcjzVF5yaw1n 1427214579
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 06E5EC00013;
	Tue, 24 Mar 2015 12:29:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266197>

Ralf Thielow venit, vidit, dixit 21.03.2015 22:21:
> Am 21. M=C3=A4rz 2015 um 13:52 schrieb Phillip Sz <phillip.szelat@gma=
il.com>:
>>
>> I think we should use it like this, as most open-source projects do.
>> Also we should use a space before the three dots as per http://www.d=
uden.de/sprachwissen/rechtschreibregeln/auslassungspunkte
>>
>=20
> I don't think this rule of ellipsis applies here as the dots are mean=
t
> to be a pattern to tell users that an argument can be passed multiple
> times.
>=20

"..." is used in (at least) 2 cases:

* ellipsis
* continuation arguments

The patch changes both, but the Duden rule applies to the first case
only (and is different from "legacy rules", I think).

Also, you might want to check the format of other commit messages and
reword yours accordingly.

Michael
