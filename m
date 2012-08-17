From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] contrib: add win32 credential-helper
Date: Fri, 17 Aug 2012 10:19:16 -0700
Message-ID: <7vwr0xv3l7.fsf@alter.siamese.dyndns.org>
References: <1343409006-5056-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSZt0a+447qbr6j9ELHfsmfr03VUw6-efAiu0vLicaKyEg@mail.gmail.com>
 <7vtxw2w5s4.fsf@alter.siamese.dyndns.org>
 <CABPQNSaBK=nyyW2bibTkQKFaihiyd8k_MHeUJRiBhA6tZ-XnFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 17 19:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QCk-0004y2-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab2HQRTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab2HQRTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:19:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796807320;
	Fri, 17 Aug 2012 13:19:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0IQO0L8LMUeDd4XT6/9jtnIVok0=; b=kUpZ9k
	yO0pzo/VZHPXZDnagSCjFO11hxT+vY1RUb5wZbC/2MiWmh6h7GQUWFJcvnPfxswT
	LOoHUGETTSok2D1WLv5DyWq1cltCIG5g3qvl5G4LOWgSrVHs29jrNCvnN9RZRhdn
	CIT/nC4g2+B3Yrs1xY1359x2THdShX4FUTkdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p6upNmh6vT+RYjR38zv/TIZzx+RQTBC8
	INfU1TNdxNiokSfuLTGTFdxOgP3jsu6pjO9ZFThWgc9RZEXAAtxccMJMLaeo4sBs
	enrCEfRzP89pfkLKIWvbHD9dsnZMADMcyKQQPdbsvoi171HRqXG+45oi9wsIHe48
	0/KS+h93O5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65754731F;
	Fri, 17 Aug 2012 13:19:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7287731E; Fri, 17 Aug 2012
 13:19:17 -0400 (EDT)
In-Reply-To: <CABPQNSaBK=nyyW2bibTkQKFaihiyd8k_MHeUJRiBhA6tZ-XnFw@mail.gmail.com> (Erik
 Faye-Lund's message of "Fri, 17 Aug 2012 13:50:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD09CFAA-E88F-11E1-A2CC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203626>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> As far as I'm concerned, I consider this complete from my point of
> view. Should I send out a new version with the fixup squashed in?

I've already queued them as one commit.  Thanks.
