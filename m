From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bashing freelancers
Date: Fri, 06 Mar 2015 14:06:57 -0800
Message-ID: <xmqq8uf9ye4e.fsf@gitster.dls.corp.google.com>
References: <20150224220923.GA23344@peff.net>
	<CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
	<xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
	<54F986D6.5000607@drmicha.warpmail.net>
	<CAP8UFD2qGBPiNaDmx1OELM45TZqSqKkHZkdVOqupWKKxPxbvOw@mail.gmail.com>
	<CAPc5daVo5tDpx2ybt7eMXgrMfGCh+pu5HDc=EpM9XqGLyyih7Q@mail.gmail.com>
	<8761aeowff.fsf_-_@fencepost.gnu.org>
	<xmqq1tl210g1.fsf@gitster.dls.corp.google.com>
	<871tl1q25i.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU0Os-0006DZ-C9
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 23:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbbCFWHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 17:07:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754883AbbCFWHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 17:07:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 896C73E1BA;
	Fri,  6 Mar 2015 17:07:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vibWeTDRMzg/wmhgjG2lzalSobA=; b=mvVCJA
	Hmq98zLUcQ6wGYWrsJRcy+5bPsBsPvPrlSaXCplNDaOjXIeBlNT8yEqMFZPN42+s
	VeLv8dks3yzkUB3j09z9reCDP70sq2t6UYVYbWyzG5jysssT8lgBkTBghDdDRwU1
	Kh68sgQ2C0ia8ouh+l7ZJAvUfx8XG4/fzJyvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S6pxtFn2RaqoxoCdbux1J+stZv4L/o44
	PrGT74MVWvYwgV+5GnH43OkshCk2Hbh8IeKkRjL5CNxwfAhZ/5+v0TJDrHiIeYUb
	0NhUqewSR152E5ui+8qzR+D4CArZz/FFcTEhmWWKDzT3wSzLzKoAUEDNFw1FgD03
	FxcLrCaYgNg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D1503E1B8;
	Fri,  6 Mar 2015 17:07:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D28663E1B6;
	Fri,  6 Mar 2015 17:06:59 -0500 (EST)
In-Reply-To: <871tl1q25i.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 06 Mar 2015 21:52:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C9107C6-C44D-11E4-ADCE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264968>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Good work is worth good money. Suggesting that people who are not able
>>> to work for free are morally inferior is not conducive for a cooperative
>>> work atmosphere.
>>
>> Yes, but I do not think anybody did any such thing.
>
> "Of course, I am hoping that all the mentors are doing GSoC not for
> money but out of love of our software and our community,"
>
> Huh.

I did not intend any moral judgement in that statement, but after
re-reading it, I would say that "not for money" would have been
better phrased as "not only for money".

Let me clarify.

There _could_ be a mentor who hates Git the software and Git the
community, who wants to mentor students only for the mentorship
stipend.  I do not want to see such mentors.  I would imagine that
such a person surely can find something else that is more enjoyable
and do the mentoring there for money, if competent enough to mentor
others.  And that would be good for everybody.
