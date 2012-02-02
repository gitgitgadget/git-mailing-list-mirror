From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 02 Feb 2012 11:20:29 -0800
Message-ID: <7vfwetvy82.fsf@alter.siamese.dyndns.org>
References: <201202021104.50534.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frederik Schwarzer <schwarzerf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:20:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2D3-0000jz-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349Ab2BBTUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:20:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162Ab2BBTUb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:20:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40F33678B;
	Thu,  2 Feb 2012 14:20:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CSnIYMWAy8NVdbdzcgVzmXWNonU=; b=YgoatC
	4oLRJWb0Fasdrp8jWKSJBgh9EoAlmtjSSLAF2NnMC5r3Fe/8cO1OMJVOlHI51K9B
	LY9AUl33YcPGqan67b6JXDAx2GSZquFiG2OmXGHZlNXSXQy5Qp0gFYWX6pGbrsc2
	6AtuPu4fu3LT/u6Fxi78NInd8+70T+b36TMp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHgt2bgaD50gtF4WaL5hiEgT/ONmqCsq
	V4Bw3bP9P+urQ6/BKananTFGsgEVdvZ96emWQWLZONL4FRqNhhrtyyeLtFC+i5V3
	xSWLZITYnSmgIuhd8MiHaWMcTnTo5Mxe7FsdjGFgcYJkWzO7X0l0Cc8fDWn6Bq6X
	9BncP3b6DQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39410678A;
	Thu,  2 Feb 2012 14:20:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2DF06789; Thu,  2 Feb 2012
 14:20:30 -0500 (EST)
In-Reply-To: <201202021104.50534.schwarzerf@gmail.com> (Frederik Schwarzer's
 message of "Thu, 2 Feb 2012 11:04:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8A87F40-4DD2-11E1-A4E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189677>

Frederik Schwarzer <schwarzerf@gmail.com> writes:

> Translations of the former group are in many cases suboptimal. But the 
> latter group will not follow this mailing list.

Well, I would have to caution that translations by people who are not
familiar with Git would also be in many cases suboptimal, too.  Have you
seen translations of technical books by nontechnical people?

> ... In practice I guess interested Translators (who are not 
> interested in every code detail) will unsubscribe after a few days and 
> then miss all the fun.

Ever heard of mail filtering by say Subject: or even From: ? ;)

> A git-i18n mailing list could coordinate that. It would not be a list 
> for l10n teams to do their internal coordination, but for the i18n 
> coordinator to notify l10n teams about updated POT files (he might 
> even merge PO files) and for l10n teams to ask about strings they are 
> unsure about. These questions would then be digested by the i18n 
> coordinator and brought to the attention of the developers if needed.
>
> How does that sound?

That is entirely up to the l10n coordinator. Are you volunteering?
