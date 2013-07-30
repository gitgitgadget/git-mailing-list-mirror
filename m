From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix typos in man pages
Date: Tue, 30 Jul 2013 08:05:45 -0700
Message-ID: <7vehagxf3q.fsf@alter.siamese.dyndns.org>
References: <1375132543-20361-1-git-send-email-oystwa@gmail.com>
	<51F7D2FA.7020208@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4BUo-0003bW-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab3G3PFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:05:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab3G3PFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:05:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 825E234B4B;
	Tue, 30 Jul 2013 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60ZG0nB6Qi5tbelUE/AoeWJRedo=; b=JXseCS
	mYcr8gPO/aCQKx5I04aV7r4V4ocT3oYgGjv4SVRNxEmH3NtBbzpnJjA/SqXznDnf
	NWpZyw56iGrNzUNGlyzfYHDm0pW3cEAidcjVvp25crEuXVkET77P6Ku00Vnd9KB4
	iDkyyqJje/eFlNBYivqrosAxpshauDIk37YJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pB1JesEP8NMnd4GKH/BwGrOak4CRtoR+
	nDGaB1nT7ilUZ+NP+4u0lnLRVI5MdjUQ6ifAr1sPWL2tC03sE8hKoNDTkLNNLMv/
	rRuhe5ilzM+hlwSTh6Lti6B/Aj+xn1tilR8hCPWPEmvWKi0s10KkdHxNNK+xcOHW
	1KGQL6RJQfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 730A434B4A;
	Tue, 30 Jul 2013 15:05:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD68734B47;
	Tue, 30 Jul 2013 15:05:47 +0000 (UTC)
In-Reply-To: <51F7D2FA.7020208@xiplink.com> (Marc Branchaud's message of "Tue,
	30 Jul 2013 10:51:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83F24060-F929-11E2-BCF2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231365>

Marc Branchaud <marcnarc@xiplink.com> writes:

> I personally don't have a lot of time to investigate the nuances of English.
> However, I desperately hope this list can avoid any linguistic flame wars.
> In that spirit, I suggest that anyone posting an orthographic patch (i.e. for
> something that isn't an obvious spelling mistake) could helpfully include a
> link or two to an explanation of the reasoning for the change.  Especially
> for folks who aren't native English speakers, this could help avoid a lot of
> back-and-forth.
>
> One general source I've found is the English StackExchange:
> 	http://english.stackexchange.com/

I'd rather not to see any change that turns one accepted form into
another accepted form at all (like "parseable" vs "parsable" in this
patch).  For that purpose, asking "What is parseable" to Google and
seeing if there is a hit is good enough ;-)

I'd of course welcome genuine typofixes, like s/filesytem/filesystem/.

Thanks.
