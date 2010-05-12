From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: restrict tags used
Date: Tue, 11 May 2010 22:54:02 -0700
Message-ID: <7vaas58y2t.fsf@alter.siamese.dyndns.org>
References: <AANLkTim8SRUEaNWyBF_iRQstu84r9eAaUd0a9KLj6OtR@mail.gmail.com>
 <1273634960-2728-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 07:54:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC4td-0006d9-E3
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 07:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab0ELFyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 01:54:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab0ELFyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 01:54:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B27B24A8;
	Wed, 12 May 2010 01:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=gZ2zPv
	K+jBuyj3BP7uix52VGRQdoQH1n7bftGzcWgwBCbj2zGRPVb8weh3Lkx8TxCDt6tl
	VTWDPVGQTKYA4RH/Bxy4003vGS5wAiw/V0McZ91NROMDev7gCwDM7ZzRO/BQmFXc
	v1/pR3MYU+Zsxf7cNoobObYXFi/fRG4tyMxK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fN5yf+LeImWzBQlfbIXNr+tV67f4AcRb
	/uIx02nH1gBddeVWDRIRj28sa+NFfDsvabBPLcm2ABkztb8HYoWvEA+/kmjMEf+f
	vf4qNLKtnBDLOD6ZpuytQOexTTz2AjMjvd0rLvy+XjfnltyyvDpePT4VpvMIeOux
	HmOYuHvGKns=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5001CB24A5;
	Wed, 12 May 2010 01:54:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A047B24A4; Wed, 12 May
 2010 01:54:03 -0400 (EDT)
In-Reply-To: <1273634960-2728-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Wed\, 12 May 2010 11\:29\:20 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C72C7DF2-5D8A-11DF-BC0F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146921>

Thanks.
