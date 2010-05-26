From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git pull --dry-run' accepted, but moves HEAD and changes
 working tree
Date: Tue, 25 May 2010 22:07:28 -0700
Message-ID: <7vd3wjqmi7.fsf@alter.siamese.dyndns.org>
References: <20100524135823.GC19861@unpythonic.net>
 <20100525060725.GA10898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8qI-0005SM-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0EZFHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZFHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE46B67BE;
	Wed, 26 May 2010 01:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=EVIpiSlLX8MCC+7CII8esef
	LcMNrZ6UZGtwqKu8iV2CHH7pac+G9In+N/2oAwP7leyVZwO4kpsQ3TPdqUp7k8kH
	tdi3JAdKriSFuOaVecso5c7lPowIinwD1+pCblbWQDfW7QGu7z9uWZPDrxAQxB0m
	lRh5arbjxtTRe1SJrvr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QgRMe0AJGwvD5it9owyNwhqqIYIJhPMHJPt3YS8vD86CixDlT
	lC+FvG+SvHfjF200cnjKEpwlGFM9+V5Hae7bfLl8brQGmimay/P/mDa2vSZ2Yb76
	MOaFckm0Jm28UaJWMBoj9H9aYBG8C3JOgE2CFVJOlF6LXcAjKO/ilA6+LM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24400B67BC;
	Wed, 26 May 2010 01:07:33 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 641E0B67B6; Wed, 26 May
 2010 01:07:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 977FFEEE-6884-11DF-8037-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147738>

Thanks.
