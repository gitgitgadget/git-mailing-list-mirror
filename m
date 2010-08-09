From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: add a FILES section for show-ref
Date: Mon, 09 Aug 2010 12:33:39 -0700
Message-ID: <7v62zj60oc.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
 <20100809013243.GA9385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiY6e-0007Ya-OR
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab0HITdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:33:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0HITdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:33:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4973CC899;
	Mon,  9 Aug 2010 15:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=m0MOiu
	xL3YazO3wuC91wAzKWeJk6bQcuDTIViB8nlk/lze/w6zh1iwkvUogHJb5P0IUkxi
	GPZKtzvEH7dD/KHPIj7MdcBKMSHZi2Jsq82y0LMmPN6wWakfi1F1SjTeqh0ukfcN
	c6fW3RNvl+5ZcR7XyZkD/HJctHVrbdVW9eBrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXs/mnrf6E4aMlUW7FB7WSt6u7HEyV6a
	dlveRX6kngetKDduiPt35ZZe4K3Bc2FGQQGDe05noe+fznO/UlVJNN7gK+4AFcy7
	boPGXBowlDFZac4xno/gS/ciVYym3W+x1O3Nb6FYpliVQnn9fOS7X0L6UjkwEC3P
	E7zMnFUEGu0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69289CC898;
	Mon,  9 Aug 2010 15:33:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98D00CC894; Mon,  9 Aug
 2010 15:33:40 -0400 (EDT)
In-Reply-To: <20100809013243.GA9385@burratino> (Jonathan Nieder's message of
 "Sun\, 8 Aug 2010 20\:32\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06613ADC-A3ED-11DF-BE22-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153005>

Looks good; thanks.
