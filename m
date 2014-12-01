From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 19:32:05 +0300
Message-ID: <87wq6bgwl6.fsf@osv.gnss.ru>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:32:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTtW-0004z1-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbaLAQcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:32:10 -0500
Received: from mail.javad.com ([54.86.164.124]:33788 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbaLAQcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:32:08 -0500
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id B7C156187A;
	Mon,  1 Dec 2014 16:32:07 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XvTtN-0006TR-Tz; Mon, 01 Dec 2014 19:32:05 +0300
In-Reply-To: <xmqqegsjqqox.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 08:29:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260491>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Hello,
>>
>> $ git help log | grep exit-code
>>            problems are found. Not compatible with --exit-code.
>> $
>>
>> What --exit-code does in "git log"?
>
> It doesn't.  That is why it is not listed.

Then, how can --check possibly interfer with it?

-- 
Sergey.
