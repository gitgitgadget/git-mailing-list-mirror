From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Mon, 28 Apr 2014 21:57:19 +0200
Message-ID: <87ha5d4480.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
	<87zjj86j4a.fsf@fencepost.gnu.org>
	<xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com>
	<87y4yp4ame.fsf@fencepost.gnu.org>
	<xmqq38gxqmc9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WergE-0004Xb-8J
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbaD1T5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:57:24 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:42177 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaD1T5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:57:20 -0400
Received: from localhost ([127.0.0.1]:41219 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Werg0-0008UY-3y; Mon, 28 Apr 2014 15:57:20 -0400
Received: by lola (Postfix, from userid 1000)
	id 96FE6E05FE; Mon, 28 Apr 2014 21:57:19 +0200 (CEST)
In-Reply-To: <xmqq38gxqmc9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 12:35:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247430>

Junio C Hamano <gitster@pobox.com> writes:

> I guess we probably can add "See $URL if you are interested in his
> further plans" after that two-line item and let you write whatever
> you want at that page pointed at by the URL, though.

I most definitely am _not_ planning to invest any more time into Git
since even designing such plans would be throwing good time after bad
time.  And I don't have a web presence anyway.  As it does not appear
that there is any realistic manner in which Git users could even be made
aware of a connection between monetary requirements and work for a
freelancer like myself, I'll be just writing this off as a one-time
mistake on my part given my personal situation.  It's not the first, and
it will certainly not be the last, but at least I can avoid doing the
same mistake twice on the same project.

There are some low-hanging fruit for further speeding up git-blame now
that its internal thrashing has been addressed.  I will point out those
low-hanging fruit so that anybody can follow up on it and do all the
arguing and benchmarking required to go anywhere and get the credit for
it.

But that's as far as my willingness to "do the right thing" will carry.
If nobody picks up either the tab or the rather simple followup tasks,
then that's what the community and customer base of Git is capable of
sustaining and I'm not in a position to change it.

-- 
David Kastrup
