From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] docs/merge-strategies: remove hyphen from mis-merges
Date: Mon, 10 Feb 2014 13:06:23 -0800
Message-ID: <xmqqy51ir834.fsf@gitster.dls.corp.google.com>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Albert L. Lash\, IV" <alash3@bloomberg.net>
To: "Albert L. Lash\, IV" <albert.lash@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 22:06:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCy3l-0003iF-IF
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 22:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbaBJVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 16:06:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbaBJVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 16:06:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B396B616;
	Mon, 10 Feb 2014 16:06:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=N4sipD
	1RmoHffHqFQjWE0xaWMMbYyH/P8A5rq97qvK55b5zjSnpFvLv6VjoY3pFdhmWJeq
	6X3rTTlQH1lPLnuTFJCjdn6RYDApa8975AiF/9dSstf36kAYi274H+yxKnMfPc63
	QF+sQ0nvgSrgmdR4YZILxtIGIQcPEnu59iRK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqJxXqLPx4NMc16gt+cCx/Tc67UHVEax
	CrDAnto25NQZRouJ4t/gT8M3SkZ3EpfrvsTdSrs6Zebf+jsO6W1+DPjbevmyzeNM
	UAgYmIjFSQbYai935BDFVYN0DbmcHdwqBCJ6N2Lkze2PNnznLUBFUg5b30Db3npQ
	VWJrpQB+mlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEEB66B614;
	Mon, 10 Feb 2014 16:06:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72DE76B613;
	Mon, 10 Feb 2014 16:06:25 -0500 (EST)
In-Reply-To: <1391892097-16169-1-git-send-email-alash3@bloomberg.net> (Albert
	L. Lash, IV's message of "Sat, 8 Feb 2014 15:41:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 339BC944-9297-11E3-8B4E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241930>

Thanks.
