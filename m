From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] clean: typo fixed
Date: Mon, 22 Dec 2014 09:57:05 -0800
Message-ID: <xmqqoaqva7pq.fsf@gitster.dls.corp.google.com>
References: <1418978267-15282-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37EP-0007Pi-PU
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbaLVR5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:57:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932089AbaLVR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:57:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F0FD28788;
	Mon, 22 Dec 2014 12:57:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=UmHL1U
	NCGiOuVLq97JpSJmY1mQsbedQ7X19E+29nyZOrRKmHSfSNnm/n8vnsBILMOmCdk8
	NUVucY7XyQnkJJjtDHV0PgjOCv4kBsXPk2JeAMoaPDUNk/nzcKzVDOEx2N1B+y/d
	qcEvzj8xSW7wh3t3VSKkdccrKs4KasqP4O4LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HE1GKyUFLXzHJ9AQ9xI5W4TpKjXNNU0c
	8CkZiR/rDnKqt81+KfdhSYHK0EW79EGwaEFVepJEmdMEZl4NNeAQgNMtzmzPOa4W
	UjLLxNAgVpHiI/cx1+8y0x547UR2V1OFdA76AEPan8/sWXaNrQzdkwCLfPBW9YwE
	XM8QSmBuXB8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24B4928787;
	Mon, 22 Dec 2014 12:57:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89D1828786;
	Mon, 22 Dec 2014 12:57:06 -0500 (EST)
In-Reply-To: <1418978267-15282-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 19 Dec 2014 14:37:47 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F14B7CB4-8A03-11E4-8374-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261659>

Thanks.
