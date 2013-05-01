From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Wed, 01 May 2013 10:55:54 -0700
Message-ID: <7vmwse7ff9.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
	<7vli81ghsf.fsf@alter.siamese.dyndns.org>
	<517FD505.9000706@xiplink.com> <20130501082434.GA19771@blizzard>
	<51812162.3060801@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed May 01 19:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbG5-0005ft-SF
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3EARz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:55:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3EARz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:55:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF4061AA82;
	Wed,  1 May 2013 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OgIXQOq9RuODC/hXJaVd4EF+KSc=; b=k6wO88
	oi1mhHyscH8r1ViYrbdizasjQKXQLXUmpObcfCYP+edSVUOpOZ7RPLYjtePEDhKN
	159hWSthBMRRn9jdlrQ9kSmG9Uka1j/GLIdtHbRgMIg1/Mavi6DP9tDdKTuil0FT
	B/QWcbModBbK+J2ucNF8rnSfUOXqE9UwgIU3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0hlcdv7WtS5nCWaaFVrPxtBX3qp+/Rj
	p1ZXRG0Hy1mhUida2n+XqqMqbYqH60GppCLNQmwQQoUXx0VpAgd51TeX9QDqMLah
	kxDfYAcK6hZvwdcvYMcclX2by4jx2SzvDYiJxPkCh9iuV9/sBohpHNu6gy5eoeQr
	aCNsTCsJ+Js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64831AA81;
	Wed,  1 May 2013 17:55:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ECE41AA7E;
	Wed,  1 May 2013 17:55:56 +0000 (UTC)
In-Reply-To: <51812162.3060801@xiplink.com> (Marc Branchaud's message of "Wed,
	01 May 2013 10:06:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F932172-B288-11E2-8F0C-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223106>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> A third suggestion:
>> 
>>     "git bundle" erroneously bailed out when parsing a valid bundle
>>     containing a prerequisite commit without a commit message.
>
> I like that best.

Concurred.  Thanks for your help, all.
