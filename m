From: "Steven E. Harris" <seh@panix.com>
Subject: Re: git rebase --interactive commits order
Date: Mon, 09 May 2011 19:31:20 -0400
Organization: SEH Labs
Message-ID: <m2d3jr1mev.fsf@Spindle.sehlabs.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
	<BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 01:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZvO-00064F-Fm
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab1EIXbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:31:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:43562 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765Ab1EIXbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:31:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QJZvI-00062I-4N
	for git@vger.kernel.org; Tue, 10 May 2011 01:31:32 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2011 01:31:32 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2011 01:31:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (darwin)
Cancel-Lock: sha1:DN9lqxJgwfLl09p5FH9R0CoAPfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173289>

David <bouncingcats@gmail.com> writes:

> I find I have to do a mental double check before every such operation.

I don't think I've /ever/ run "rebase -i" and gotten the order correct
on the first try. I have to note the oldest commit I expect to see, hunt
around for it in the list, orient myself to the sequence, then try to
rearrange things. Usually the rearrangement still winds up being in the
wrong order.

-- 
Steven E. Harris
