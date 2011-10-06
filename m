From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Thu, 06 Oct 2011 10:27:15 -0700
Message-ID: <7vehyq1158.fsf@alter.siamese.dyndns.org>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
 <4E8DCF79.50200@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:27:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrjT-0004uR-AP
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab1JFR1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:27:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758729Ab1JFR1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:27:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83ACE650A;
	Thu,  6 Oct 2011 13:27:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6JOJuwjKE/cs/B5sQ1Fe1/g59F0=; b=UaySyf
	67jrSkyDuMViPNTN2RIrHD0sL9arGTBV8Rc3Bka5055VwUFhIjtMprwePe3KBPeW
	pZiq70ZM29JjQ0EbMaUv17Chm85mJ9y5ZgeEhUwqc8bLulPXQIHf0ZhSERF2UNnN
	8P5VZZjz4BNVzjx21ewOKe+BvGYm/RBdpCEvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ouzRVgwPEkRK09vk5bhODRquyuyVmPDh
	rfGUbCbiSWL5i1zEEIXpKEwCksXmpdxXoibbluyq6T9Y7hNAxU+A+iFwFu+Ox145
	4qivBKOZi4gENxeaV+K31OXPhqolPRqbkdGslAAqhPWxa/uuvdScryiXFQxXywy9
	f3ETTegI1lU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BCB66509;
	Thu,  6 Oct 2011 13:27:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 129A76508; Thu,  6 Oct 2011
 13:27:16 -0400 (EDT)
In-Reply-To: <4E8DCF79.50200@kitware.com> (Brad King's message of "Thu, 06
 Oct 2011 11:55:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 702084B4-F040-11E0-99B2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182992>

Brad King <brad.king@kitware.com> writes:

>>   + push: teach --recurse-submodules the on-demand option
>>   (this branch is tangled with fg/submodule-auto-push.)
>>
>> The second from the bottom one needs to be replaced with a properly
>> written commit log message.
>
> are a separate topic.

Thanks for reading the list carefully.  What you described is exactly what
"tangled with" means.
