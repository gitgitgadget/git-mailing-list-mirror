From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] stash: suggest the correct command line for unknown
 options.
Date: Sat, 06 Mar 2010 20:01:11 -0800
Message-ID: <7v1vfwbx14.fsf@alter.siamese.dyndns.org>
References: <20100305170841.GA9325@coredump.intra.peff.net>
 <1267814603-26158-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Singer <thomas.singer@syntevo.com>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Mar 07 05:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No7gM-0001aT-FY
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 05:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab0CGEBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 23:01:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab0CGEBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:01:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FB89FDCC;
	Sat,  6 Mar 2010 23:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=vlIgXZ
	IDd+RQIbNTaEm1dfbhU32si3POJNx8511g0yyYNOt2CpOpoduja25voAWcPdwT7a
	pOPtN2iEWcJUTd0Ljlvxq5NwfZvLYQPmHYWFIl/mvIFZ4abOIAhXybr16YpLePHX
	3VVFhuRe//UC/c931Zl5Z2XtRmRLUMOcyrdtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxLVGALd6iReh0b4Cpy/JN2H/pWu6rP4
	4U2LHnAung1OVkK+JVMtrnSHc4wOUCp1lXGl+G/6pIEK9zu3eEgW/pWxk44sutJ5
	rUurHANjkQaeLjHyGPnuhUPN0eZPvTyMGkXHJ7+CyFwc4nLpj8oWHchqr27rTt+e
	+a0v6Q/Xcnk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B4579FDC1;
	Sat,  6 Mar 2010 23:01:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B61DE9FDAF; Sat,  6 Mar
 2010 23:01:12 -0500 (EST)
In-Reply-To: <1267814603-26158-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\,  5 Mar 2010 19\:43\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14C9AFF6-299E-11DF-BE1E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141646>

Thanks.
