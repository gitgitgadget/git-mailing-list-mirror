From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2011, #03; Sun, 13)
Date: Mon, 14 Nov 2011 23:27:32 -0800
Message-ID: <7vpqgtx2u3.fsf@alter.siamese.dyndns.org>
References: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
 <4EC0C101.4060001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vincent van Ravesteijn <vfr@lyx.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 08:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQDQi-000054-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 08:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab1KOH1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 02:27:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab1KOH1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 02:27:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AFAE27EA;
	Tue, 15 Nov 2011 02:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXPMUFQOVSmVxdNez5RseYWatnA=; b=xFxDXq
	auSe0I9HNbKIFAt1S8o2h6elgRwYmBknTfWilZ//LnKIBEpIZNylq7HVDgu/I83I
	CN/OYwiM9yo+RboFLjM+ujoHfaLykqF6yuxVLNc5CrU/j6U26mWkgl5y4UvUTg4d
	QmxVCOfR0UTupHiKqHTzJQsJeJCrGLQ/5gyHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jxGjRzdoagcNDq2DjxFKebdi+/rWs09p
	9G5QvKY7enMDIYBznvviggIM8HCGad5QxOkwXFY82/hj6tHHJLQltjKxHoCQaZFf
	wUVQSQgZFJ8TMaM7ecOEHIX4CAZh0MpMoPHAlhskMaFdhvFtCKRdiAADLPIwbgbB
	O0jIpKTr908=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4274D27E9;
	Tue, 15 Nov 2011 02:27:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D4127E8; Tue, 15 Nov 2011
 02:27:33 -0500 (EST)
In-Reply-To: <4EC0C101.4060001@viscovery.net> (Johannes Sixt's message of
 "Mon, 14 Nov 2011 08:19:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48FEC1AE-0F5B-11E1-A266-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185439>

Johannes Sixt <j.sixt@viscovery.net> writes:

> IMO, these two topics can move forward:
>
>> * vr/msvc (2011-10-31) 3 commits
>> * na/strtoimax (2011-11-05) 3 commits

Thanks.
