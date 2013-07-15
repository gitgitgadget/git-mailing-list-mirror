From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] mailmap: style fixes
Date: Mon, 15 Jul 2013 08:22:48 -0700
Message-ID: <7vsizfdf07.fsf@alter.siamese.dyndns.org>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
	<1373871253-96480-10-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uykc3-0006GB-2x
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab3GOPWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757821Ab3GOPWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:22:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7D1318C6;
	Mon, 15 Jul 2013 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2vM6hYd3mHasPrRrCQ4QjR0He7s=; b=fV27Lq
	ZChLBSDPOZHx3XNGLH4ptDpeKbIR+VLQ1wJ1IIx5cWvLlCHhVAa1ljEBZJWn6ihg
	wU6ZJVQcP+bTeMCxOjA6ERPDz5522jldCkhYie9dsF1TxEO2MpcDCuGiNNONuucv
	shWK6egGUjm5PS+8rRa/ij2uj5kPLIovlk6tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7ZsgeWCkwLINxm6O0ZDNa1JRl79hpWG
	KVTLRP0rPZICujQnlkJQ3zrENenetvP/4bsDlVyB6QUE1jJGbl3G4RGaTNXwLokP
	t5JqU6KgWGx+VCIUqq1sj3kblUNx0dSElO+mPt/3a47LZ4DOEwyBzkgr5OQV/wUg
	RHlfH4uW2Ho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 625A5318C5;
	Mon, 15 Jul 2013 15:22:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAA5C318C3;
	Mon, 15 Jul 2013 15:22:49 +0000 (UTC)
In-Reply-To: <1373871253-96480-10-git-send-email-sunshine@sunshineco.com>
	(Eric Sunshine's message of "Mon, 15 Jul 2013 02:54:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68FAEC4E-ED62-11E2-9F03-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230477>

Thanks, the whole series looks sensible.  Will replace and queue.
