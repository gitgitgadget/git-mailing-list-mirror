From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git as an sfc member project
Date: Wed, 24 Feb 2010 10:12:30 -0800
Message-ID: <7vmxyytsdt.fsf@alter.siamese.dyndns.org>
References: <20100224154452.GA25872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:13:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLj3-0007Rl-4L
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447Ab0BXSMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:12:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382Ab0BXSMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:12:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBECF9C3D5;
	Wed, 24 Feb 2010 13:12:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=AoCzyuOuZ15Qugvi2lk+qrynsas=; b=fX06Qy
	L+q0s50A7N/zMR5zj5s61phd8IDcFjsZ/HHl4g/f08QzrHjyaWCCC1LYzOwmDNKW
	ARabe4t3+6OCtAf3NTeQ/xRSeKvRl09WPizxSfcZXMzcdJxM09CFyvsjpQkf9zss
	kkcs6rGWuiLGLYrPN0aIekxqYVspYCy91qzN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqcBigZqelzPw4Ya2110L2YCMfXfyawO
	OTHjfdGnVX1VRpJ15t08Ap3qDRTRNe7l8zZUzpMIxytNPwZrR5vI0lqRo+pQxIgv
	AWGsfH1kDZ6jLbY+RpAtXNbwatstiBHfttw5Efs36OYS5IjzTtIErT+eUHT3LHtZ
	RzAN8n4Nlu8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E6E9C3D3;
	Wed, 24 Feb 2010 13:12:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16D109C3CC; Wed, 24 Feb
 2010 13:12:31 -0500 (EST)
In-Reply-To: <20100224154452.GA25872@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 24 Feb 2010 10\:44\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E949BFC-2170-11DF-8971-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140966>

Jeff King <peff@peff.net> writes:

>>    * Existing for-profit or non-profit affiliations, funding
>>      relationships, or other agreements that the project or its leaders
>>      have with other organizations.

Part of my git time used to be funded jointly by my employer and NEC, but
the latter is not anymore.  I need to look for sponsors.
