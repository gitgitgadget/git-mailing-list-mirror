From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 03 Feb 2010 14:21:09 -0800
Message-ID: <7vsk9iarl6.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <201002031113.11212.barra_cuda@katamail.com>
 <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
 <201002032156.16101.barra_cuda@katamail.com>
 <20100203214652.GE12487@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnbA-0005Ka-B4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0BCWVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 17:21:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab0BCWVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:21:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC5296C2F;
	Wed,  3 Feb 2010 17:21:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yP3OB+1eeIXFpqGpxXxaQjTfL7s=; b=bsUq9j
	o51xTxrhDTX259JanF035ifEtXKJQNsr8EE+mwnigXQXaQ/IG1on+/BBGBlFho0q
	ynjuFudyx9CO2IVISO4QziInHrLOO4J9i4p+QoBNcVW26HTYc5VRR0fYiHw6nbEK
	qgwkFyDDqTr1Nx0qTHUfePzZz7RaCwcKpiCSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lAhL+6ex4UdjIAYB0F372SCdNM+w7nLl
	FBuMQ7ZRA8YG5CJ7G6dJlE1C2gnrhk7PjBgEhCInOTW/SlfPR95pOZyQ3BlDjzQn
	0cmHOxeLEP+T4SUB8WyKKIRy5NpQUN2/81auHpYgWw74jUHHpVLIpYet/bVjupZB
	2ziJKgKVNkA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C36796C2B;
	Wed,  3 Feb 2010 17:21:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96F9A96C27; Wed,  3 Feb
 2010 17:21:10 -0500 (EST)
In-Reply-To: <20100203214652.GE12487@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Thu\, 4 Feb 2010 08\:46\:52 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71715870-1112-11DF-BCC0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138909>

Paul Mackerras <paulus@samba.org> writes:

> It crept in without me noticing in commit d93f1713 ("gitk: Use themed
> tk widgets").  I'll fix it.

Ahh, thanks.
