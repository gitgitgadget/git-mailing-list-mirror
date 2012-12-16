From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove misleading date form api-index-skel.txt
Date: Sun, 16 Dec 2012 11:59:14 -0800
Message-ID: <7v1ueprcod.fsf@alter.siamese.dyndns.org>
References: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net>
 <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net>
 <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
 <38388978.118261.1355647369577.JavaMail.ngmail@webmail21.arcor-online.net>
 <m2ip828jtx.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkKND-0006x1-8L
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab2LPT7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:59:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2LPT7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:59:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 371A3ADEC;
	Sun, 16 Dec 2012 14:59:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YLs2ZcWJbz+Wud6jkmBouRqVRSQ=; b=bYAmny
	z2mtlREAmL1zBsaP7bPxxQrML5hDS3tTnD4AXibcRTHdNZ42kKD7II+P5aGRTw/v
	UEvCwtCtfXmwDSQf20gVYZrid+rAhhwl0ziiWh5Sx3LK6ytxE+0XlXh/gCOu5X+Q
	4AeL/jsRNIFQ6rFIZIXP37XxcwajSCDVm+7l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PqL5ETtWIsEVVMn1G27VWiFiyw6F7bGd
	Py5P5R/di75ZOQkxVGihbPkwnDz3OqcWHJ3emgBFvukrCi0Ylo7oNsOOWQT0XzWu
	UrVynJ/tnoSEa4xlE6x0YE+LNyW3WPiI8wW+7yqltE58Ja//53k0eUidxMVRxXPn
	WPYK9JwlQU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 023B1ADE7;
	Sun, 16 Dec 2012 14:59:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 424F1ADE5; Sun, 16 Dec 2012
 14:59:16 -0500 (EST)
In-Reply-To: <m2ip828jtx.fsf@linux-m68k.org> (Andreas Schwab's message of
 "Sun, 16 Dec 2012 09:47:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12B48BC6-47BB-11E2-9C97-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211611>

Andreas Schwab <schwab@linux-m68k.org> writes:

> s/form/from/
>
> Andreas.

Thanks; will apply.
