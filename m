From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [git wiki PATCH] Teaching "--3way" to "git apply"
Date: Mon, 5 Mar 2012 09:05:54 +0100
Message-ID: <87vcmjxyjh.fsf@thomas.inf.ethz.ch>
References: <20120302091114.GA3984@sigill.intra.peff.net>
	<7vbooc6isi.fsf@alter.siamese.dyndns.org>
	<20120305053343.GA25373@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Svm-0007MV-DI
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 09:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab2CEIF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 03:05:59 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:3468 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044Ab2CEIF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 03:05:59 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 09:05:56 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 09:05:56 +0100
In-Reply-To: <20120305053343.GA25373@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 5 Mar 2012 00:33:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192214>

Jeff King <peff@peff.net> writes:

> I don't think there is any commitment to mentor, or for us to even do a
> project that is on the list. The intent of the idea list is to get
> students thinking about their proposals, and hopefully discussing and
> exploring the ideas with us on the list. It is only when it comes time
> to read and rank student proposals that we make a commitment to an idea.
>
>> But I think I should mention this, as it is a reasonable bite-size task
>> for a student project that is to be completed inside one release cycle.
>
> I actually think it may be a little bit too small for a whole summer
> project. But I pushed it to the wiki for the reasons above; this is just
> an ideas page, not a solid list of proposals.

Perhaps we should spell this out in the leading text?  I was going to
send a patch, but got stuck rewording at

  Note that these are ideas, not project proposals.  As stated, they may
  not be of the right difficulty or size to be solved within one Summer
  of Code.

Maybe you can find a nicer way to write the "as stated" (I want it to
say "in the form they currently have") and put that before the first
title.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
