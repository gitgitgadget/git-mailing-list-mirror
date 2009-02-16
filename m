From: Wincent Colaiuta <win@wincent.com>
Subject: Re: send-email sending shallow threads by default
Date: Mon, 16 Feb 2009 10:56:16 +0100
Message-ID: <2612F8BC-FF9F-4708-A4A1-A64F680D6B1F@wincent.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <5ABF2654-851C-47F3-9D3A-3F73F13AC5DC@ai.rug.nl> <20090216024308.GB18780@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 10:58:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0El-0000xw-05
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZBPJ4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 04:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZBPJ4f
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:56:35 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:53340 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbZBPJ4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 04:56:34 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1G9uGxK020249
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 16 Feb 2009 04:56:19 -0500
In-Reply-To: <20090216024308.GB18780@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110155>

El 16/2/2009, a las 3:43, Jeff King escribi=F3:

> On Mon, Feb 16, 2009 at 12:09:11AM +0000, Pieter de Bie wrote:
>
>> On 16 feb 2009, at 00:07, Jeff King wrote:
>>
>>> Are there common readers that thread but do not order by date?
>>
>> Apple's Mail orders by date received, rather than date sent
>
> Hmph. I guess it is a potential problem, then. If you use Apple Mail,
> can you report on whether out of order threads have been a problem
> (since earlier discussion revealed that both deep and shallow threads
> are found in the wild)?

Yes, I use Apple Mail and I often see out-of-order threads.

But frankly, this is a total non-problem with absolutely zero impact =20
(given that most people use numbered subject lines and it is easy to =20
see the order in which the patches should be read).

Cheers,
Wincent
