From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: No way to have global diff settings? (global .gitattributes feature request)
Date: Mon, 26 Apr 2010 15:48:28 +0200
Message-ID: <vpqoch6fhoz.fsf@bauges.imag.fr>
References: <87zl0wd9ce.fsf@gmail.com> <87och6ib0r.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 15:49:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6OgG-0001j1-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 15:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab0DZNsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 09:48:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53873 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab0DZNsm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 09:48:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o3QDgw3v022594
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Apr 2010 15:42:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O6Ofk-0004Lp-GB; Mon, 26 Apr 2010 15:48:28 +0200
In-Reply-To: <87och6ib0r.fsf@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Mon\, 26 Apr 2010 15\:44\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Apr 2010 15:42:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3QDgw3v022594
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1272894179.44028@LVzNBZUGaUKi5TweZvmSTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145818>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

>> Hello,
>>
>> it seems there is no global .gitattribute equivalent to .gitignore o=
r
>> .gitconfig. Wouldn't it make much sense to have one? Failing that, t=
here
>> really should be a way to specify some global diff options at least.

I'd like this feature too. My use-case is to have antiword and odt2txt
as textconv filters for .doc and .odt files, which I always want to
do. But probably the feature won't get implemented until one of us
writes a patch ;-) (I may have time later, but not before a few
days/weeks).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
