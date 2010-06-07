From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/18] Portability patches for git-1.7.1
Date: Mon, 07 Jun 2010 11:07:05 -0700
Message-ID: <7vy6eqvhrq.fsf@alter.siamese.dyndns.org>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100607154511.GA9718@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 20:07:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLgjM-0006Sa-KR
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 20:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab0FGSHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 14:07:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab0FGSHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 14:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE914BA1A7;
	Mon,  7 Jun 2010 14:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=5NTj4syNmprPlG0W6Eq84frBH30=; b=kxC4VG
	kfoFMozgru+w40Snfk9nqOO7iO34gCX0mduvB+Aejhi3aLDR6xn5Hy7R+RrIfNoy
	OCH8cASir1unORYsiWK/PkNHwmcPHdly7/EIDhFXAYUu4rdCxHrsCYP0m6Dpjwie
	Al35+pzEj2NtW4hb6Lw69hy92zDiSjN4CFvtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cC8YIcn/O9VwiezLk/x/AkX997B9GMw1
	0eP3c6Wd8wlr2mBMatx3TdyteBzKZuDMwDaJB4wFqgETJ7KP810ORWqXmFUH8TY4
	Nk3HHj2qC8Bv6j8NPPeYYLfF55UBZ3NEzkmIp8L+rqprvX1jN4f4e8des+fnjpQR
	wvnEqw/P0Rk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A391DBA1A6;
	Mon,  7 Jun 2010 14:07:09 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBF25BA19A; Mon,  7 Jun
 2010 14:07:06 -0400 (EDT)
In-Reply-To: <20100607154511.GA9718@thor.il.thewrittenword.com> (Gary V.
 Vaughan's message of "Mon\, 7 Jun 2010 15\:45\:11 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D6F4020-725F-11DF-B30A-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148613>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> Just bumping this thread so that it doesn't fall off the radar.
>
> Is there anything I can do to help reviewers or committers accept
> or reject the patches in this set?

Isn't the series already cooking in 'next'?
