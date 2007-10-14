From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 18:35:57 +0200
Message-ID: <522E90CF-FC15-472F-B0A8-91C310CAF9BF@wincent.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com> <854pgtonp5.fsf@lola.goethe.zz> <200710141709.51579.chriscool@tuxfamily.org> <4712400C.2080900@lsrfire.ath.cx> <85y7e5ll38.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6SQ-000371-74
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbXJNQgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755561AbXJNQgi
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:36:38 -0400
Received: from wincent.com ([72.3.236.74]:48537 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755022AbXJNQgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 12:36:38 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9EGaPOl019918;
	Sun, 14 Oct 2007 11:36:26 -0500
In-Reply-To: <85y7e5ll38.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60865>

El 14/10/2007, a las 18:25, David Kastrup escribi=F3:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Christian Couder schrieb:
>>>
>>> I choosed "dunno" because that was what Dscho suggested in this =20
>>> thread:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/53584/=20
>>> focus=3D53595
>>>
>>> It seems to me short and understandable at the same time.
>>>
>>> More meaningfull would be "untestable" or "cannottest" or
>>> "canttest" but it's much longer, while "good" and "bad" are short.
>>
>> Ugly?  Neutral?
>
> "Ugly" has a certain charm to it but would probably not translate
> well.  "Limbo" would be another such candidate, probably with better
> translatability.  But while some of those have some geeky appeal, I
> really think something reasonably plain like "undecided" would be
> better in the long run.

"undecided" sounds good to me. It should be clear to non-native =20
speakers of English (at least, clearer than "dunno").

<personal opinion>
   Another problem with "dunno" is that it might come across as a bit =20
unprofessional due to its informality. Yes, you'll find it in most =20
dictionaries, but always with a qualifier of "slang", "colloquial", =20
"casual", "pronunciation spelling" or similar.
</personal opinion>

Cheers,
Wincent
