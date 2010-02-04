From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: fix the description of the default behavior
Date: Thu, 04 Feb 2010 09:15:51 -0800
Message-ID: <7veil0gbw8.fsf@alter.siamese.dyndns.org>
References: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5JQ-0001Y8-HR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758503Ab0BDRQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:16:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758462Ab0BDRP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:15:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1A0B972E1;
	Thu,  4 Feb 2010 12:15:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1owdN8UGWe0QFLfSgdSIZI88Cg=; b=wrLbaJ
	Gfp3lxWpBW2b2Y4kTNpuXvEb58YNLEfDBACylNoSWj7MiBEOEHJ50iv0sjcDw7Q7
	Pyjf9o4mt5RaUYwyqYzVM5cwGLbeAPi1t576D1XxIJ1m60TRN92l+2YK57NiIauk
	X9cG7jrwUjb9M/d9FK3BuINif/7IhSNzLcQ2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JgF7KJdU35WEzefo2F2W0DZHEu/oZsH9
	W/pLGuQhLhF0IfuAJERXoFPumhfu5QfBviy4is4v6qX12E8lPmlbu+fkb1ieSxF7
	bk9Y8cyXRuqeL7ezm6GEoHU+xfFrBIWzBw5dRj7iyp94okMA3nMKru8vIv+xJhFp
	hQJGPvPinzQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F10F972DE;
	Thu,  4 Feb 2010 12:15:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3FBD972DC; Thu,  4 Feb
 2010 12:15:52 -0500 (EST)
In-Reply-To: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\,  4 Feb 2010 17\:01\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4EDE7D8-11B0-11DF-8490-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138983>

looks sane; thanks.
