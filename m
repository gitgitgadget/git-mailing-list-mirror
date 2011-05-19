From: Junio C Hamano <gitster@pobox.com>
Subject: Re: plain text only policy prohibits the use of android based mobile
 devices
Date: Thu, 19 May 2011 10:12:32 -0700
Message-ID: <7vei3u8vi7.fsf@alter.siamese.dyndns.org>
References: <201105182217.p4IMHIk2001872@amd.spinics.net>
 <alpine.DEB.2.02.1105181612310.12174@asgard.lang.hm>
 <BANLkTimBxPKx1gWeeyk3YgAd4R-XtyQv3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, ellis@spinics.net, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN6mL-0000ol-6J
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615Ab1ESRMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:12:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540Ab1ESRMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:12:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D6625459;
	Thu, 19 May 2011 13:14:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vltOOkvVik3yrCGt1ng8UxxNq38=; b=vmdemB
	1lbWSbuxf8bzHDXQpMGvm9Lo+SQlPOEMMO8D7ELWIlhLjFNu9dBL6HHpyWg4l92y
	MT9Tz2m/CMyVJjYENR753Iy+9AKchBENaCuAXKqje1bvPWlpPcZfjQ6QZLXc1YPO
	GlczvAucx+yGPAUQDel4c9EI8jxNwISu7A2+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oi4O88mT4KPhQ8Lz8rf32/BCniPNwQS6
	txf42oCjg7BmyZDOCI4+bJ9H476EjyqdCjaP3faYZUJL0/y0IsCno10uCsuuVin/
	tgFQBnc2Gk7lGbLI9CJ7pzmSRFYSLl7HqMYsNkU47zwNIClsdCsfoyJN2sOW+Xp+
	nIaPANhtG3Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD16C5458;
	Thu, 19 May 2011 13:14:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7CD7B5453; Thu, 19 May 2011
 13:14:40 -0400 (EDT)
In-Reply-To: <BANLkTimBxPKx1gWeeyk3YgAd4R-XtyQv3Q@mail.gmail.com> (Eugene
 Sajine's message of "Thu, 19 May 2011 10:33:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E6E55D2-823B-11E0-BD10-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173970>

Eugene Sajine <euguess@gmail.com> writes:

> As of now i see the majority doesn't care, so it is up to me to decide
> how I'm going to work with this.

I only comment on this part. The way I read this thread is not that the
majority doesn't care.

The majority deeply cares about keeping the list free of HTML cruft, much
more than they care about making it easier for people who sometimes (or
always) cannot send anything but HTML-mixed messages [*1*]. 

[Footnote]

*1* This includes me, who often has only an Android tablet while on a bus,
wanting to give advice to a poster on the list. I usually just send the
reply only to the original poster without bothering the rest of the list,
or wait until I get to somewhere I have access to a better MUA.
