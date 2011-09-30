From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updated tag 'junio-gpg-pub' ?
Date: Fri, 30 Sep 2011 16:18:05 -0700
Message-ID: <7v1uuxoc0i.fsf@alter.siamese.dyndns.org>
References: <4E856676.3050209@atlas-elektronik.com>
 <7voby2oy2s.fsf@alter.siamese.dyndns.org> <m2zkhlkgv2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 01:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9mLP-0004VE-5L
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab1I3XSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 19:18:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab1I3XSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 19:18:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6B56F45;
	Fri, 30 Sep 2011 19:18:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dKYd/eExtEexAlwZ9RSTiVp39Y0=; b=FWoAU9
	hNj8hNbBp8BmWP6JXurN2prvyNxlYUogQ7moC+uMjuAAI9g4ZJKPaSp/9nksGUmx
	0yWz21zRZxTzB6fv/cQCL+Jjn+sgSinVWzVh9LbVT9orVeIJ4sOzt1FyO4/J8scU
	RloxDxRTFYMISWDGPspo4eRhzLaP+QHcjNpU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QU8K+sB8aLCrw3fNpFxwq9UM0lBO9N2z
	/asslJBSJacT0mqf4JodhyzVeArLKtEeuyZnFcagJnqGT62uAT34iYHYOcIH7LxQ
	1iCGDmfCmcSGAahKMYrZqAUOA5Slw7+6eVmqVwzlY/KvkjIppsIT1XsNOEeR+y/o
	vqr4X3MJjb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D1C6F44;
	Fri, 30 Sep 2011 19:18:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20B696F43; Fri, 30 Sep 2011
 19:18:07 -0400 (EDT)
In-Reply-To: <m2zkhlkgv2.fsf@igel.home> (Andreas Schwab's message of "Fri, 30
 Sep 2011 20:46:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 747810AC-EBBA-11E0-A01F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182523>

Andreas Schwab <schwab@linux-m68k.org> writes:

> You might want to update the tag message the next time with
> s/git-/git /.

Heh, good idea ;-).
