From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,v2] git-bundle(1): add no references required simplest
 case
Date: Tue, 03 Feb 2009 18:07:47 -0800
Message-ID: <7vbptj9cp8.fsf@gitster.siamese.dyndns.org>
References: <7vab95r7j4.fsf@gitster.siamese.dyndns.org>
 <87y6wnnjvl.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: johannes.schindelin@gmx.de, mdl123@verizon.net,
	spearce@spearce.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Feb 04 03:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUXCh-0000hA-M8
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 03:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbZBDCH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 21:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZBDCH5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 21:07:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZBDCH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 21:07:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 72D0C2A614;
	Tue,  3 Feb 2009 21:07:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 413E22A637; Tue, 
 3 Feb 2009 21:07:49 -0500 (EST)
In-Reply-To: <87y6wnnjvl.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Wed, 04 Feb 2009 08:09:02 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2E2DBC6-F260-11DD-B7C4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108287>

jidanni@jidanni.org writes:

> Junio, could you combine your two recent versions,
> http://news.gmane.org/group/gmane.comp.version-control.git/thread=103575/force_load=t/focus=108030
> into a final one and commit it. No need to credit me. This is already
> way over my head.  Note however that the git clone example disappeared
> from your final version. Also perhaps give a simplest example of git
> pull. Indeed, much of your discussion is valuable and should be
> included on the man page. Whatever you commit is fine. I would just
> like to "close this bug" without having all the valuable documentation
> you wrote for it just go down the drain, which will certainly happen
> if I didn't send this message...

The former was shot down by Johannes and I agree with his reasoning, and
the latter is merely "something like" outline that is not good enough for
inclusion.  I personally do not consider there is a *bug* in the current
documentation so it is not much of my itch to scratch either.

Could you convince me that I should spend more time on that filling the
blanks in "something line" outline myself, instead of spending my git time
on some other areas, please?
