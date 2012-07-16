From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANN] SubGit 1.0.0 RC1
Date: Mon, 16 Jul 2012 12:13:22 -0700
Message-ID: <7vehob1pv1.fsf@alter.siamese.dyndns.org>
References: <5004560A.2030508@tmatesoft.com>
 <7vmx2z1qoz.fsf@alter.siamese.dyndns.org> <5004660E.5010005@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Semen Vadishev <semen.vadishev@tmatesoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqqjk-0002Zt-OR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab2GPTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:13:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab2GPTNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 623538959;
	Mon, 16 Jul 2012 15:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LALCItCmaKTNqh4cVEv8jg9uWmE=; b=eXggDP
	HikO3Sv8xxCLiUQynsG5DN7b86GeHxjC39Eewm76GogDX0YJefmLjH15B/uRDulR
	aPAw2zrtP6rwVLMyMV2QAYdNjYCQVLMAV4e6KshwgViiPDIfQ/w0GTODgLY+F/IA
	ePw10sRB7IkvqeQuJ0eXIuZL1JQbJu8y4igNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MnFTjR45Hj50p+FCtedtfKndtINgzg7m
	A0nc86VJEIMg0ETlh6se8AC19H3VINJAJ8FcOan6F7s09m8+a9lOVY47+OQkIzcV
	Z2aLCSKc+06Q/WDB4mVmE/KxCqSq3eo6UagtLmPbfgRHNxX4e95ulWyf+GDrKRn3
	Sh+1irXqv7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8948958;
	Mon, 16 Jul 2012 15:13:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D31B88957; Mon, 16 Jul 2012
 15:13:23 -0400 (EDT)
In-Reply-To: <5004660E.5010005@tmatesoft.com> (Semen Vadishev's message of
 "Mon, 16 Jul 2012 21:05:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5057EC8E-CF7A-11E1-BDC2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201550>

Semen Vadishev <semen.vadishev@tmatesoft.com> writes:

> Hello Junio,
>
>> Where's the source?
> SubGit is a closed-source project.

Ah, OK.  As long as you are using Git in compliance with its
licensing terms, it is perfectly fine to be commercial.

But in that case, could you please mark your messages with [Ad] or
[Advertisement] or somesuch, not with [Announce] or [ANN], so that
people can filter them more easily?

Thanks.
