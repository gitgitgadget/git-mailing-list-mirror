From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-l10n updates on maint branch
Date: Fri, 01 Jun 2012 13:08:41 -0700
Message-ID: <7vlik623sm.fsf@alter.siamese.dyndns.org>
References: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaY9Q-00071r-6A
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266Ab2FAUIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 16:08:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2FAUIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 16:08:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E0D946E;
	Fri,  1 Jun 2012 16:08:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KB+MWgD8ZVSFf344mJ9hQYD1Epw=; b=f1tVgp
	0lfwYvDyU1AvBvN6DtZVoob5rFUOh9RVFGzvo5kzgclc9ec6p67LyB27Of6fju2p
	wAFfSgu2z4Vu88nJYpJ7o59HnXFebfmqBUy7lv2p6y7b24+W8f55Z2aQWfbAcGUf
	5rlBq58rfY6qMCFSSgfj1K+6ENWaa6r3ocQ1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMZjOu93CNMRYUh5am1GwjtwUwyOSjtf
	pPcvHbcOYGW6VoDT1zOqCumUKcZ+Gnkhf9a1EczpX/OHpzsTGSzbp1Qh7JMstp3f
	NIl6ohIETnidFbJJcXwEhY9DukK/qtHg4aTaaZy2fdbx39MdvhoMy58r7/iEhvXV
	r6xbQ4qwo8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B132946D;
	Fri,  1 Jun 2012 16:08:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABA8E946C; Fri,  1 Jun 2012
 16:08:42 -0400 (EDT)
In-Reply-To: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com> (Jiang
 Xin's message of "Fri, 1 Jun 2012 18:04:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95F03346-AC25-11E1-9604-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199019>

Jiang Xin <worldhello.net@gmail.com> writes:

> The following changes since commit 042e9f94a71977b471e230f0c637699b0a7ca3d3:
>
>   l10n: de.po: translate 3 new messages (2012-05-15 19:09:02 +0200)
>
> are available in the git repository at:
>
>   https://github.com/git-l10n/git-po/ maint
>

Just a nit; could you give me git:// URL not https:// the next time
around?  I could work it around with url.*.insteadOf, but I tend to
trust git:// more (as thers is one less component to break) and it
is more efficient.

> for you to fetch changes up to 3f0812f68d7d4b7f11a850d4c895b168b9490b7c:
>
>   Update Swedish translation (728t0f0u) (2012-05-29 09:28:34 +0100)
>
> ----------------------------------------------------------------
> Peter Krefting (1):
>       Update Swedish translation (728t0f0u)
>
>  po/sv.po | 536 ++++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 289 insertions(+), 247 deletions(-)

Pulled both maint and master.  Thanks.
