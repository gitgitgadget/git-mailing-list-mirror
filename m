From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Combine more (email, name) to individual persons
Date: Wed, 17 Jul 2013 18:01:10 -0700
Message-ID: <7vtxjs4r6x.fsf@alter.siamese.dyndns.org>
References: <1374092191-29851-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 03:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzcar-0004OB-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942Ab3GRBBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 21:01:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756630Ab3GRBBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 21:01:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9695F27FB7;
	Thu, 18 Jul 2013 01:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J4/GnT9KBtAv8GdpnjDzS28JKUA=; b=Cqd4cw
	fTZMtSTh3GCUZUUevmKjXkPRwaTER2zknzq7X7FbPjoO9OgE1+qQ+F6UZSU+KJCF
	HCnm0Mqml0PGSo3JrbmPNKwBMNn/awtGhrfhCsH1xJ2uH69fgMrWL/DhJs2PkE69
	5QjDdkJkeDTZznUzLAQswwmVpmd7GRpNhXHJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdWp8PORaJtzaU7JmUzGhOOTWreE3WOD
	QWuekCu583qnTTvyI3yI29iWu2t4vUvF16KEamNXckkQ/cfxhtIclK1p+gdUT7mw
	BccHPQQhnKcqOLCbdRYea9rLIZCJdnh9SIW0O4sdx6lo/YIFQayC76lBl0MUmjEu
	82WyUkravFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE2B27FB6;
	Thu, 18 Jul 2013 01:01:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF0827FB1;
	Thu, 18 Jul 2013 01:01:11 +0000 (UTC)
In-Reply-To: <1374092191-29851-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 17 Jul 2013 22:16:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89D23A28-EF45-11E2-AC75-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230674>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I got more responses from people regarding the .mailmap file.
> All added persons gave permission to add them to the .mailmap file.

Thanks.
