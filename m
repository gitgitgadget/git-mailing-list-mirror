From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git push -q
Date: Sun, 18 Oct 2009 22:58:45 -0700
Message-ID: <7vtyxv7wmi.fsf@alter.siamese.dyndns.org>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlH7-00052U-5x
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbZJSF65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 01:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbZJSF64
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:58:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZJSF6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:58:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C8F17D539;
	Mon, 19 Oct 2009 01:58:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RuN9xTKDvBjIK4Wvx6hQWnF6z9Q=; b=fn0oQqSy+ytGVKOG3u9iXCD
	2ZjUevF8Rkwph8r+mfqKZMF+UbB2JpBw+ZkL32msWPOS7VbAx+bAcOXBuMyeDO+o
	XbWDWJ5IWIx9inJLWNXQWYwXpY8HZc/m+liyms/tFcFfV2weGx85ra0t4dGdOOwr
	7d7FtSxXUaoa4SSfgjl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZeMV8mj1TSHB/hMqi+/k4lPtn4SWtjKqSVjcrmcbaEEkP6H2A
	GWLPUXullKt0Bxz+I16tIKOC7eIQOxBlBgf/WjqeB/L4xTbFaC0wLLfFLE+4BR4b
	C3yzQGrBx9fLyKwxv8xOoRZTrlfEyuJtgm68xY6Wt8XAR/oLt0EMnXm1uk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 282307D538;
	Mon, 19 Oct 2009 01:58:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8500B7D537; Mon, 19 Oct 2009
 01:58:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B75B822-BC74-11DE-BB00-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130655>

Thanks; applied.
