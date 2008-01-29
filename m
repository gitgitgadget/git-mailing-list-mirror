From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in core.excludesfile
Date: Tue, 29 Jan 2008 14:59:42 +0900
Message-ID: <buo7ihtcgtt.fsf@dhapc248.dev.necel.com>
References: <y7a9aaem.fsf@blue.sea.net> <m3y7a98ttg.fsf@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjWf-000481-5T
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 07:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbYA2GAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 01:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYA2GAA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 01:00:00 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:38467 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYA2F77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 00:59:59 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m0T5xhDH019844;
	Tue, 29 Jan 2008 14:59:43 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Tue, 29 Jan 2008 14:59:43 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Tue, 29 Jan 2008 14:59:43 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id B7F5F4B; Tue, 29 Jan 2008 14:59:42 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <m3y7a98ttg.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Mon, 28 Jan 2008 14:32:51 -0800 (PST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71951>

Jakub Narebski <jnareb@gmail.com> writes:
> First, git project does NOT use GNU ChangeLog convention for it's
> commit messages.  We rather use descriptive commit messages.

Not that what Jari wrote had much resemblance to GNU ChangeLog format...

-Miles

-- 
Opposition, n. In politics the party that prevents the Goverment from running
amok by hamstringing it.
