From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2014
Date: Thu, 27 Feb 2014 11:19:11 -0800
Message-ID: <xmqqlhwwz7m7.fsf@gitster.dls.corp.google.com>
References: <20140225154158.GA9038@sigill.intra.peff.net>
	<530CCFB0.5050406@alum.mit.edu>
	<20140226102350.GB25711@sigill.intra.peff.net>
	<530DC4D1.4060301@alum.mit.edu>
	<xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
	<530EEAA2.3030306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6UL-0001HS-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbaB0TTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:19:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbaB0TTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:19:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 602966FF45;
	Thu, 27 Feb 2014 14:19:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tHAJaQF5JjGOwOxjH5uKsi8Juak=; b=o4hUkA
	0Eb3fjzUSw0LXjBst4cO5whmTffn2tCbrM1wlko9MLniC5KBQq6ORp58JzlvEx39
	3iS1VGGJPy4Q6kyVgRP4gzy1bcwoeJ3BpOePeLE0TQPJV0GLGqbNVj0Nafvf861p
	G55OHbCqy0SneWnReBden6ejGEMzuT2bpMbg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPE5gHriwJL1+VX90BvaygoKAS8FQJq6
	TakUl5kcxvVmp3JRTnm5QxBsdUz8UO2HpNBOSHnKX8ufKqQiYTH+oje0Hk4g9Hrp
	KUGGfCF3qo4ucUlNDGYrWACQtRdBmCoZUJg1Ca2C5+aFp7QJ6XWmLNvmlWEwK6OS
	wD5/0LKwcBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE436FF44;
	Thu, 27 Feb 2014 14:19:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 705E36FF41;
	Thu, 27 Feb 2014 14:19:15 -0500 (EST)
In-Reply-To: <530EEAA2.3030306@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 27 Feb 2014 08:34:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C0C1708-9FE4-11E3-8906-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242839>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Sounds good.  I suggest we make your blob a paragraph before the list of
> bullet points rather than part of the list.  Please suggest some "TBD*"
> then I'll add it to the text.  Would we also fill in "X" with the name
> of the actual student involved in the conversation that is pointed to?

I was not thinking about using a student thread (I do not remember
having a good on-list interaction with past GSoC students).

How about using this one from our recent past:

    http://thread.gmane.org/gmane.comp.version-control.git/239068

which has the following good points to be used as an example.  It:

 - involved multiple cycles and multiple reviewers;

 - showed good response to the comments from the original author;
   and most importantly

 - had everything related to the topic in one single neat thread.
