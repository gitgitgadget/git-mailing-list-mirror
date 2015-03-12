From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 22:05:43 -0700
Message-ID: <xmqq61a64xg8.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
	<20150311073129.GA5947@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 06:05:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVvJf-0008GT-3N
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 06:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbCLFFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 01:05:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbbCLFFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 01:05:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AEB140C57;
	Thu, 12 Mar 2015 01:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vszbbD5gPSRhHF0SpxIGiWtmWq4=; b=GH29Y3
	c5ARBHS8z3Yf7wbnL3WTIrggpHNjS49298sZrDTj40qm0Drw7dap9Pl2EtTteVo/
	CwDy9amr0nXX81XVUKTrGyqZWPAVAgE6FFgroYJ8mByHCndh+XdUCI2BtnJ39/KD
	8pmyr+GP7bv2t7BeBjyZVzsEuTczNyNY4O4Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mCfZcgnOgrIXBwyHW4S0V7PuUVhwZZl2
	lOI9tq1rUVvDXFUj0BLfa/KuqGRI9waQNOY1fd24O5xh/3hgqSFQMjDtYNlObtoS
	h0uTkeFOiHKgX3DorwxTlR17t5ehl259emRY3URzfTzHN6hnLtXYulPf/AKNmSI3
	pfVeOa+tvjg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15F9F40C55;
	Thu, 12 Mar 2015 01:05:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AC4340C54;
	Thu, 12 Mar 2015 01:05:44 -0400 (EDT)
In-Reply-To: <20150311073129.GA5947@peff.net> (Jeff King's message of "Wed, 11
	Mar 2015 03:31:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7020420E-C875-11E4-8D20-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265353>

Jeff King <peff@peff.net> writes:

> I spent many years as a "type C" contributor, and I remember how nice it
> was to see my name mentioned occasionally as a useful person.

I guess that everybody is different ;-)

After throwing a small patch at ROCKbox (git.rockbox.org) back when
they were still hosted on Subversion, I felt somewhat ashamed to see
my name appear in their CREDITS file because the change I made was
so insignificant. In such a flat list like that, you cannot tell who
made significant contributions over time and who are just a casual
drive-by contributor like me, unless you know the community and who
are important in the community.
