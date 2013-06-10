From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 00/28] Follow perlcritic's recommandations
Date: Mon, 10 Jun 2013 10:46:40 +0200
Message-ID: <vpq7gi2qrnz.fsf@anie.imag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cR1=32TwatmTdVBDnkpkhwtUNyKL_Z9f=V_FPtt_Y-xiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxkY-00071D-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3FJIqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:46:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47377 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab3FJIqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:46:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A8kdkD020472
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:46:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlxkO-0008Ur-Q5; Mon, 10 Jun 2013 10:46:40 +0200
In-Reply-To: <CAPig+cR1=32TwatmTdVBDnkpkhwtUNyKL_Z9f=V_FPtt_Y-xiA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 9 Jun 2013 21:09:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 10:46:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227264>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jun 9, 2013 at 6:22 PM, C=E9lestin Matte
> <celestin.matte@ensimag.fr> wrote:
>> Changes with v2:
>> - Remove patch [02/22] about using the Readonly module
>> - Split commit [07/22] into 5 different ones
>
> This was easier to review after being split. Thanks.
>
>> - Split commit [14/22] into 2 different ones
>> - Patch [17/22] was *not* split: tell me if it is necessary
>
> [now patch 22/28]
>
> You, Matthieu, and Junio should decide, but I again found it
> time-consuming and onerous to review with all the changes mashed
> together.

I agree that it would have been better to split the patches in v1, but
now that we've already spent time reviewing it, it seems unecessary to
spend more time splitting and re-reviewing.

I went through the series once more, all my remarks are minor. I'm OK
with the series as it is (i.e. perhaps it's time to say "stop the
bikeshedding and start coding real stuff" ;-) ). As a reminder: Celesti=
n
is in a school project that ends in a week. The goal is both to be
productive and to learn stuff.

In any case, thanks a lot for your review, Eric.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
