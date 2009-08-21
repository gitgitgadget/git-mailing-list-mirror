From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 12:36:50 -0700
Message-ID: <7vzl9tdkml.fsf@alter.siamese.dyndns.org>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
 <4A8E6485.7040006@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeZv8-00089R-3I
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 21:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbZHUTg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 15:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbZHUTg4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 15:36:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbZHUTg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 15:36:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C1F13FF9;
	Fri, 21 Aug 2009 15:36:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sB+WOHXzYi2FngKHMoBcYuTeNX4=; b=PKyJu3EZf2tJSNjEygBh1hd
	cLk4QQZXAveUtaTNlurPryLeTiME2GI0bQTvXNLbvzYMBtJABbmQhCUeX+G2hI0l
	qdsYPhvQA27SAPh2wXnjfYW2M+D9VazjwrAwNyOf1nCn4cUH/SpfE1LoLUafwDBv
	an2YWWQyFco/C8MesuI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=jx+G11Yi7ov5e4Ay2VrzD9iYGiXcjKwq+Xa8oEfwgMPUJJUer
	wCdgkTY/zsjmrN6wKZrfDyGB6EuK3gwtSXZdmVh6qftT+svoGU32NXXvJKGUxC7F
	/FDyiUEZduulEMYGq5Fy3ykb4sayK8fljx7L03EbuZ9iSuYsmKpd8lvTQk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E2013FF8;
	Fri, 21 Aug 2009 15:36:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8195013FF7; Fri, 21 Aug
 2009 15:36:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB02DD36-8E89-11DE-B67A-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126741>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 08/21/2009 04:48 AM, Junio C Hamano wrote:
>> Has been ejected from 'pu' for some time, expecting a reroll.
>
> I've been trying for a while to have push refspecs and tracking
> working together, but haven't come with anything that I like.
>
> I'll let it sleep for a while so that I can look at the problem again
> with a fresh mind when I come back to it.

Thanks.
