From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (Jun 2014, #02; Fri, 6)
Date: Sat, 07 Jun 2014 09:10:16 +0200
Message-ID: <87ha3xtctj.fsf@fencepost.gnu.org>
References: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 09:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtAm9-0005ol-5m
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 09:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaFGHKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 03:10:44 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:35928 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaFGHKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 03:10:44 -0400
Received: from localhost ([127.0.0.1]:34970 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WtAm2-0007OM-GQ; Sat, 07 Jun 2014 03:10:42 -0400
Received: by lola (Postfix, from userid 1000)
	id 03320E050F; Sat,  7 Jun 2014 09:10:16 +0200 (CEST)
In-Reply-To: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Jun 2014 15:42:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251031>

Junio C Hamano <gitster@pobox.com> writes:

>  "git blame" has been optimized greatly by reorganising the data
>  structure that is used to keep track of the work to be done, thanks
>  to David Karstrup <dak@gnu.org>.

I guess that "reorganising the data structure" for months is not worth
the trouble of getting the name right.

At any rate, as promised I'll post a list of remaining low-hanging fruit
in the next days for somebody else to get praised for, and then I'm out.

-- 
David Kastrup
