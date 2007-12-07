From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFC (take 3)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Fri, 7 Dec 2007 09:25:04 +0100
Message-ID: <27036A24-2636-4278-B0D5-4128201DF35F@wincent.com>
References: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org> <1196990840-1168-1-git-send-email-jnareb@gmail.com> <7v7ijr7yph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Blake Ramsdell <blaker@gmail.com>,
	Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0YYe-0008Qy-O4
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbXLGI1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 03:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXLGI1U
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:27:20 -0500
Received: from wincent.com ([72.3.236.74]:41344 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbXLGI1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 03:27:19 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB78P5hg007419;
	Fri, 7 Dec 2007 02:25:06 -0600
In-Reply-To: <7v7ijr7yph.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67398>

El 7/12/2007, a las 8:26, Junio C Hamano escribi=F3:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Is something like the patch below what you wanted to try?
>
> This looks sensible.  Will apply.


This works for those using autoconf. Junio, did you get a chance to =20
look at the patch I posted for people who don't use autoconf?

Cheers,
Wincent
