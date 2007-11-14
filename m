From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v3] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 21:23:49 +0100
Message-ID: <8515B0B6-9C28-41F1-B197-3EF821D43590@wincent.com>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com> <Pine.LNX.4.64.0711141717570.4362@racer.site> <622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com> <7v4pfoh9vu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOmi-0000Q4-Et
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbXKNUYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbXKNUYM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:24:12 -0500
Received: from wincent.com ([72.3.236.74]:38181 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbXKNUYL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 15:24:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAEKNo5G000315;
	Wed, 14 Nov 2007 14:23:51 -0600
In-Reply-To: <7v4pfoh9vu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65008>

El 14/11/2007, a las 21:04, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> El 14/11/2007, a las 18:19, Johannes Schindelin escribi=F3:
>>
>>> Besides, is it really necessary to be as explicit as you word it?
>>> IOW is
>>> this patch needed?
>>
>> I was basically just trying to help new people from making the same
>> mistake that I did; ie. not knowing if there was an official limit,
>> looking at the maximum line length in a file, making sure my patch
>> didn't exceed that length (and re-wrapping to avoid exceeding it), =20
>> and
>> then getting reprimanded for gratuitous re-wrapping.
>
> Sorry about that "reprimanded" part.  I should have been more
> careful -- I did not really mean it that way.  It was more like
> "it would have been nicer ... so please try to next time".

Don't worry about it, Junio. I've been subscribed to the list for =20
several months now, so I'm already aware of the perfectionism inherent =
=20
in the process; I didn't take anything personally, and much less =20
coming from you who is always diplomatic. I just thought, "this is =20
good advice that Junio has posted to the list, I found it helpful, so =20
I think it should go in the style doc".

And I'm no stranger to Johannes' scything sarcasm either, it's his =20
personal style; luckily, along with the sarcasm he makes so many high-=20
quality contributions to the community as well.

> I agree that "80 columns" sits better in that new "Line
> wrapping" section.  I wonder if "tabs are 8 spaces wide" also
> belong there.

You're probably right; I understand that the 8-wide tabs convention =20
holds in shell and perl scripts too, not just in C source.

Cheers,
Wincent
