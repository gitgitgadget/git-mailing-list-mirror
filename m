From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 11:29:58 -0700
Message-ID: <xmqq1tw2zty1.fsf@gitster.dls.corp.google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
	<20140509015107.GA9787@sigill.intra.peff.net>
	<xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
	<536d142c3524_693d7fd30c9d@nysa.notmuch>
	<xmqq61lezv0f.fsf@gitster.dls.corp.google.com>
	<536d1c9cecc58_a3dedb2f03f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WipYn-00051C-G4
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbaEISaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:30:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59377 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbaEISaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:30:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BC55165A7;
	Fri,  9 May 2014 14:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UMKxPDwfa/RpOETyrS6xJvel4fc=; b=XCkOtO
	ByZV89DzaaWWulL0iRgNtMw+ZaNNkOKlhZ9E7C24+NoNXmGppSAiVk74S7MbSY/f
	pzs3eS9x9FiVvzmCXdZdGd3LzlL+lkAmduiCrOwFC9Y5cdMTyuQMW94p73e7L4eC
	cRkh9g9mHA7Dq9FXOmoFpxbt6aBTUEFtSc1yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U92M9quMEik0TdpAT4Pa8kUAZME98xY3
	1mJFCANmROpYczOKeZKzh5byT735DAv2Pb0810UUZz7LirUeJoRfeO4mh/rvrGPb
	kZ/6zIfymtLUY/LwT8NNnAb1ELIoJG3upQOCZ21DskOv0Ux9dNrxAyte+Swfw/2Q
	otBlgiosfYQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35B56165A2;
	Fri,  9 May 2014 14:30:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8124A1659F;
	Fri,  9 May 2014 14:30:00 -0400 (EDT)
In-Reply-To: <536d1c9cecc58_a3dedb2f03f@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 09 May 2014 13:21:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE19D310-D7A7-11E3-809C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248607>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > *You* said this[1]:
>> 
>> If you read the context you omitted from the quote, and realize that
>> it was a counter-suggestion to give a middle ground to a more
>> draconian "let's divide them into two", neither which I said I want
>> to see go forward immediately, you see that this message does not
>> deserve any response.
>
> So when you came with a guideline, that was only for git-remote-hg/bzr.

There is no guideline involved.  Go re-read the message upthread and
find this part:

    In any case, that suggestion to remove not related to the "stick",
    either, and certeinly not about "prove yourself" purge that does not
    even exist.

I have no more time nor desire to respond to you today.
