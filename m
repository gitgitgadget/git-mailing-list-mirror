From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] t/README: Document test_external*
Date: Thu, 01 Jul 2010 09:38:58 -0700
Message-ID: <7vsk432m3h.fsf@alter.siamese.dyndns.org>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
 <1277997004-29504-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 18:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMnA-0004RI-0K
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 18:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab0GAQjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 12:39:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0GAQjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 12:39:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A284C07D0;
	Thu,  1 Jul 2010 12:39:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sE3mnO7g1/un/e6feKtqOMPaiIc=; b=A12IaL
	sFzOfwZB9WPQjmOONBeG70Au7ob06ijDVWR08xpJVIkMLDdqU0lh8Pa3s6fbQquB
	Oyrd+BOXr+Mv+AKJd6NJt3H0X/O8ikkr+eRA9uRB9zHxDHYehAfROs9bIphJzjxp
	xaHtPIvW3fRVK0aXFBRhgWN/BxlN7Kn2DofAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=urj9jXiixQ+oyZ0vQGLEbBQDz3plBFIf
	8RvIVo0+TuV+SvyD82ngapafUNQVY0EKlubEY1KbOh6oK+0YWzJoh8cNVMtRaIOA
	ZX1VlX9qPQdD3zjKKjfqM8bUBwW+GB1vqh+/ETIiYVaVfaK99dmCh7xml/a0K8E8
	TWQn8oDXQ7w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8743C07CE;
	Thu,  1 Jul 2010 12:39:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B358C07CC; Thu,  1 Jul
 2010 12:39:00 -0400 (EDT)
In-Reply-To: <1277997004-29504-6-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\,  1 Jul
 2010 15\:10\:01 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2839B800-852F-11DF-9FEB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150056>

Thanks.  We should have done this one long time ago, too.
