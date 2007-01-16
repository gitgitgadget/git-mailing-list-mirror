From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-svn - username/password
Date: 15 Jan 2007 16:48:23 -0800
Message-ID: <86sleb23vs.fsf@blue.stonehenge.com>
References: <8664b73maf.fsf@blue.stonehenge.com>
	<20070116004137.GA10706@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 01:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6cV2-0005X5-6C
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 01:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbXAPAs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 19:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbXAPAsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 19:48:25 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:37510 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbXAPAsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 19:48:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 970D88D6D3;
	Mon, 15 Jan 2007 16:48:24 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17789-01-79; Mon, 15 Jan 2007 16:48:24 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2209D8D6D8; Mon, 15 Jan 2007 16:48:24 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
x-mayan-date: Long count = 12.19.13.17.13; tzolkin = 8 Ben; haab = 6 Muan
In-Reply-To: <20070116004137.GA10706@localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36905>

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> git-svn fetch --username <username> should work with recent-ish git-svn
Eric> (since around Thanksgiving); and eventually prompt you for the password
Eric> (just like svn does).

The prompts are broken... they're not being flushed properly.
Once I knew it was talking to me, and not just stalled, I could
type in the password at the right time.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
