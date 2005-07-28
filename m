From: Darrin Thompson <darrint@progeny.com>
Subject: Tutorial problem a/a a/b
Date: Thu, 28 Jul 2005 15:20:05 -0500
Message-ID: <1122582005.12374.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 28 22:59:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyFSl-0007o8-Kw
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 22:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVG1UYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVG1UWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 16:22:16 -0400
Received: from zealot.progeny.com ([216.37.46.162]:62125 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261703AbVG1UUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 16:20:10 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP id B8F67636A4
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 15:20:05 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In the tutorial the user is instructed to create two files: a and b.

Then when the user diffs the files, they see this:

diff --git a/a b/a

That really confused somebody and I had to untangle their brain. :-) I
don't have a patch for it, but thought I'd point out: perhaps a and b
aren't the best example filenames given git's diff format. :-D

--
Darrin
