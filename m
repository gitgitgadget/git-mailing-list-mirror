From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2012, #04; Fri, 13)
Date: Sat, 14 Jul 2012 13:00:04 -0700
Message-ID: <7vboji6rln.fsf@alter.siamese.dyndns.org>
References: <7vfw8v6wvl.fsf@alter.siamese.dyndns.org>
 <20120714141257.GA2553@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq8Vj-0000Mg-2W
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab2GNUAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 16:00:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2GNUAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 16:00:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189A46A3A;
	Sat, 14 Jul 2012 16:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=84FklHYhl+fiT+uVAJy5pmuwgd0=; b=D/LZfW
	+Jw61KJlTvtB2sFBFDlUY+IwPOib4HpRbXQZe/9NrZUh6UfJ9m+qAicjzIkoNDke
	facUkFiTs7uarws/kjRklQv4op8vhPWMOujiNv3Fpu4f8W6/CYBUUosOjf9t6F1n
	tM2d8g2aMLli7U0md8yNK/lNy71WPxLSxxpNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PcHvr1YC+dKNCT8bCe6ilSArEMJo9h/T
	8EH7u2+ciI/nIZZSH8Cs7wad5qDzQoVuL5eNtc0VkV3v77WXWfxwh+FpUEnQaRA8
	e11ngbGtQ4D0z2RyAEdYjr/wlcLIMq69XMyhAWjF7wP63EgrlScUUHJJskNdaJAO
	26bFNun5PDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 028B76A39;
	Sat, 14 Jul 2012 16:00:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F18646A38; Sat, 14 Jul 2012
 16:00:05 -0400 (EDT)
In-Reply-To: <20120714141257.GA2553@akuma> (Alexander Strasser's message of
 "Sat, 14 Jul 2012 16:12:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81B6AB54-CDEE-11E1-A8A7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201451>

Alexander Strasser <eclipse7@gmx.net> writes:

>   As the whole series is not that important I think it should be OK to
> wait a little longer, isn't it?

I thought the series queued in 'pu' was more or less done from my
point of view, but wanted to know if you wanted to polish it
further, as I prefer waiting for perfection in such a case.

At the same time I do not want to wear the contributors out by
unnecessary rerolls, so I was asking how you and others feel about
the doneness of the series.

Will wait updated patches from you.  Thanks.
