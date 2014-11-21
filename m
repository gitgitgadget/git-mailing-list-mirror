From: Vitaly Lipatov <lav@etersoft.ru>
Subject: Re: Add an alias for --abort option
Date: Fri, 21 Nov 2014 20:47:43 +0300
Organization: Etersoft
Message-ID: <85660b3a1d32ba10f8ddcee83fa89d71@office.etersoft.ru>
References: <ae79db289351bca031a4a5adafb9615b@office.etersoft.ru>
 <546F5DE9.1050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 18:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrsTF-0004hj-JN
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 18:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbaKUR6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Nov 2014 12:58:09 -0500
Received: from mail.etersoft.ru ([91.232.225.46]:51828 "EHLO mail.etersoft.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbaKUR6I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 12:58:08 -0500
Received: from roundcube.eterhost.ru (priv.etersoft.ru [91.232.225.6])
	by mail.etersoft.ru (Postfix) with ESMTP id F33378035B;
	Fri, 21 Nov 2014 20:47:47 +0300 (MSK)
In-Reply-To: <546F5DE9.1050700@drmicha.warpmail.net>
X-Sender: lav@etersoft.ru
User-Agent: Roundcube Webmail/0.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2014-11-21 18:44:
> Vitaly Lipatov schrieb am 21.11.2014 um 13:41:
>> Hello,
>>
>> is it allowed add alias '--abandone' for --abort option in git=20
>> commands
>> (git am, git rebase, etc.)?
>> The word 'abort' have too negative meaning in the russian language.
>
> But that is the english localisation. We do have git in other=20
> languages
> - maybe not Russian yet, but it would be great and welcome to change=20
> that!
I sure the git in any language has the same options. It is not language=
=20
specific really.

> ('abort' is negative in german, too).
And my suggest is add more correct word. Definitely, we never can just=20
change option's name.

>> For example, for git am we have three option names for continue
>> operation:
>> --continue, -r, --resolved
>
> I think it's a bad precedence. We should rather fight option bloat.
By my mind, if we have compatibility names it helps our brain to=20
operate with command line in more intuitive manner.


--=20
Vitaly Lipatov,
Etersoft
