From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: quote the user name in the example
Date: Tue, 23 Feb 2010 19:00:02 -0800
Message-ID: <7vwry3nxsd.fsf@alter.siamese.dyndns.org>
References: <1266980049-5835-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 04:00:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk7U1-0001hI-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab0BXDAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:00:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0BXDAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:00:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BDD19C1D7;
	Tue, 23 Feb 2010 22:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UqQs30jDzIMti+LUGvG1YAyJ7OU=; b=h9Mpm9
	h/xDz4f2OZMxPIm7xTIGexaxXFtz2zmeRgdd3i9LIB64HR3AOzDeCl3iOT4bG9ql
	1dKveIOsouAmEFPjAZQ2zvHAvi3iZfcn4183cFl6pnP1fG0G6W/i7y2XMb2Pb5eU
	2jJTfUHTM+3xQatbrieZv1e0Q1Z6BvSgjpbfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAfwSzWScXmOvJEr802esexI7n/8/RVO
	bWCWfK3lbjyw4qbM9dJnZPigTdYVCLjOyxJz3MbfXwaOuHHnSM72LAQ/scqbGkJ+
	hAlCrP2eHvEVZWFvAIbwZdQtn34LldP/1d9eK5hHR+Bz4YTP8QcMeQtfCyM8IEVi
	OWuZVYO6Kik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0069C1D0;
	Tue, 23 Feb 2010 22:00:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C949C1C4; Tue, 23 Feb
 2010 22:00:04 -0500 (EST)
In-Reply-To: <1266980049-5835-1-git-send-email-kraai@ftbfs.org> (Matt Kraai's
 message of "Tue\, 23 Feb 2010 18\:54\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7137654-20F0-11DF-95E6-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140891>

Thanks; will queue for 'maint'.
