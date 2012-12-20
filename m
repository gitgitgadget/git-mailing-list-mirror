From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sys/param.h
Date: Wed, 19 Dec 2012 19:03:03 -0800
Message-ID: <7vip7x77dk.fsf@alter.siamese.dyndns.org>
References: <20121217213730.GA17212@ftbfs.org>
 <50D02B9A.1040906@viscovery.net> <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
 <CABPQNSZQk6hHm-dWqFFQf0HF34Mvbjc8-mgzCr=G0zbBKiYUvA@mail.gmail.com>
 <50D27CC6.3000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:03:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlWPw-0003QB-F6
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 04:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab2LTDDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 22:03:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab2LTDDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 22:03:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAFD5A721;
	Wed, 19 Dec 2012 22:03:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=swGloZ
	ZsP8tdUfglfED+WSdAdxpenV50QXNe2+yuSUlXddy1fFKs2BdZBQ3VJ1Ds7xf+m9
	Rqox8AyTennk08N6q2CkxguUjFWxfaotRlG2HcX0XwRKua7mhCORFCoS9WQefT7u
	LjIb/9wblPxdXsK6gIGou9BKFaANQFi5+3vLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eI9JX06Oh9IWlY4OOj09Lk/ier/hinML
	iPr38cC82OM6dQo/aeaPv01cX5vUum1Cc3omvyrzI5kzaGj/WCu144DAONdUwIpx
	EMiir61AbrlGpV3fUV6CG/9hWkGY2V3r7RWC3EIrFula0i7aTNQlAypBoIx+6Ijd
	jV+y29f6GsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9989A720;
	Wed, 19 Dec 2012 22:03:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C50AA71E; Wed, 19 Dec 2012
 22:03:05 -0500 (EST)
In-Reply-To: <50D27CC6.3000203@gmail.com> (Mark Levedahl's message of "Wed,
 19 Dec 2012 21:49:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C66E9498-4A51-11E2-9B42-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211872>

Thanks.
