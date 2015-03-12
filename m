From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 15:36:46 -0700
Message-ID: <xmqqd24d2681.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
	<20150311073129.GA5947@peff.net>
	<CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
	<20150311075429.GA10300@peff.net>
	<xmqqbnjz5in0.fsf@gitster.dls.corp.google.com>
	<20150312223131.GA24492@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBin-00005a-JD
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbbCLWgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:36:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751553AbbCLWgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B02323F69C;
	Thu, 12 Mar 2015 18:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjOAeBtBe4RSZeP88puH6Hf3DxI=; b=Qu/Pdp
	CD2m8yUrXuSwTY0W6EPb2wSiptf84wg8/GGb9SNYXmrVf3ifq+IeD/S6xdsJ5cG8
	BXK/yfGkCQdy0H8CriwA5kQ2myIqm9BuVYLxLjBTLK357nbeiV2c1ai6Xe9G4/jY
	FzlcCO1DwyHxR/H2q3RmkkW1qrc1YBTkL+wYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y2lc7/7p8nrzXmDRWQIMsNnsUWIWqWYZ
	46eWJcUSY8m7pmW1CHiYXx0Qq6avo+woXldkAAAO4+ilVDGHldcx0hFovxi2Wb1B
	Z/2siqiOXBP80/FMJlZCer3dBo//UVy0x4pZMaDuSPJLQ6VU/TGEGvX7LtTIh/Jh
	TVMAzrRUXYU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A835A3F69B;
	Thu, 12 Mar 2015 18:36:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 153293F69A;
	Thu, 12 Mar 2015 18:36:47 -0400 (EDT)
In-Reply-To: <20150312223131.GA24492@peff.net> (Jeff King's message of "Thu,
	12 Mar 2015 18:31:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 445D66C2-C908-11E4-82D2-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265378>

Jeff King <peff@peff.net> writes:

>   It is comprised of 41 non-merge commits...
>
> is fine.

Thanks; very much appreciated.

>> New contributors who made this release possible are as follows.
>> Welcome to the Git development community!
>> 
>>   Aleksander Boruch-Gruszecki, Aleksey Vasenev, Patrick Steinhardt,
>>   Ryuichi Kokubo, and Tom G. Christensen.
>
> I hadn't thought about it when I originally suggested this, but of
> course "new" is not strictly meaningful in a world with branches. If you
> contribute a bugfix on top of v2.0.0 that goes to "maint", do you get to
> be new in v2.0.1 _and_ in v2.2.0?

Yeah, tricky.  How about

    New contributors whose contributions weren't in $previous are as follows.
    Welcome to the Git development community!

Then after merging a topic to 'master' and then 'maint' and when
cutting v2.3.3, a new person will be listed as "not in v2.3.2" and
then again in the announcement for v2.4.0, as "not in v2.3.0".

Yes, it is cheating, but that would match the story the shortlog at
the end would tell.
