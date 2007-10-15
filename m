From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 11:31:55 +0200
Message-ID: <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <471302D2.6010405@trolltech.com> <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com> <200710150902.52653.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	David Kastrup <dak@gnu.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMJh-0002ai-Mp
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbXJOJcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 05:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756472AbXJOJcm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:32:42 -0400
Received: from wincent.com ([72.3.236.74]:49986 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbXJOJcm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 05:32:42 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9F9WRAT004886;
	Mon, 15 Oct 2007 04:32:27 -0500
In-Reply-To: <200710150902.52653.johan@herland.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60969>

El 15/10/2007, a las 9:02, Johan Herland escribi=F3:

> On Monday 15 October 2007, David Symonds wrote:
>> On 15/10/2007, Marius Storm-Olsen <marius@trolltech.com> wrote:
>>> David Kastrup said the following on 14.10.2007 19:48:
>>>>
>>>> "unknown" clearly is much better than "dunno" though even if my ow=
n
>>>> favorite would be "undecided".
>>>
>>> What then about a good'ol programming favorite, "void"? :-)
>>
>> "skip"? That would make semantic sense, right?
>
> ...or we could go all spaghetti western, and call it "ugly".
>
> (as in "git-bisect [the <good>, the <bad> and the <ugly>]")

<personal opinion>
   Yes, it's funny, but I don't think an SCM interface is a place for =20
jokes or puns. Git already has one big tongue-in-cheek attribute: =20
it's name, so let's leave it at that.
</personal opinion>

Cheers,
Wincent
