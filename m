From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Release notes link problem
Date: Fri, 30 Sep 2011 23:58:41 -0700
Message-ID: <7vlit5mc4e.fsf@alter.siamese.dyndns.org>
References: <CAPZPVFbWtDM5T3ZPFMc_MH4aSsfoLyVoGrGm2FeO0TOdhLrz2g@mail.gmail.com>
 <CAPZPVFY9O2VC7TS9ASReD5LYiqfDwLY5M2vxE97M+7BsYvAoqg@mail.gmail.com>
 <20111001061004.GA25700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 08:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9tX7-0005NM-JR
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 08:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab1JAG6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 02:58:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab1JAG6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 02:58:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C24B44E7B;
	Sat,  1 Oct 2011 02:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0NxuTsdCFT3EuNdcfOpACzKaXUU=; b=j6Mkov
	yuGw0IyJyTcmBqxjx3m8f8aHU/OmenPVYX73FGYLC5wq6NqnwoXQ3kBORaAu94+d
	xONKXQ8/dlfChbx2lJxi8l0qIm2SZxcpr0zP8QWste9tsW3INmWK33UWFTrmtatP
	CxDxeCtAlI1y+5a7EAoJxHRl0wbUHLC1L1rjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YFWSejTepVyJkW/qal1cJ1aIKAMKUNEZ
	elxP8MMOTcHvgeilAyZ3X8S4BOFkuJRuTVjl2JWYowtx56T26L5D6yGFQl6Hfpvm
	kfapxKlS+kwgZQ0bxgvM037a/5SI1TXxV4SCTImcmLj/F1Sy2NOEJpInUY/u6Xse
	SOhT5M41I2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B97B24E79;
	Sat,  1 Oct 2011 02:58:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FDA84E78; Sat,  1 Oct 2011
 02:58:43 -0400 (EDT)
In-Reply-To: <20111001061004.GA25700@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 1 Oct 2011 02:10:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCE07B54-EBFA-11E0-8FB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182542>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 30, 2011 at 05:06:50PM -0400, Eugene Sajine wrote:
>
>> The release notes link on http://git-scm.com/ is pointing to a page
>> which doesn't seem to exist. I'm getting error 404 when trying to
>> access it. Does anybody see the same issue?
>> 
>> the link is
>> https://raw.github.com/gitster/git/master/Documentation/RelNotes/1.7.6.4.txt
>
> This was due to some breakage on github this afternoon, but I believe it
> has since been fixed.

I guess the link should be

  https://raw.github.com/git/git/master/Documentation/RelNotes/1.7.7.txt

instead ;-).
