From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Sat, 04 Jan 2014 22:54:02 +0100
Message-ID: <87lhyv5s79.fsf@igel.home>
References: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
	<20140104211834.GC12251@google.com>
	<loom.20140104T223713-502@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 04 22:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzZAc-0006Dr-2a
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 22:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbaADVyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jan 2014 16:54:09 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:53229 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbaADVyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 16:54:07 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dxcFS6hg7z3hhrh;
	Sat,  4 Jan 2014 22:54:04 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dxcFS6b66zbbcN;
	Sat,  4 Jan 2014 22:54:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id KkcCrvG7aq7I; Sat,  4 Jan 2014 22:54:03 +0100 (CET)
X-Auth-Info: X2yMczyUJGXgVlCj3aPoO8etQ+FetpPOnWzSsplwNQc=
Received: from igel.home (ppp-46-244-228-243.dynamic.mnet-online.de [46.244.228.243])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  4 Jan 2014 22:54:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id EA32C2C1EF5; Sat,  4 Jan 2014 22:54:02 +0100 (CET)
X-Yow: ..  does your DRESSING ROOM have enough ASPARAGUS?
In-Reply-To: <loom.20140104T223713-502@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Sat, 4 Jan 2014 21:38:48 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239946>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Jonathan Nieder <jrnieder <at> gmail.com> writes:
>
>>=20
>> Hi,
>>=20
>> Thomas Ackermann wrote:
>>=20
>> > --- a/Documentation/user-manual.txt
>> > +++ b/Documentation/user-manual.txt
>> >  <at>  <at>  -1,5 +1,5  <at>  <at>=20
>> > -Git User Manual
>> > +&#65279;Git User Manual
>>=20
>> Why?
>>=20
>> Puzzled,
>> Jonathan
>>=20
>
> That's a Unicode Byte Order Mark.

No, its an ampersand, a hash, a number and a semicolon.  Definitely not
a BOM.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
