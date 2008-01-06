From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 06 Jan 2008 02:33:00 -0800
Message-ID: <7vir275jmr.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<449c10960801051321g785e45e3v8f7b129bb087e1ca@mail.gmail.com>
	<7v4pdr7jco.fsf@gitster.siamese.dyndns.org>
	<7vy7b364aw.fsf@gitster.siamese.dyndns.org>
	<449c10960801051908u38e87574i59ec314c3ddc775c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Tsugikazu Shibata" <tshibata@ab.jp.nec.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Jeff King" <peff@peff.net>, "Dmitry Potapov" <dpotapov@gmail.com>
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 11:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBSp4-0000yk-7j
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 11:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYAFKdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 05:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYAFKdO
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 05:33:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbYAFKdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 05:33:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FF609C96;
	Sun,  6 Jan 2008 05:33:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8671C9C95;
	Sun,  6 Jan 2008 05:33:02 -0500 (EST)
In-Reply-To: <449c10960801051908u38e87574i59ec314c3ddc775c@mail.gmail.com>
	(Dan McGee's message of "Sat, 5 Jan 2008 21:08:19 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69723>

"Dan McGee" <dpmcgee@gmail.com> writes:

>> Ah, I spoke too fast.  I think I need to first do a clean-up
>> patch to fix "gitlink::foobar[1]" that should have been spelled
>> as "gitlink:foobar[1]" in a few places, and your change is good.
>
> It looks like I still blew it and forgot the changes in asciidoc.conf
> in the second patch, sorry about that. Let me know if you need
> anything more,...

I think I got all of what you wanted to do now, although my tree
still is not in a shape I can push it out yet (I have to whip
other parts that does not have anything to do with this
documentation fix into shape first).

Thanks.
