From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9700-perl-git.sh: Fix a test failure on Cygwin
Date: Thu, 31 Dec 2009 16:07:53 -0800
Message-ID: <7v637mr8km.fsf@alter.siamese.dyndns.org>
References: <4B059150.5050303@ramsay1.demon.co.uk>
 <20091230224023.6117@nanako3.lavabit.com>
 <7vbphfzlgt.fsf@alter.siamese.dyndns.org>
 <20100101090515.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 01:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQV3r-0006Yh-1d
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab0AAAIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529Ab0AAAIG
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:08:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0AAAID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 19:08:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B89608C9B8;
	Thu, 31 Dec 2009 19:07:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fvVAdpoz6VHy0PlEzRAufZCU+o=; b=Zxk1/R
	yKRskBAx7qRYXpoPRn+7rQPWMPDWkRbddmYjOUwJXNspnrk5Wx8cF8jRUSBaj8/v
	BveDyMRKudR/9HIaZeUwY6auV7MzFx8Zy6LoXWXBeRi3sp1uGu/mtpm/p7/scZbf
	5ROPbZrmyQcJ7NYOhBziLpY7bR8kvOL6FNgy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYXhE/OmtT8OROMVNkQxutV53WFkQ6qT
	fwelMjNIuMuJVdnpdyi2+BaT9NJD2FHJbNgKXbZi6vIDfwo0o0VLIt6bHIWy5/hP
	k7KJttq1oBAdecWJJ7+7rec9XICG0MkjIH5x3ErQ4QcqjfQesgaKSr9oVlNq3LK4
	/Mn0hp63ylk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7ED8C9B5;
	Thu, 31 Dec 2009 19:07:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E53F78C9B2; Thu, 31 Dec
 2009 19:07:54 -0500 (EST)
In-Reply-To: <20100101090515.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 01 Jan 2010 09\:05\:15 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B74F1080-F669-11DE-85CA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135989>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> Junio, could you tell us what happened to this thread?
>>
>> Hmph, I think we have it as 81f4026 (t9700-perl-git.sh: Fix a test failure
>> on Cygwin, 2009-11-19).
>
> Oh, my mistake. I'm very sorry for wasting your time.

That's Ok; your other reminders were all good ones and greatly
appreciated.

But let me slow down.  I'll reply to the other messages next year ;-).
