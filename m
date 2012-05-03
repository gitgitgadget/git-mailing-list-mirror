From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #01; Wed, 2)
Date: Thu, 03 May 2012 00:10:17 -0700
Message-ID: <7v62cdhh9i.fsf@alter.siamese.dyndns.org>
References: <7vipgegrl0.fsf@alter.siamese.dyndns.org>
 <20120502234352.GA2163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 03 09:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPqBI-0007oh-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 09:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab2ECHKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 03:10:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557Ab2ECHKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 03:10:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9C3B6686;
	Thu,  3 May 2012 03:10:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FSfRmdQezI9DqRqVWe+eMHpEvKI=; b=w9jdwR
	xWjo6fF7Xo5+R0y2kErH0dZ0yDoNs+3l6RJD2yZyPRFFhTUTu7AfhQjEPkPp8V+D
	HQvr9TxmFvXKsQL7mqYQzS3pZ6MINAOlCUYumf/2lQQJIAVbDfyOfFuRIfAMEzSd
	2rWW2rXeQcXh1K+kZqXyGDp/ZzO9zsmdSC3U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LR5lkwuoKcpX6FqbflSmYNN9nyWl5HF/
	hI8gwLIBwNWvkMVPNKSSJ7xb2Y3oCKlu+DrEbaMSOYsrKTLnU+TP2KmMxLv3i96H
	9rTYq0He4MDyNRgLnn0/fr2dOaw0I3yuKQ9yG+2s/fm74fUQOIN6JyJ0CZ7HDLQT
	FnLLhbRE+Nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FF76685;
	Thu,  3 May 2012 03:10:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AC516672; Thu,  3 May 2012
 03:10:19 -0400 (EDT)
In-Reply-To: <20120502234352.GA2163@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 May 2012 19:43:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A907EF2-94EF-11E1-9181-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196889>

Jeff King <peff@peff.net> writes:

> Now that this is in master, any in-flight topics would need their
> documentation updated to match this, too.

Thanks.
