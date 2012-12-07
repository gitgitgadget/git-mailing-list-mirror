From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Fri, 07 Dec 2012 09:59:13 -0800
Message-ID: <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 18:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th2D0-0004bS-9u
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 18:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423639Ab2LGR7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 12:59:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423589Ab2LGR7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 12:59:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A35B88E4;
	Fri,  7 Dec 2012 12:59:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=61U/R4lCcAwnxxucxxU1lBp/xZc=; b=I6MoQY
	5QuYXNl/meat8Hml2eoiJxI3VzAfGnHpSJjYErpx3/HxEcU/ZkVIdV9olB3qsyeD
	LfXbBuTfJC4SQPThaEBX+V2sqwtIi7LaX6RxkTNHlrvOYtZbhMMOYapka5r+D7lY
	+mLZUpBsOod2X6duTeCa2dcRXe0ZrFkE6KZGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1xtXwooV0vLJMBGxpYMdn6AzNOiZRev
	b2s/QN1b+FVysKAErHTy7zdFFcZ6Z+ceQohmp04si9uk7uuRSW+dm/JRtE8T8aQf
	y2oDaMRV4mIhen8o3m2kl3VZ1yXMBvP0qeud+GCUrE23k6PVtlbD6Mi8uAyCUqJ9
	KT49LusvpwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0750F88E3;
	Fri,  7 Dec 2012 12:59:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7585E88E1; Fri,  7 Dec 2012
 12:59:15 -0500 (EST)
In-Reply-To: <7vobi5hhn9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 07 Dec 2012 09:54:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0626D94-4097-11E2-B1D2-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211185>

Junio C Hamano <gitster@pobox.com> writes:

> The linked page has not been showing the promised "more complete
> list" for more than 6 months by now, and nobody has resurrected
> the list there nor elsewhere since then.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * If somebody has a working replacement URL, we could use that
>    instead, of course.  Takers?

A possible alternative could be https://www.ohloh.net/p/git/contributors/summary
