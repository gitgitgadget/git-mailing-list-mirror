From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the --done option.
Date: Wed, 12 Sep 2012 02:11:41 -0700
Message-ID: <7vfw6nfvw2.fsf@alter.siamese.dyndns.org>
References: <20120822105705.GA30472@thyrsus.com>
 <7vobm2968x.fsf@alter.siamese.dyndns.org>
 <7voblzyj2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Sep 12 11:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBizE-0003S9-8G
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 11:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab2ILJLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 05:11:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab2ILJLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 05:11:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C247DDF;
	Wed, 12 Sep 2012 05:11:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QxqORTmea52YhjvM5VBxh1TiLo=; b=jGKdpz
	7iWq2Q7GlfDDRJJJRX/Ns2GQmJWo+TeS58BpAudv6gnDloft4p2xMqYH9UbXodHE
	Mu0PmgC3wCHx2NJQedng652MABPYt5pYZlnHEpW/Pb0Fhnl0H54APtAu5Xq6lxoW
	RtShhFycpcnsJ0N33+eIM/TpPo9Fi6evWPlqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK4pBvpMpQQqvaRn3ZZonBej4LRLjXC3
	6gRoIvoD1ky8qX9noXy7t9l6rcmjr2M89zvjwdbHX0fOoO6AfX6ghxgII0k+duj3
	Tj+oa4XYIMMwo5hTj3ic2bfR/O+KElwQp61nX8iPAytNupwhqbvLEpfEMDAqCMmS
	OvU81IRsAWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679D67DDE;
	Wed, 12 Sep 2012 05:11:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7AD47DDD; Wed, 12 Sep 2012
 05:11:42 -0400 (EDT)
In-Reply-To: <7voblzyj2q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 24 Aug 2012 16:19:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE70C506-FCB9-11E1-B2F0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205271>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Eric S. Raymond" <esr@thyrsus.com> writes:
>>
>>> ---
>>
>> A forgotten Sign-off?
>
> Ping?  Just telling us that this is Signed-off is fine.

Ping again.
