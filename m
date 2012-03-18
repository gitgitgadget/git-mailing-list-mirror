From: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [L10N] New po/git.pot generated for Git 1.7.10-rc1
Date: Sun, 18 Mar 2012 07:04:01 +0100
Message-ID: <4F657AD1.3020600@in.waw.pl>
References: <CANYiYbGZ7mQaqyAxOiHOdMfDSy0VsDgLaWiBTTaZ30asiSU0nQ@mail.gmail.com> <4F64C837.10700@in.waw.pl> <CANYiYbGtnHbOGYhVc_gCa71PiTM=q8YMz6OH0-kQrw6R-ah_yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 07:04:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S99EV-0005Qo-1l
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 07:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab2CRGEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 02:04:11 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55877 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab2CRGEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 02:04:10 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.2.82])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S99Dq-0002El-RT; Sun, 18 Mar 2012 07:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <CANYiYbGtnHbOGYhVc_gCa71PiTM=q8YMz6OH0-kQrw6R-ah_yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193372>

On 03/18/2012 03:20 AM, Jiang Xin wrote:
> 2012/3/18 Zbigniew J=EAdrzejewski-Szmek<zbyszek@in.waw.pl>:
>>>       https://github.com/git-l10n/git-po/
>>
>> Hi,
>> the slash at the end makes this an invalid url to pull from:
>>
>> % git remote add l10n https://github.com/git-l10n/git-po/
>> % git fetch l10n
>> error: RPC failed; result=3D22, HTTP code =3D 502
>> fatal: The remote end hung up unexpectedly
>>
>> (Works fine with "https://github.com/git-l10n/git-po").
>
> Next time I should write the url of the repo, not url of the project.
>
>     git://github.com/git-l10n/git-po.git
>     https://github.com/git-l10n/git-po.git
Nope. https://github.com/git-l10n/git-po is better because it works in=20
the browser too. https://github.com/git-l10n/git-po.git gives 404.

-
Zbyszek
