From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git help config: s/insn/instruction/
Date: Thu, 28 Mar 2013 08:55:14 -0700
Message-ID: <7v7gkrwmcd.fsf@alter.siamese.dyndns.org>
References: <1364424830-17108-1-git-send-email-matthias.krueger@famsik.de>
 <7vboa4jc9a.fsf@alter.siamese.dyndns.org> <5153FEFD.3020703@famsik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kumbayo84@arcor.de
To: Matthias =?utf-8?Q?Kr=C3=BCger?= <matthias.krueger@famsik.de>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFB7-0002Tc-66
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844Ab3C1PzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 11:55:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab3C1PzQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 11:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE7DAB9C;
	Thu, 28 Mar 2013 11:55:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IoI6E5yiyiM9
	vvZPtJcs7IjQSN0=; b=tmjQgzfQQAKBKwofhBVHAFVXE3BfhhVY6IEM3HsjD7CF
	e0NxxaAUPZE7tVJ6MRZtcPcWH2vlD5HbrV7Y5rOpu9rkYGK1aHOPxPdvZo7kBzh8
	w7FqyW+rAFJJJnkcXsh9AOUG2EWl+SpvCMz7rt5j5yGCBhw+gKHlv1pTf+65gog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G7u6Ns
	/xbr3g4QvxucM2MnmbRubfzxIbWmnQwGVM+L5v0bFybVPBx9o5e7uSEUMuVrwoCR
	e1rN3pd8zSCNWmcqEcAxrhrNgC6bsPCx7ULeBFzgrhMdaOqaSj/uGXp4jCV+VwNj
	DbX5nyW8Pz/M5oySke7y7w2eEiKDTThyBykuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62893AB9A;
	Thu, 28 Mar 2013 11:55:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD91BAB99; Thu, 28 Mar 2013
 11:55:15 -0400 (EDT)
In-Reply-To: <5153FEFD.3020703@famsik.de> ("Matthias =?utf-8?Q?Kr=C3=BCger?=
 =?utf-8?Q?=22's?= message of "Thu, 28 Mar 2013 09:27:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1E7ED8A-97BF-11E2-A9B7-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219416>

Matthias Kr=C3=BCger <matthias.krueger@famsik.de> writes:

> On 03/28/2013 06:59 AM, Junio C Hamano wrote:
>> Matthias Kr=C3=BCger <matthias.krueger@famsik.de> writes:
>>
>>> "insn" appears to be an in-code abbreviation and should not appear =
in manual/help pages.
>>> ---
>> Thanks; sign-off?
> Oops, sorry.
>
> Signed-off-by: Matthias Kr=C3=BCger <matthias.krueger@famsik.de>
>
> (Is this sufficient or do I have to re-send the patch with the
> sign-off line?)

I can squash it in, so there is no need to resend.  The more
important thing is I won't have to for your future patches.

Thanks.
