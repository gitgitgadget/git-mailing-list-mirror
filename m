From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Thu, 26 Nov 2009 18:38:55 -0800
Message-ID: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
 <20091118142320.GA1220@coredump.intra.peff.net>
 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
 <36ca99e90911260405y42a9a07cx419d2973ec673039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 03:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDqjp-0004Zp-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 03:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZK0CjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 21:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZK0CjA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 21:39:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZK0CjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 21:39:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0D05A10F8;
	Thu, 26 Nov 2009 21:39:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dNtloJM2QtQAl9xxzzGjqtT7H3E=; b=UA5NnxboBXFwBbMTT79u6yt
	s0SikXNqDi9i7lJwudPUE60Rqhal1MnP8BYHgh4Rg6FLpCduMwIgf1RconpyiKLh
	A31I/q2RqRBIiVB0mfv5Q0lDs+c6mj6If8wi+EOd/x6edgiz3NeunWd2LqHuPGCD
	rVoF7mR319afPUzqd/YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kquYEml4D6c2ijd7+wBPVo44UoF8UgDhVPftdIXBASTsNORZ+
	3/MiLyv3pa050kkgKPOb+sDZkJcrReLeHzi4Xwp8Sjw1vJzuLf8U4g9g9IMgaS/0
	NXr1zkEXzcw3dEy/p/V77VjHgiZeycQeC6Gg7UFYUpTwVR2bsZt+YibvJk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD006A10F7;
	Thu, 26 Nov 2009 21:39:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17216A10F6; Thu, 26 Nov 2009
 21:38:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0580C258-DAFE-11DE-9346-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133853>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> may I kindly remind you of this patch.

Yes you may ;-)  A more effective would have been a resend but it is
always appreciated.

> ... If it is only the nen-existing
> consensus of the default color, than please use the die.

If you are having me go find the mail and apply I would probably use
"plain" as I suggested.
