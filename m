From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (resend)] Fix typo in comment in builtin-add.c
Date: Wed, 10 Dec 2008 15:38:00 -0800
Message-ID: <7vk5a7y52f.fsf@gitster.siamese.dyndns.org>
References: <200812101910.mBAJAsF04710@localhost.localdomain>
 <1228948064-4006-1-git-send-email-aspotashev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss03@volumehost.net>,
	<git@vger.kernel.org>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYea-00040A-QR
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYLJXiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbYLJXiJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:38:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYLJXiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:38:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E04E18954;
	Wed, 10 Dec 2008 18:38:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 54FB518922; Wed,
 10 Dec 2008 18:38:01 -0500 (EST)
In-Reply-To: <1228948064-4006-1-git-send-email-aspotashev@gmail.com>
 (Alexander Potashev's message of "Thu, 11 Dec 2008 01:27:44 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98B23796-C713-11DD-9D23-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102741>

Alexander Potashev <aspotashev@gmail.com> writes:

> Reported-by: Tim Daly <daly@axiom-developer.org>
> Cc: Boyd Stephen Smith Jr. <bss03@volumehost.net>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: <git@vger.kernel.org>
> Signed-off-by: Alexander Potashev <aspotashev@gmail.com>

Eek.  Why so many Cc: here for such a trivial patch?

Will apply, thanks.
