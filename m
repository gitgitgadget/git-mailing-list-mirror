From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.7.7.5
Date: Mon, 19 Dec 2011 16:03:29 -0800
Message-ID: <7viplckt2m.fsf@alter.siamese.dyndns.org>
References: <20111216105757.GA11174@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 01:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcnBC-0002aT-AC
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 01:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1LTADe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 19:03:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1LTADc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 19:03:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8E2D5500;
	Mon, 19 Dec 2011 19:03:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xTU/IGPUxqJh2Uc/wJROLpk4/s0=; b=KjU5tf
	sqtPJPr53SofliTTxL5L2xJUpNonSBwndiiqqLM336BeKmLFbFA0CntegjV+S/7O
	QpBeDFmvzjf7XncG7oYbqmU5kTQdsDyWvj/ET68LvlacAVLIeyJiEswFCDvOZPFF
	L0DDcAz2jvtEAoJnL4qm5keXYU8vPRCXtBMnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k0RQlJ8qzh783D7OKsLQXZOWJIHeIY43
	AzVgxDR9zXkvd8EhqnAncfU6ASB61BjbXQ9CtclWGsCOm7thnppgzgDgKH//oju3
	alvFub+UOMLGrrzmg908E5G8EQwPPcMIx61S0qmuBw7U6udkx/zH7upoIXw/he7p
	0LT1aQepevE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE80A54FF;
	Mon, 19 Dec 2011 19:03:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65D4A54FD; Mon, 19 Dec 2011
 19:03:31 -0500 (EST)
In-Reply-To: <20111216105757.GA11174@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Fri, 16 Dec 2011 04:57:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D4E80E6-2A9E-11E1-AB37-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187484>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I noticed that v1.7.7.5 was tagged a few days ago (b36dcd72), but
> there is no corresponding tarball at
>
>  http://code.google.com/p/git-core/downloads/list
>
> Will there be an official tarball?
>
> I don't mind either way, but it would be useful to know whether
> distributors should make their own or just wait.

I personally would prefer distros to get stuff from the tagged release
point directly from SCM themselves, instead of using tarballs, but anyway
I've uploaded both 1.7.7.5 and 1.7.6.5 tarballs.

Thanks.
