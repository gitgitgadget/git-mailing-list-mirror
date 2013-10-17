From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My patches
Date: Thu, 17 Oct 2013 12:54:34 -0700
Message-ID: <xmqq8uxrzn9h.fsf@gitster.dls.corp.google.com>
References: <20131012072450.GA21165@nysa>
	<xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
	<525c64ebe2390_197a905e84c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtea-0003Ig-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762571Ab3JQTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762564Ab3JQTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1014B3CB;
	Thu, 17 Oct 2013 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0B2lbdNbWPOWvPrVc3vtrsoYB8M=; b=VqFN380F9E6UOqnzWNOb
	gtadIPvYCbIlwcsQZ0jdQnb+ISNJrNkpwa0IsSTpXhzpvsiY903ZF5cvzRkti7UU
	EVqNlbYVguVHDT4FHiEiogTxoI+GnN/5N1G08S7/jQVWvohjbyen0wv0U7I8u14j
	n1hmRLgDW3ZEvKOOiPODhEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BGCb3PjlHnboe18xtUKuS1gzj2MmVh+vNF224ziRbaLVyf
	MFfotGRf1iorgCNYPeLwwYwxtUJ4mNIlwJLCvNh9wZ7J7T+fkLpZuCGdZFLx+SUG
	7fM88qgp3DALnVTyEaaryMnMlAyeHE78SHXgl/Ya9MMORGlrdEtq+azP8+39k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E00B4B3CA;
	Thu, 17 Oct 2013 19:54:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D52D04B3C2;
	Thu, 17 Oct 2013 19:54:35 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F2F87FC2-3765-11E3-A70B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236313>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Such a review comment and the discussion that follows it after a
>> patch is posted is an essential part of the collaborative
>> development process in this community and it has helped the quality
>> of our end product. We unfortunately saw time and again that the
>> process rarely works when the discussion involves your patches.
>
> No, you did not. What you saw was a person that unlike a trained dog, argued
> against you. And apparently your definition of a good discussion is one in
> which the other person just does what you say, and doesn't argue back.

That is so untrue that it is not even funny.  If the ultimate goal
of your whining is to spread misinformation to make you look like a
victim, you are not worth talking to.

Contributors often make sensible counter-arguments and/or explain
the rationale better than they did in their original messages, and
then receive a "Thanks for a dose of sanity" (or an equivalent
phrased in different ways).
