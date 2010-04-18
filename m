From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate 
 <transport>::<address>
Date: Sun, 18 Apr 2010 13:59:43 -0700
Message-ID: <7vzl10v5mo.fsf@alter.siamese.dyndns.org>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock>
 <1271566767-sup-7167@kytes> <7vk4s4wqo5.fsf@alter.siamese.dyndns.org>
 <m2pfabb9a1e1004181144x10f6a0f1x2e55bc025aba781b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 23:00:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3bbB-0003Xl-D0
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 23:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab0DRVAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 17:00:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab0DRVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 17:00:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50347AB8D8;
	Sun, 18 Apr 2010 17:00:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Djx9kgRZE/jurQMM4A59De2HT8=; b=c9Esuw
	iTu1d2+J5UakGxjMGcZ5gzv618hy9365NDBSGbiRK2mcZr1NbjUYuoO7nQdeOdna
	xbMT5HEVDOaaPEVwgX57NbeNmuMyBlaelJ5OXWX3iqnbQOealC2NibUgnjvTCnbc
	Wn962ORO2Lp5VCZIPsvjZZaaxBSiIdtydridY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=psgCDeTRVGLBIckhwwRl8y9P//9VwuE3
	MwDVl4BmRL7y07Gn6Oowr1S3mSIJTMBJuLvPo8fzZd0q/gmyCAqixpBcm9tbV0WV
	/uLfZIOdL1S+Qlo/dnIo41/4PjbcwC1MZlMX1sNUpNFs+yQoC7mUyWiT6HXMlCBc
	kjn+2dKX8Yc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A626AB8D5;
	Sun, 18 Apr 2010 16:59:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D6BDAB8D2; Sun, 18 Apr
 2010 16:59:45 -0400 (EDT)
In-Reply-To: <m2pfabb9a1e1004181144x10f6a0f1x2e55bc025aba781b@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 18 Apr 2010 20\:44\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56B4F190-4B2D-11DF-B11E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145247>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> With that I think the entire series can be:
>
> Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

Thanks.  The end results look good to me, too.
