From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 04 Mar 2010 10:26:51 -0800
Message-ID: <7vy6i854es.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <be6fef0d1003040409o5a1e3396l8249951e8d65b1ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 19:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnFlM-0007px-FA
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 19:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0CDS1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 13:27:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0CDS1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 13:27:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C428B9F903;
	Thu,  4 Mar 2010 13:26:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=P7KEvaXYTGZs7lMPvluQG2KnkNE=; b=szKvoWo3ibzDOdnm1qr4TiP
	Heszb6FTnPGFByqS99Gfs2+FOGdvcHju7jPI8m5aTnDsdlsvKkDXyABwP3dSLmo/
	p3jVOtucHbRyJ7JZSQmoX9Pf/kT5hJqlKomVvWhkbkFur/XzOuPtrOcXfMZL8Bao
	bAiAtQNl/Rll+IejsXLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IinV9F2Q5ur+WYGUTjp1lLcoDBfUE3OCVTtHRoFPr87Z36fgx
	tFHtWNfLlyM0eOtMVeigwrWAdLoy0L0GdewUNKeDXOM64mtOl+3btlxWIS9krJwa
	S5thcEl14mvRvmUVa/wUhBwkGrLT3hqgoufiqe2H4Pz8vPEknRqllGYnx0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F25D9F8FE;
	Thu,  4 Mar 2010 13:26:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D66AD9F8FA; Thu,  4 Mar
 2010 13:26:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83A7660A-27BB-11DF-80E7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141540>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Thu, Mar 4, 2010 at 8:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * tc/transport-verbosity (2010-02-24) 10 commits
> ...
> the last discussion on this topic centred around the git-pull
> documentation, which this latest iteration has addressed. Jeff also
> gave his OK for the previous iteration.
>
> I also noticed a merge conflict - I think the resolution looked ok.

Thanks.
