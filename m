From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Thu, 24 Jan 2013 10:11:24 -0800
Message-ID: <7v622mcuyb.fsf@alter.siamese.dyndns.org>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru>
 <7v1uvb6mn9.fsf@alter.siamese.dyndns.org> <20110921001925.03a83d3a@zappedws>
 <20130124143816.7c33fc1c@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyRHB-0004Ku-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 19:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab3AXSL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 13:11:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab3AXSL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 13:11:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C94CC97;
	Thu, 24 Jan 2013 13:11:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TV+77sxbBx0YLOj1vvxOZis1W3w=; b=mgKvqc
	hLxoQzNrbdcd2NiuqHKG/bMEjcVPZGZqo81Y+5epq6BbcbI4Y1K0A8MHraJWTplZ
	akqiabazMfB/G4aeKaYSc1s+95VJ2FJpCtXcoIJx/F+uCygROHkdXJ2cp06rVB5F
	KmC50u3+HZ3+43uR5LdVr9QWi6Pry7Nqoe6zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xL1BPVpwG9bf2cruIrJFgEoaQTUW8vHJ
	VdYkmUpHEG3Gh0PJcVzS2kjBxcz2O7OhM6z1S5gY1bPraYzGwDwMYxWiS0XtjGpl
	eTWPcd5V3WKvttfsuISGSscwgDm+fLdtF3r8BP05ATYT8sQaPwj9Nqms7qclVS89
	dfcYmTkQ6HA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC02CC96;
	Thu, 24 Jan 2013 13:11:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D4DECC95; Thu, 24 Jan 2013
 13:11:26 -0500 (EST)
In-Reply-To: <20130124143816.7c33fc1c@ashu.dyn1.rarus.ru> (Alexey Shumkin's
 message of "Thu, 24 Jan 2013 14:38:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77DD320A-6651-11E2-8167-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214436>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Bump

Bump what???
