From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mini-GitTogether Oct 2014? (was: Next Git conference or meeting)
Date: Wed, 03 Sep 2014 14:47:45 -0700
Message-ID: <xmqqfvg8wf3y.fsf@gitster.dls.corp.google.com>
References: <20140903210907.GB28644@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIPQ-00037x-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbaICVru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 17:47:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64981 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840AbaICVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:47:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9477A38CC8;
	Wed,  3 Sep 2014 17:47:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vtSEfiBg8fG9OEgfLaXEpgCwSfE=; b=mZ72XP
	Zzu2F+2vu32bp8oyIOu8oyARIOktlQBTH272YvXU7h0uLa2vdl3LkDY0QeZppQBC
	Z+MQYDHiii5nxHhG2I3V5fsVwV9SVjjST+PB83lDGtmH1aDvH8t8+tk/hyPmoAd4
	FiNN0w9fSmEPK4MptnaSMG4CamrRcNpbK7N+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7/qfgDlklgNj/Wy0DQZPwAZOdmAAqwf
	LV4UX4RypBaWVe8wcM303kIZkvMn97PUKWxOtxUpgEbzuCzI64nP25vZFT78t7gr
	A7KxQ41Cffrbjpf8YVCw6rZ72ptjTwfxbqp9dKAz6d3Kol8kiZJ50SmRMp0fELEy
	fHOVa/HTYiM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8911038CC7;
	Wed,  3 Sep 2014 17:47:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B78C238CC2;
	Wed,  3 Sep 2014 17:47:46 -0400 (EDT)
In-Reply-To: <20140903210907.GB28644@peff.net> (Jeff King's message of "Wed, 3
	Sep 2014 17:09:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F14A9F84-33B3-11E4-ADEE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256421>

Jeff King <peff@peff.net> writes:

> I know you are talking about something potentially much larger than
> this, but I wanted to note that Michael Haggerty, Ramkumar Ramachandra,
> and I will all be in the Bay Area for the GSoC Reunion, October 23-26.
>
> I do not think we want to have a "real" conference, but I wonder if git
> devs would have an interest in getting together for dinner or some
> social time either right before or right after.
>
> I'm thinking it would probably be small-ish (<20 people), and primarily
> just for people who work on git to talk to each other in person.

I guess I'd be close enough to come.
