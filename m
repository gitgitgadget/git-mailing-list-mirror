From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #03; Fri, 9)
Date: Fri, 09 Dec 2011 22:13:02 -0800
Message-ID: <7vfwgtar9t.fsf@alter.siamese.dyndns.org>
References: <7vk465b834.fsf@alter.siamese.dyndns.org>
 <m3vcppgojy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 07:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZGBN-0004CT-D7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 07:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab1LJGNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 01:13:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab1LJGNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 01:13:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AD7E2282;
	Sat, 10 Dec 2011 01:13:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHFBY68zbdSqdaz09SSjQn629BI=; b=o/WSp9
	wmtyxwdA0j/CoXHWyBxD54ab6ZyNCrXKdObRlH5YB/Eq9WLL1C7kchwsk4OL8tX8
	tfG5kScWRt7ki4oi/bctQ6ZyvYcU7N3Lt0Eda9ja2XeWl9eRse3xjX5uCqCt76ne
	3A5oTUpqVt52G41I6gn9BO+vKpxsnZ0LtImAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iG/HcS8Q3/6kmQ8v3d/ASMJ6v8F+3g/I
	6EIIne9nwHEpnDHTpDcy4r1c3/Ct30Htqoh14r0p/1uyZn9alm98tFfNWmCS1CjS
	rpqpr3MTsYhrGa6gOTuk8qEXpLcBkrMWB7YPunKLgbM1y9XOzi3ixYhOxLzZgXfm
	qe091Z2KH5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02CBA2281;
	Sat, 10 Dec 2011 01:13:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D7182275; Sat, 10 Dec 2011
 01:13:04 -0500 (EST)
In-Reply-To: <m3vcppgojy.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 09 Dec 2011 18:16:02 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 055F130A-22F6-11E1-9EC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186723>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [Cooking]
>
>> * jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
>>  ...
>> 
>> Replaces a series from Kato Kazuyoshi on the same topic.
>> Is this ready for 'next'?
>
> I think it is.

Thanks.
