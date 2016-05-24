From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signing off, for now
Date: Tue, 24 May 2016 12:42:06 -0700
Message-ID: <xmqqd1ob450x.fsf@gitster.mtv.corp.google.com>
References: <1464117750.24478.104.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>,
	Keith McGuigan <kamggg@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 24 21:42:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5IDX-0007cJ-EI
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbcEXTmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:42:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbcEXTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:42:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78A5F1ED86;
	Tue, 24 May 2016 15:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nqVba8kPX0pi6mRaQff4VzPACIY=; b=iJCcFE
	8isLy21mQr1++NTzM6oP+/NxMwybhV8/QFzN+oS4sM03cATU4CMKXDAQwwrgwQJJ
	Z1sD2S76HTzyAnrf6jo/B8Z+NMcFOxfEyrny4Vl2uOIAlPu8ocwUAeR0l6Cz7MCE
	tvA9WOKNVJymD/s+qbx0yzm1zMAkArDgHKZTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvbHFE/9PXC9OcOzCIzTiDyf6ye/N+L+
	5Rvf2rQGhyPpsEExrYav9ku3ga4Zs4sFoPkZlYejqhi85UeugLhVl3BI4CerOF3/
	F2BHBpAuWyw21JeorRYMubqHE7ePnASq9H0T6Ckp1uJerX6eqjUif6BpOKSC5eNJ
	faEuf/hPMas=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7006E1ED83;
	Tue, 24 May 2016 15:42:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3CE01ED7C;
	Tue, 24 May 2016 15:42:07 -0400 (EDT)
In-Reply-To: <1464117750.24478.104.camel@twopensource.com> (David Turner's
	message of "Tue, 24 May 2016 15:22:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9998C58A-21E7-11E6-86BC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295527>

David Turner <dturner@twopensource.com> writes:

> June 3rd will be my last day at Twitter.  I hope that my new job
> (starting in July after a month of vacation) will give me time to work
> on Git, but I don't know exactly what parts I'll be working on, or on
> what schedule.

Thanks for your contributions so far, not just patches but also
discussions and helping other contributors.

Good luck with your new endevour, have fun and hopefully we'll see
you here again.
