From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Fri, 06 Jul 2007 08:54:31 +0900
Message-ID: <200707060001.l6601tjS024564@mi1.bluebottle.com>
References: <7vodiqdcgl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 02:02:06 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6bGw-0008Nv-B4
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 02:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760823AbXGFAB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Jul 2007 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760722AbXGFAB4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 20:01:56 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:58438 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760687AbXGFAB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 20:01:56 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6601tjS024564
	for <git@vger.kernel.org>; Thu, 5 Jul 2007 17:01:55 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=G57GhsnVAFwVhnsx3HYIdyOfn69rI5oXETkoVDueXonXPGwFK2B60a3YvWdQhJ3KW
	OZVtKMf/wLum3/hMKYqXfECPSxdADe4m8b7DSBHwZzEaFv+cpVDvVZFJZgjHAMd
Received: from nanako3.mail.bluebottle.com ([60.190.79.18])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6601li8001710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2007 17:01:52 -0700
In-Reply-To: <7vodiqdcgl.fsf@assigned-by-dhcp.cox.net>
X-Trusted-Delivery: <bac2c2d8aa5b31243ce97e333534d4db>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51705>

Quoting Junio C Hamano <gitster@pobox.com>:

> Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>
>> I didn't test it yet, but it sounds good.  I will apply your patch a=
nd
>> work a while with it.  But I think if someone adds documentation, I =
will
>> give my Ack. :-)
>>
>> BTW: I prefer help over usage, but if it nanako prefers usage, why n=
ot
>> both?
>
> We could do that, I guess.  Nana?

Thank you very much for asking.

I think it is good to accept both usage and help, then.  I will try you=
r
patch myself and will report if I can think of further improvements.

Please do not expect much documentation from me, however.  My writing i=
s
not very good.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ind out how you can get spam free email.
http://www.bluebottle.com/tag/3
