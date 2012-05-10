From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 09:55:17 -0700
Message-ID: <7vzk9gm0wa.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWeE-0006Wd-RX
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab2EJQzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:55:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2EJQzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:55:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69BB808C;
	Thu, 10 May 2012 12:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4s/H+jvB9cf2fv21E+W/Kep+soA=; b=XaatWL
	h2WUPdCpR5K0ZbLcpjrcJHW7z8iMYIanvB0Sk32fmeaT/jIxzlXq88ooeZ6U3iht
	0+gW8F0yCi1ritAp1Uf+vPAepLK70gO8ohdgWrvyoqaDOUW3++z/+U/DXOtkgT7f
	/15pG3co64v4IuSKT3PHVr3SiGStpjd8cnE9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOIk5Z+WpcP1gJiQNB9ZSjTlcTNFN4KC
	CxsXnEW/1zCDygSP49pdevD25lB12dMCo/1lYrWlui6bMSixDTIWL/oL7Ir2aTgK
	r8OBZVo7oHsqjyg5fIofwfC+oPy5vd1iYt8mea0MCCChT61J/WAfG98m6a/+VRwg
	Q33DK7rzp2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC43808B;
	Thu, 10 May 2012 12:55:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE0C8088; Thu, 10 May 2012
 12:55:19 -0400 (EDT)
In-Reply-To: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
 (Philippe Vaucher's message of "Thu, 10 May 2012 18:45:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC93AC12-9AC0-11E1-8187-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197601>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> Here's a patch removing the weird bits. I spoke about in my previous message.

What's weird about them?  They are real messages issued exactly when they
are described to be issued.
