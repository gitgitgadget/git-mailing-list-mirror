From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Tue, 19 Jul 2011 13:43:53 -0700
Message-ID: <7vr55m80hi.fsf@alter.siamese.dyndns.org>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu>
 <20110717215858.GA9906@elie>
 <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com>
 <20110718055108.GA4254@elie.gateway.2wire.net>
 <CAK9CXBV=OMRVzEjUmb6JP8nM9bQ4DqM0D7xCywxs0TUD5+scrw@mail.gmail.com>
 <20110718071308.GA4745@elie.gateway.2wire.net>
 <CAK9CXBUjTQVsJrERKwmYT=9mBLLDu9uG9+DrFvaOaDPBUpJjzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 22:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjH97-00014n-8t
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab1GSUn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:43:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab1GSUn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:43:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 090E8352C;
	Tue, 19 Jul 2011 16:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cun6UUx1hGs7T7Kr8HTb1WH+jgY=; b=XOiPqP
	YPK7JtoFG/rOOOpstf2BB5Dbwu41L31sEK8dm/4pcr5ycNdda4vqrYdog5vTxNyn
	W9K58f05ijD61KeVLpzhRP1rYOwt5uhwHohMGWeN3b2czRPm/THoyBphifF9uyOR
	ftMWfAAaNhxeqPEGJ3sGvSYW/eXt7MU7kdgVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YIHS766H2I9U+PG+stNdHJ6x9mzMXfz2
	8jfnmebdL75BHh86oT4vhvHv8/nl7SE8CmT/moZoIJyLTCG2de+zJFk0stshGrQ0
	MpA1JDu0I8ngzkgLQEpbNM1ZoXmKgTJMdoZJP0Rct3uRQWAP0AgdSH3JAXlejlLB
	+8y6f+Mib48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 003FD352B;
	Tue, 19 Jul 2011 16:43:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AE8A3529; Tue, 19 Jul 2011
 16:43:54 -0400 (EDT)
In-Reply-To: <CAK9CXBUjTQVsJrERKwmYT=9mBLLDu9uG9+DrFvaOaDPBUpJjzg@mail.gmail.com> (Pavan
 Kumar Sunkara's message of "Mon, 18 Jul 2011 14:31:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1590F94-B247-11E0-A3F7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177504>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

>> A patch with such a change and
>> mentioning in the commit message the two bugs you're working around
>> would seem sane to me.
>>
>> Thanks,
>> Jonathan
>>
>
> I agree. So, if the patch is ok, I will rewrite the commit msg and
> send it again.
>
> Thanks,
> Pavan Kumar Sunkara

Thanks.
