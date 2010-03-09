From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] format-patch and send-email ignoring config settings
Date: Mon, 08 Mar 2010 18:44:00 -0800
Message-ID: <7vy6i29pu7.fsf@alter.siamese.dyndns.org>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
 <1267997598-20815-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyU8-0001Do-KZ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab0CICoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 21:44:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab0CICoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 21:44:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0689A0A91;
	Mon,  8 Mar 2010 21:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=lSH+TL
	/p6V5+Ma/YYwBdNOphHSiLiFPKqNFV0ziduDQ0ZUy+fyjxRRTQ0AOrBulpbYbLkP
	8h3YhmVn65WlOPCx7CCyaqd8Qmuxzdt8EajlUHd0IKaR5SIf/RhouzQhoFt6aD9J
	ps0bq5phjELGviuYnyQ6DCJ4VR6VmmLSslOJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APYkMBfL5bEsPDexZJTVDZAQ8LTxJib5
	D4UBFwWuLePLAle1epOh0JNZwmaRA90iKnQMx7EY6dj/NgAevsGGYbgTdVW2WA2w
	ibvr/+EXtl6MxOWkqRFVizrdn8BfhXp9FITnBnVZcJ1jcUTqhvs0xj0qc9qjI/nq
	59yJdi8izr0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61024A0A90;
	Mon,  8 Mar 2010 21:44:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A02E5A0A84; Mon,  8 Mar
 2010 21:44:01 -0500 (EST)
In-Reply-To: <1267997598-20815-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Sun\,  7 Mar 2010 13\:33\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A142A20C-2B25-11DF-A251-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141795>

Thanks; will queue.
