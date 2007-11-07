From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Wed, 7 Nov 2007 09:03:08 +0100
Message-ID: <D739E20F-BCEF-418C-AE6F-A74C4ACEA4FA@wincent.com>
References: <472F99F8.4010904@gmail.com>	<7v8x5cmern.fsf@gitster.siamese.dyndns.org>	<4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:04:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpftQ-0005uJ-Kd
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbXKGIDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 03:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756224AbXKGIDy
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:03:54 -0500
Received: from wincent.com ([72.3.236.74]:49438 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904AbXKGIDy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 03:03:54 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA7839tO028545;
	Wed, 7 Nov 2007 02:03:10 -0600
In-Reply-To: <47310ACF.4030103@gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63782>

El 7/11/2007, a las 1:46, Francesco Pretto escribi=F3:

> Junio C Hamano ha scritto:
>>
>> Honestly speaking, I am not too thrilled about making the
>> cvs-migration document much longer than what it currently is.
>>
>
> Honestly speaking, you've spent too much time in looking for every =20
> possible
> objections against these simple additions. At least it should be =20
> less than the
> time I've spent in measuring every single word of this patch, hoping =
=20
> you could
> consider them for inclusion. You gave me lot of attentions (I am =20
> grateful of this,
> really) so I should probably be surprised of the cleanliness of git =20
> code, of the
> rigor of the code style, of the clarity of the documentation. But =20
> unfortunately,
> I am not. I simply tried to make this document more useful and =20
> helpful for a
> wider audience of people that could ever consider of using git in =20
> their life.
> And yes, I decided to so because I had trouble myself during initial =
=20
> configurations.
> What's the problem if a document called "git for CVS users" is more =20
> explicated?
> What's the problem if it contains as many as possible informations =20
> to set up
> git in a viable way and, hopefully, to learn something on how it =20
> does work?
>
> I'm sad. Not only because you refused a documentation patch, but =20
> because i could
> have sent a "Bug: Documentation Sucks!" to the ml and i would have =20
> obtained the
> same thing: nothing.

On the contrary, I think you received some excellent, high-quality =20
feedback. The process that you've been participating in over the last =20
few days is exactly why the Git codebase is as good as it is; only the =
=20
very best patches get accepted, and those which aren't "the very best" =
=20
receive detailed feedback that help the submitter to turn weak patches =
=20
into strong ones. The process works very well and the proof is in the =20
pudding (the quality of the product).

Cheers,
Wincent
