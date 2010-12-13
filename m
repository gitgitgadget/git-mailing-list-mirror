From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 11:38:27 -0800
Message-ID: <7vk4jdzcng.fsf@alter.siamese.dyndns.org>
References: <4D05F1EA.9000403@viscovery.net>
 <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net> <20101213170734.GA24736@sigill.intra.peff.net> <20101213172238.GA16136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSEGw-0005q2-5y
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab0LMTlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:41:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0LMTlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:41:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 050183C8D;
	Mon, 13 Dec 2010 14:41:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=WTuvSY
	T0pfqc9kbAryAN/FxkIJeA6AeASBnPq3V9EUki6pHY2hXyI5hfTwnihx7YcLaRc3
	Q7DGqWPc4sSfF8G0fyjwJqslvDH7L2TfctNSuQNIPUNydvsHtXg9ILHEywrtL4Ix
	rfrJA/CgjfjqivHD7mCYogluiJcJpdQFCxavQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQV2NnOWoKd30YPDIGhD8hgSCPUqKH4W
	JXORpY/QevfFynl7chDWU3/uw7FFFyLREFBJvA2OtoiQNkC/YOcjVMQjM+MBGar5
	jOCvpLJMZUObGHPW0LKKKnEKAzYD6t/KMLtLhKBB3MymvEYzlDXhl8WVSXxhoxwv
	S3l4qPXve/s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1C2E3C58;
	Mon, 13 Dec 2010 14:41:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9FE533C30; Mon, 13 Dec 2010
 14:39:08 -0500 (EST)
In-Reply-To: <20101213172238.GA16136@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 13 Dec 2010 12\:22\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F793294A-06F0-11E0-B6F4-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163586>

Thanks.
