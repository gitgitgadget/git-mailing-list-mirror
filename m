From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Tue, 24 Feb 2015 14:33:41 -0800
Message-ID: <xmqqoaojos6y.fsf@gitster.dls.corp.google.com>
References: <20150224220923.GA23344@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQO37-0000qG-RX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbBXWdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:33:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752919AbbBXWdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 17:33:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 150483BE1A;
	Tue, 24 Feb 2015 17:33:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NCq/ovYs9w0eHfhr/sidNj6gxSc=; b=L5QV+g
	Q92IXy+IY81yf4+PTy2nhSYA2Z0q0gaqC7E7bkiBHJzFtQ81N06havt4MyI7kjZC
	9u2VgDMebnU/hpHJsGroyaBPH0o08RvewjvFaO3g+susKs9ogpkD0DySGZeKNLpN
	J5Hxv8SGEfpLqAImYTvlP8jrVS+jqKEDynxOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+vNK+NSqf9lnAfY/FLZ6q8S4j0OLsI9
	3pwKYYgAV6SuRPgSTUGIMPGrxE7r9rAqbP7oo7loeFA1qRbbilIXzKzCSYd4Zcn1
	cQ3HTcGF0p1DZK30aHCiLRB692oIvAuIj4d10wDptd5fg3DzsS7vUbDyaAnEyYaf
	AI/DXAlJhgI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09F0E3BE19;
	Tue, 24 Feb 2015 17:33:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80E823BE15;
	Tue, 24 Feb 2015 17:33:42 -0500 (EST)
In-Reply-To: <20150224220923.GA23344@peff.net> (Jeff King's message of "Tue,
	24 Feb 2015 17:09:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FB2665E-BC75-11E4-8190-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264356>

Jeff King <peff@peff.net> writes:

> I wanted to make one more announcement about this, since a few more
> details have been posted at:
>
>   http://git-merge.com/
>
> since my last announcement. Specifically, I wanted to call attention to
> the contributor's summit on the 8th. Basically, there will be a space
> that can hold up to 50 people, it's open only to git (and JGit and
> libgit2) devs, and there isn't a planned agenda.
> ...
> If you have questions, please feel free to ask me, and I'll try to get
> answers from the GitHub folks who are organizing the event.

I'm likely to come to the Summit, but I wonder what the timetable
for the 8th look like.  Is the "Get Together" designed to overlap
the Summit time-wise?  Is the Together there so that those not
attending the Summit can kill time?  Do those attending the Summit
partcipate in the Together, too?
