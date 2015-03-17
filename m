From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Mon, 16 Mar 2015 22:25:21 -0700
Message-ID: <xmqqh9tkp54u.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
	<xmqqvbi1sy4h.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.2.02.1503161637210.31344@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Tue Mar 17 06:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXk0R-0005fQ-6r
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbbCQFZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:25:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750777AbbCQFZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA11A3673A;
	Tue, 17 Mar 2015 01:25:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JxXUfpLGwBn5lM49EKkYg337sfE=; b=emlgOz
	0aXFTmrEQ5gY/abKkyVD5o38ZzoIZ7Oi9rPcniQhBywUeNQTA8PQRc8Vm8N5IrEM
	Rq7NjhH515MYa/fy9DDtYuuHHwXufQrjDZ/zQ1vEA8Wj7HgEOWCgRSyy+tIN+2dF
	zmU4jHxu3+8AKdhjs9PUnNqsL3BlKa0y9CCzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=px3DxnllWfT8w4Yc/UFMCAlqhBucWm42
	Xn/BTyQ3TB+TsmH+NqzIOQrtsa8awfrSNvrDTyrYHtsy0UAf+SyADYIyrno/2sj0
	VPdoVV40X31YMCNP0jiiz9Nu2zuntbFyDtUoPmQ8NYs4UZdwKG8j3Nl6dmIsl3Sm
	vPxto+OpxtA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0D0336739;
	Tue, 17 Mar 2015 01:25:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 447D636738;
	Tue, 17 Mar 2015 01:25:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1503161637210.31344@nftneq.ynat.uz> (David
	Lang's message of "Mon, 16 Mar 2015 16:39:12 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0233D2E8-CC66-11E4-85B5-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265607>

David Lang <david@lang.hm> writes:

> On Sun, 15 Mar 2015, Junio C Hamano wrote:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> I wrote something about a potential Git Rev News news letter:
>>
>> I read it.  Sounds promising.
>>
>> Just one suggestion on the name and half a comment.
>>
>> How would "Git Review" (or "Git Monthly Review", or replace your
>> favourite "how-often-per-period-ly" in its name) sound?  I meant it
>> to sound similar to academic journals that summarize and review
>> contemporary works in the field and keeps your original "pun" about
>> our culture around "patch reviews".
> ...
> I'll bet that LWN would publish, or at least link to, such articles on
> a regular basis, and if you end up doing an in-depth writeup on a
> particularly discussed topic, they would probably give it pretty good
> visibility.

I hope you are right, but my observation of our coverage by lwn.net
is somewhat pessimistic.  In our early days, our progress often used
to appear on the "Kernel Development" page, which I presume is the
most important page of the weekly for the kernel developers, but in
several months, the mention of us has moved two pages back to
"Development" and listed together with folks like OCaml Weekly,
PostgreSQL Weekly, etc.  I would not count that as "pretty good
visibility" particularly.

I am taking it as a positive change, though.  Once we got stable
enough not to be a roadblock for the kernel folks and proven
ourselves not to regress, our progress probably ceased to be
newsworthy to them ;-)
