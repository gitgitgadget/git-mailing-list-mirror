From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 03 Jun 2013 11:30:21 -0700
Message-ID: <7v4ndff3nm.fsf@alter.siamese.dyndns.org>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
	<CANYiYbHkw1hQpscFFEyx8za9bniHtBriKb=C1CFSpjKntshVHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:30:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZWY-0006Ek-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab3FCSa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:30:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab3FCSa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:30:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90541259BB;
	Mon,  3 Jun 2013 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyxSv5YKhIxMN4UpTmj0dwFzh70=; b=vOQIpK
	qFs2J2tglyJKmYYaD/2ixPUVN4IkcPWv1U0O/vTUscKc8iLf5OvpjgGyt9I2N5a7
	+yGFK6HHAskATUgjsX8iZYyjrBPaxhVbAQNGYYkd8aM1rzVJo7tEUquPP5Ry89lI
	p0uAx69D1VtFcDjQVJgyp2Cyt+pJOUZ7xFdU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fS5fkO35IEYcEtm+0JB1ul5B1HDYEZoQ
	Gyv7X+ZchAHRxYaQQ7noqdwGZIntkCMwJUyw02BC6dJg7Yi5xR2bCgJ0YvJjWnjr
	x64T64RBjYu0UVGbo8xG5tGIvRTGypJjlromnWVntD+Uf5dkvy8HwCr0C6HHOr0n
	U3K0WG36rSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C77E259B9;
	Mon,  3 Jun 2013 18:30:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E033B259B3;
	Mon,  3 Jun 2013 18:30:22 +0000 (UTC)
In-Reply-To: <CANYiYbHkw1hQpscFFEyx8za9bniHtBriKb=C1CFSpjKntshVHQ@mail.gmail.com>
	(Jiang Xin's message of "Mon, 3 Jun 2013 08:35:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A74427F2-CC7B-11E2-9949-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226259>

Jiang Xin <worldhello.net@gmail.com> writes:

> I have updated the patch in the new reply for this thread, and it need
> some feedbacks:
>
> http://thread.gmane.org/gmane.comp.version-control.git/225139/focus=225934

Will re-queue and wait for "some feedbacks" then.  Thanks.
