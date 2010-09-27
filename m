From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Sun, 26 Sep 2010 21:58:31 -0700
Message-ID: <7vsk0v3hqg.fsf@alter.siamese.dyndns.org>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 06:58:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P05nY-0003q3-9L
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 06:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0I0E6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 00:58:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0I0E6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 00:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 859C3D934E;
	Mon, 27 Sep 2010 00:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBVaIV1x+w+04OJy5/PCw4ka1eE=; b=Xa2q7S
	hIzkEjuRCsC8s+Zxtz9X4Q3Yy7Pd0kmYbpL6LwFj1JCmG3FKnAmPuJDk7zmjdVzN
	3/LPP1sGfHdZz87AIeZ55H2o0LTaul2ZjL+n+vSAMnItDaia5cyJ867y/mvjtcJ3
	FLI340tL3V+jprCTGPJ7a17rfQeaPStw9xogo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VLHibYBaNDdGaZJq368vDfadnXd4LNwu
	wT/gcTphENeTT3OEBF8wo9bcyXWNUZyY7yAee4AaWAdNxJGbZ1CVcOvn7tSV5HXH
	N9Cec/h58dmgFRFomSy/WyKgcAQF3WFFiOyD1G9IGCYqXjb83gsBxO9ufKNvdoG1
	ZSQowPxEo9M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F7AD934D;
	Mon, 27 Sep 2010 00:58:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F299D934C; Mon, 27 Sep
 2010 00:58:33 -0400 (EDT)
In-Reply-To: <7viq266461.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 15 Sep 2010 15\:19\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2C42378-C9F3-11DF-A32D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157297>

Two regression fix patches for "stash" have been queued to 'maint', and
I'll push it out hopefully before I go to bed.

I have sifted 150+ patches to look at in my inbox since v1.7.3; hopefully
I can start applying them after 1.7.3.1 sometime in the middle of this
week.

Thanks.
