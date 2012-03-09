From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to patch git documentation
Date: Thu, 08 Mar 2012 18:43:05 -0800
Message-ID: <7v1up2bikm.fsf@alter.siamese.dyndns.org>
References: <jjbqe9$8l3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 03:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5pnW-0004D2-TF
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 03:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab2CICnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 21:43:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab2CICnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 21:43:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D8317A26;
	Thu,  8 Mar 2012 21:43:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B82c7GmQ8H1OvrAK6UUAVRdqSQU=; b=ZxntfH
	j9zzZIUzEhI5IYHNrvi1xeIhf0YQYUWW9gWHZLAMC58t6RYgP1T2PlA9I/rF6AV3
	PSTk/zXFiCTOTGPIL6TvY8Cnox41EapqnYDLiCh4tlSZzFZX4y1KqrAB6t+qfV6J
	reRjs3DZcJZRshqlYpZS1re+f3hP9ks9Txvpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpD1+Tq2OPb/xFszDNGiNq03XPFJ8NUQ
	HGDwzGUlHID3tC6/n+W+p73KclvB58ka4uU0NpOxoKRnQHtIVKKRZIrpTD+mYuU3
	1gJQr722CPN2G0sWgvxuf/auoHaBSlUzBfoHmThKm+G/mGJW8xIEcuhTerv0I0lq
	e775YMyb0Lc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150DC7A24;
	Thu,  8 Mar 2012 21:43:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EA4E7A23; Thu,  8 Mar 2012
 21:43:06 -0500 (EST)
In-Reply-To: <jjbqe9$8l3$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Thu, 08 Mar 2012 20:38:01 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99A323B2-6991-11E1-BD34-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192672>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> What language are the git documentation *.txt files written in?

Mixture of Pidgin English and a bit of AsciiDoc ;-).
