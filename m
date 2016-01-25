From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GPL v2 authoritative answer on stored code as a derived work
Date: Mon, 25 Jan 2016 11:06:37 -0800
Message-ID: <xmqqzivtfphe.fsf@gitster.mtv.corp.google.com>
References: <6D15DFBB73355B4E9EFB1AD5EF9FCA3184242757@NZ-EXCHANGE1.fphcare.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Smith <Jonathan.Smith@fphcare.co.nz>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmTN-00051O-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbcAYTGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 14:06:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754583AbcAYTGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:06:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 071CC3EC55;
	Mon, 25 Jan 2016 14:06:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFjLyCpksGhI+qA9E5+lB/vFQMA=; b=PdD9uo
	SGQCSi/CN71ghNkMl8a4XW+3yf5hDpB6LSw4I7aR+ClsA9O94Go14TP+5O1szJeh
	i/z9ihlUJqtsTJWBKT3Jd5FE8qSsywcsVTHv41pHCFYizCfjxKmTOwFd4057fLJn
	p4aECEMhv8WsmIr6UvVYXL6PjIHqAhD8Bz0uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P4jU7ykWdaod6t83tvnOjiiuaqfIxnfQ
	AwE3Z5z+mdunNSA2/n3hw2Te3+25aU2iYMAM0rnWzM+GK7tCNPbPY0Mrf/c7a3CS
	tFKjINQ2PeaFkcK3TbI0tCW2zwG+HAXwyqFDepjaXH+NAtqxAWIQR7wZfBitBPwE
	Qi+VyJGO7oU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F28633EC54;
	Mon, 25 Jan 2016 14:06:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71CC33EC4F;
	Mon, 25 Jan 2016 14:06:39 -0500 (EST)
In-Reply-To: <6D15DFBB73355B4E9EFB1AD5EF9FCA3184242757@NZ-EXCHANGE1.fphcare.com>
	(Jonathan Smith's message of "Mon, 25 Jan 2016 03:08:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C35C8EBA-C396-11E5-8889-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284748>

Jonathan Smith <Jonathan.Smith@fphcare.co.nz> writes:

> It's pretty clear that code stored in a Git repository isn't
> considered a derived work of Git, regardless of whether it is used
> in a commercial context or otherwise.
>
> However, I'm unable to find this stated in any authoritative and
> unambiguous manner.

Is it reasonable to ask for such a statement?  I doubt it,
especially if "It's pretty clear".

Without such a statement, I think we have already seen that the
commercial adoption is already appealing.
