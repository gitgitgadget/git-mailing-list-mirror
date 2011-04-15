From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 6/5] Documentation/format-patch: suggest Toggle Word
 Wrap add-on for Thunderbird
Date: Fri, 15 Apr 2011 10:54:11 -0700
Message-ID: <7vtydzcse4.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie>
 <4DA7F6C0.4050707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:54:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnE5-0002yJ-9j
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab1DORyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:54:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab1DORyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:54:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB853340E;
	Fri, 15 Apr 2011 13:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4scqfaP4owSO9QIM9BeU76Q6VzM=; b=e4+Fky
	cSHbvReE04zApoMP9icyx1aC/mc1rZQkIOhFYSbzemJvZzgXwr45bU8chof70Tn9
	GPCPMpmMNomAPoKnRHgx3jnpcQhtSo1hUKX48Ow1lCYmWSlSwsnJvtOvHHVKrz8d
	DT8KMn4hj0mBxHLNPxx2wiMFQx0feViP5fj94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WbvC35w+ALcseY3yZOBggfWbpidJJCPV
	2dDOGS+WRj8YkkWCGj46WlMTwhOjWQUZIEnUBqyf/igAeoN36JRxh9RTT0HQU9eT
	bPjky0RkDr2ljbVGXjQZP2P1wFjyAQUxSdrb/wAcoGMaQq0fQjp+I7kBRlyXf/le
	hXAcnrRgdyw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E278340A;
	Fri, 15 Apr 2011 13:56:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5424D3406; Fri, 15 Apr 2011
 13:56:11 -0400 (EDT)
In-Reply-To: <4DA7F6C0.4050707@viscovery.net> (Johannes Sixt's message of
 "Fri, 15 Apr 2011 09:41:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB34F0FC-6789-11E0-8DB2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171625>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  How about this as 6/5? I used the method described for this submission, so if
>  what you got is unusable, you know what to think of the suggestion ;)

It seems to apply fine ;-).

>  I put this suggestion as approach #1 because I think it is superior to the
>  other two (iff it worked).

Care to reword "superior" in a less subjective way (which should be very
easy --- both existing suggestions seem to force plain-text no-wrap on any
and all outgoing mails and to make it cumbersome to flip back and forth,
as opposed to this one that gives a one-click on-demand way to do so only
when you are sending a patch) and put it in the log message?
