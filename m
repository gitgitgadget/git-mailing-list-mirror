From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] p5310: mend broken &&-chain
Date: Sat, 11 Jul 2015 02:50:00 +0200
Message-ID: <55A06838.4090808@web.de>
References: <55A02DD9.3020909@web.de> <20150710205029.GA1181@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 11 09:16:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp10-0002sX-Ik
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbbGKHP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2015 03:15:58 -0400
Received: from mout.web.de ([212.227.17.12]:60509 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbbGKHP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:15:57 -0400
Received: from [192.168.178.27] ([79.253.139.191]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MBkHT-1Z6p7303L5-00AnGR; Sat, 11 Jul 2015 02:50:14
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150710205029.GA1181@peff.net>
X-Provags-ID: V03:K0:FZ8t8O+DFVMXHPiKEHbQRLSQ3uOWkiQNEyTgvSdvZ2WgkN7Pzb5
 Pjj5+jVm9hQH8I0ekEvO83oLEqM7ESsz5S2Mm8bub6algadLWswMUYrCbTQzBC4e4CweiQb
 PE6i9hghP+zYmSNmZ4xQAAnDdhm/lYqW2lrn4sFRXkPZpebLDiQQeaVe666Y3QR5qrNUCEJ
 kMQtR1LoS747gPO6UGkoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:362G3IxBHx8=:Y+bQ5LtZenWCBfm/ZikRLi
 t+AlFvAel0Wp45VM+qdc3/B+LTSMUq5FakZ64rXfX17kMfKeTFkbmdPSoH7uY9HWUY8kQq4OW
 E4eVR1IcYBsC5bex30uWe3lc3Dnyi2hZmn8nhUvta36pMhOfGRY3ltbg0biYt7CyeQCckh0/H
 4eDLV0M9+SkcEFjeNmBFenVWTxpHIXV/xOEStnV8JCxH/XglcnwNYBD9uMJLiaokPxx6TcFqR
 mRRfpJTv4J5LZ1TyUZs0n4mc8wFV+m/2xDLt68Kq0xzg2R07CFIAfTclbbyr4WhIBeGm6nBjR
 K+iydkTkP/4tuIflmW/G8r9AiGUynHivTtbIDdC5mi83QQr3TbDHA3XdE+kDi2oZHqdzzYBCb
 f1/6ljocXGg+Ji4Y0T3tzjinuK6VpvhJ42gtDyxqBT7YExgK2f/afpukUZ4ZjXgYLU3IF8bY7
 OryqYmvL7obFDeynQmTFWvM5DZhTH0O0cI0uTNyP3HWWMlJoL3x1d7T2tA2kEYqN+itadAQfK
 AAFm/RpIXXvY3XKUE6B0uMI9Ub9B+ApiBWKqAaecmfmMQXh9d9ezr0drm/q5bpjGqUpNZiPM4
 rz89tUBF00iWYwVTsluEDRicMLdwOWAhpyiRlsuxmhYyHhqwuPAWDazUH91YfaEzGKhU9oXff
 6N45m++oyBOAjWwN8xRIlCgVPWk/70tyAqD82EivAG90Pcwkq7HUU1ydVIzQEq/QeqY0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273859>

Am 10.07.2015 um 22:50 schrieb Jeff King:
> Thanks, this definitely is a problem, but we already have a fix in th=
e
> sb/p5310-and-chain topic. I thought that had been merged-up, but it
> looks like it is only in "next" right now.

All the better.  And I see it's in master now.

Ren=C3=A9
