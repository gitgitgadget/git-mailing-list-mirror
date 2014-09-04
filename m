From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2014 retrospective (Git Config API Improvements)
Date: Thu, 04 Sep 2014 14:37:38 -0700
Message-ID: <xmqqlhpzqd7h.fsf@gitster.dls.corp.google.com>
References: <CAEc54XC4PWNrDasF4Pf7Sy1bGHpOB_CWaJwiHkqF9MJ1PX9WdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPeiv-0003HL-RT
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840AbaIDVhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:37:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60065 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755677AbaIDVhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:37:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF67538005;
	Thu,  4 Sep 2014 17:37:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wGa8LmAUuq4j6avX375aHPul/9Y=; b=IPT1aS
	qT+KjZ1fzRqPbqxOUuVMB4QLC3kRPeBCcOWURp2o2cKkxrKvMCwYRBywodrwraDH
	OA501Hml1jjoN54frRZFM5RfgCSZVialofyZ1qnxOk7moh+gt5YNr8KXi6bi9VRE
	JZbWW1JASWQlt4+VB0/O7I3Sy1D1KRJ127g4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DAVBe5n7R4GCGyEr3k7BCXgOBLEyIKdT
	6BYvHBxRhDH0OVhKr/6dpzUnkAuH3qe+C1b5A5KjM+Ap/H+N/tayb1bgcOJ/Rex5
	7WutjDrnJR+7O0Ojn44GcngqeLH8iyYfaMVemdH1ualDtuo9lvlm694lPZuS2fef
	HqU2o8gfFMw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B41AF38001;
	Thu,  4 Sep 2014 17:37:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C5D539000;
	Thu,  4 Sep 2014 17:37:40 -0400 (EDT)
In-Reply-To: <CAEc54XC4PWNrDasF4Pf7Sy1bGHpOB_CWaJwiHkqF9MJ1PX9WdA@mail.gmail.com>
	(Tanay Abhra's message of "Fri, 5 Sep 2014 00:38:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B21E9144-347B-11E4-8036-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256486>

Tanay Abhra <tanayabh@gmail.com> writes:

> GSoC Experience
> ---------------
> ...
> Conclusion
> ----------
>
> So a great summer comes to an end. Hopefully I would still be part of
> Git's community
> and will continue working on it to improve it. I like to thank my
> mentors for being patient
> with me and helping me whenever I got confused.
> Hope you all have a great day. :)

Happy to see a great write-up.  Looking forward to seeing your
further involvement in the community.

Thanks.
