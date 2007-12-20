From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Thu, 20 Dec 2007 02:38:24 +0100
Message-ID: <C152371B-7BFE-4EDB-93C3-78805E58A773@wincent.com>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071219141845.GA2146@hashpling.org> <20071219142715.GB14187@coredump.intra.peff.net> <20071219143712.GA3483@hashpling.org> <7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 02:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5AP0-0002GX-8g
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 02:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759065AbXLTBjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760044AbXLTBjX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 20:39:23 -0500
Received: from wincent.com ([72.3.236.74]:37524 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759865AbXLTBjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 20:39:22 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBK1cPcC006402;
	Wed, 19 Dec 2007 19:38:26 -0600
In-Reply-To: <7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68965>

El 20/12/2007, a las 1:21, Junio C Hamano escribi=F3:

> Charles Bailey <charles@hashpling.org> writes:
>
>> On Wed, Dec 19, 2007 at 09:27:15AM -0500, Jeff King wrote:
>> ...
>>> Somebody beat you to it. :) Can you confirm that the fix in
>>>
>>>  <1198007158-27576-1-git-send-email-win@wincent.com>
>>>
>>> works for you?
>>
>> Ooh, the excitement, I've never had the opportunity to "git am"
>> before.
>
> Well, if Wincent had sent the patch as plain text without MIME
> quoted-printable, you did not have to even have the excitement of
> running "git am", but a simple "git apply" would have sufficed.

Well, I sent it using "git send-email", so I guess it didn't have MIME =
=20
quoted-printable.

Cheers,
Wincent
