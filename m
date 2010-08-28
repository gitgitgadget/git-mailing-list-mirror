From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Add global and system-wide gitattributes
Date: Sat, 28 Aug 2010 19:33:22 +0200
Message-ID: <vpqbp8mskv1.fsf@bauges.imag.fr>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
	<1281977813-6528-1-git-send-email-gsvick@gmail.com>
	<87d3t7ow39.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Henrik Grubbstrm <grubba@grubba.org>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 19:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPJS-0001By-EE
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab0H1RfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 13:35:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57711 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab0H1RfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 13:35:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7SHU1ag008573
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 28 Aug 2010 19:30:01 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OpPHO-0007nK-VI; Sat, 28 Aug 2010 19:33:22 +0200
In-Reply-To: <87d3t7ow39.fsf@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Wed\, 25 Aug 2010 11\:55\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 28 Aug 2010 19:30:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7SHU1ag008573
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283621401.8471@yHrTMIXGDX10cPiZfjt2ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154649>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

> Petr Onderka <gsvick@gmail.com> writes:
>
>> Allow gitattributes to be set globally and system wide. This way, se=
ttings
>> for particular file types can be set in one place and apply for all =
user's
>> repositories.
>
> [...]
>
> I really can't wait till this gets into Git and I'm certainly not the
> only one (thank you so much for working on it, Petr!).

Same here ;-).

> Any reason the patch still hasn't been applied?

Usually, patches are applied if either

1) Junio has personal interest in it, or

2) Other people review the code and show interest for it.

I guess none of the conditions were met here (and Junio was very busy
these days). I'm sure you can help about point 2) ;-)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
