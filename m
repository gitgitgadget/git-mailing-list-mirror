From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The GitTogether
Date: Fri, 10 Aug 2012 09:30:53 -0700
Message-ID: <7vwr16k8ua.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com>
 <87k3xpe8bz.fsf@thomas.inf.ethz.ch> <50155CD9.6060702@web.de>
 <5016894C.7020907@drmicha.warpmail.net>
 <5023E77E.4020604@drmicha.warpmail.net>
 <CAC+LNEQB-B5L2CV2pONsOyD-VE4SW36c9SKxdOcYGBQbA-d4hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Patrick Renaud <prenaud76@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szs74-0003Jd-RH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab2HJQa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 12:30:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab2HJQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:30:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA22965F;
	Fri, 10 Aug 2012 12:30:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nIgDP0H6UZPq4LwDtv4i8/ghD6c=; b=mAIkkp
	MG4SCfa792NsMNTmikr38zyOtZeHUurBVhBRCsO96ccH99yQdQeSZ0oetcNP9c5V
	sKgk0Vpr6Rs6BkYzQyX0yiSGbgIkwI81Fd/5pl9aEiqR5l24ntdX5y7D+T6aJMf8
	n6UN9Q83p+AxWKEk7phk2cysDnjPEtSqJIPGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xM5bxJmxQV8vKLG6sJBgFTTiL7AbVXEX
	312S5nVN1K/IWnj4evVsHMTGy7Pe/3SBZXag9GY1ZGpysfJP5XdtKaRRG1zIw6I6
	v/n4gSnjKq58laNCADMWWCHqp1aCglUOGD6gRdKZGW+lBZNAvoDUx4I6YXshqvPN
	ZNnaLlALBsI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C344965E;
	Fri, 10 Aug 2012 12:30:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D715D965D; Fri, 10 Aug 2012
 12:30:55 -0400 (EDT)
In-Reply-To: <CAC+LNEQB-B5L2CV2pONsOyD-VE4SW36c9SKxdOcYGBQbA-d4hQ@mail.gmail.com> (Patrick
 Renaud's message of "Fri, 10 Aug 2012 10:42:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C26FF450-E308-11E1-9201-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203232>

Patrick Renaud <prenaud76@gmail.com> writes:

> I am not sure to understand why having two physically disconnected
> events, in time and in place. Personally I'd rather see one event,
> maybe longer than the previous occurrences to accommodate for the user
> and developer centric topics.

I think a separate event at a venue on different continent was
proposed primarily to avoid "annual GitTogether always at Mountain
View" that has been unfriendly to our European friends (mitigated
somewhat by having it immediately after GSoC mentor summit).  I
agree it may be a better solution to that issue to move the two
things to the same venue that moves from year to year.

The kernel folks have the (by invitation only) Kernel Summit
immediately before the wider end user conference at the same place,
which used to be always Ottawa but the venue moves around from year
to year these days.  That is something we could learn from them.
