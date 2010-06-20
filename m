From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Sun, 20 Jun 2010 10:30:41 -0700
Message-ID: <7v7hltvcfy.fsf@alter.siamese.dyndns.org>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
 <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 19:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQOMD-0003yp-3e
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 19:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab0FTRav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 13:30:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0FTRau (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 13:30:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC6CBD1FD;
	Sun, 20 Jun 2010 13:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qO6XJSYav6Kef+Rp5Iyuq00Q/Wc=; b=ZCmfpx
	6hgG9p32d98JyjBqYFC8BZDGjlhw17jscZE5hXv2OPkpmurvaHYMjAjt68cx/qCw
	6LTobBnArdu5UJqGHCOfC80y0WHasgucB+aMjarV/WU67NNCK1yewFblhS3Qqw0f
	u1/7VjCPuHZWRpHQnW2BnPj50zDAumQ+5BNnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZCoDS85i97PXm88i2+IenZhET1Unwpy
	67oVCwTXmG8l7kzORLPq/6tNrpFjO7OlunjsR9Or1rrPyk3wdWmcbJxpLWGZj9WV
	5DKN19HSrxWVroxNbmWwraTS4EX0M/ev2RlUTjyjAVjoxbXwIFqO95VLCBJijdg6
	RCqGeU0qFFo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BECDBD1FC;
	Sun, 20 Jun 2010 13:30:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F16ACBD1FA; Sun, 20 Jun
 2010 13:30:42 -0400 (EDT)
In-Reply-To: <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
 (Pavan Kumar Sunkara's message of "Sat\, 19 Jun 2010 23\:50\:01 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F056BCA-7C91-11DF-92AF-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149400>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> Junio, I would like to remember you a patch which I think u missed.
>
> http://kerneltrap.org/mailarchive/git/2010/6/3/31711

What's the message-id?  There doesn't seem to be an easy way to get it out
of that web interface, so the above URL is no use for me, and I cannot see
the message in the context without its message-id.

Pointing at the site to casually refer to an old discussion is fine, but
please never refer to that site to refer to an old patch if you want me to
apply one.
