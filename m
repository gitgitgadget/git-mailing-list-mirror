From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] user-manual: Update download size for Git and the kernel
Date: Wed, 19 Jun 2013 10:07:58 -0700
Message-ID: <7vppvi111t.fsf@alter.siamese.dyndns.org>
References: <cover.1371606791.git.wking@tremily.us>
	<cover.1371606791.git.wking@tremily.us>
	<deb78c114d068ab3f9e28bcd019c3e29ad7b770c.1371606791.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLrk-0002DE-4M
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094Ab3FSRIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:08:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756805Ab3FSRIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:08:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 569CC29047;
	Wed, 19 Jun 2013 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=Zzmdzz
	hiCmYhzSwiqErzE/1BQGV2uVCzgWWqndQ/TDmRDj5Pd0IoJSQhyEe6P/L++8I3eJ
	9qCk4LCYoBBpGSUZ6uDBHTqmEdKJd7yCjZd/FW7mYKLYU6e9YCWKddb64kttM0Nq
	ZHKiuA/YJBF+yyrIl26G8Zu11AdHJRJiFCevE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IdFRVihFwCsQSE6UfUcwkKVS7nXjSY6W
	XJgZnRscMrTnPxX9XeafNXnm9TfHgymRHQeDUXKR/UnGQVpLnbWt6R0uhpn30tRb
	U5FfPJppMMM/6ShwYgkLe4fZDMYzZyhEx/+oP+y44wIi8owh/sXjAwNxDc/CJ94+
	GL0z5e0b5Qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF8B29045;
	Wed, 19 Jun 2013 17:08:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 932CA29037;
	Wed, 19 Jun 2013 17:08:09 +0000 (UTC)
In-Reply-To: <deb78c114d068ab3f9e28bcd019c3e29ad7b770c.1371606791.git.wking@tremily.us>
	(W. Trevor King's message of "Tue, 18 Jun 2013 21:55:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D11E4362-D902-11E2-B560-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228401>

Thanks, will queue.
