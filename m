From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for maint branch (2.8.2)
Date: Mon, 25 Apr 2016 13:37:26 -0700
Message-ID: <xmqqh9epjugp.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbHOkYx6CXHkUHBoWfQOJGiEFXJJi4tDTFvAGigKZfO7gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jean-Noel Avila <jn.avila@free.fr>, Git List <git@vger.kernel.org>,
	Vasco Almeida <vascomalmeida@sapo.pt>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:37:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunGN-0005hB-Ez
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 22:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbcDYUhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 16:37:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933455AbcDYUha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 16:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2E6116A33;
	Mon, 25 Apr 2016 16:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YAxqb7AHnbNdCJyWocwk9/GOib8=; b=kAmORb
	00sLPHqVtYXehNkscdBnsW+jjyYFzyDFBIww26ENVgQWlnflaxKX/8mHdJasTz1a
	Rj0R3ny1gaV2i0tWYDSa9MUQVMEwmzKcWbGi2oEw4fxoJVbAnQsJL+ZXfFFDHo1D
	qhtBNFwXbEPhakE0abepmGPcCZ35kB/n6wWNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nVT45SZXLOJdsdDkE8etsSgpTDqDCrs8
	E8qLM5gFCXDDuBeDj2DApjPZ0OQaA303SGld2hlSvlnOLT4ioqkUI6Ckl6cji39k
	BVP8AdZtTsxhbl7k43zbd1p9RkxBvfhUWhBOfQUjgkREuHDm9vND5r4UeQQuUGpi
	nWjuJccLuIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B79816A32;
	Mon, 25 Apr 2016 16:37:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 045A816A2E;
	Mon, 25 Apr 2016 16:37:28 -0400 (EDT)
In-Reply-To: <CANYiYbHOkYx6CXHkUHBoWfQOJGiEFXJJi4tDTFvAGigKZfO7gw@mail.gmail.com>
	(Jiang Xin's message of "Sun, 24 Apr 2016 21:12:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86942F2A-0B25-11E6-AAD2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292553>

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull this update to the maint branch.  It should have been merged to
> Git 2.8.0, but I was busy these weeks and forgot to check my private mailbox.

Thanks, will do.
