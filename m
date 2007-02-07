From: Bill Lear <rael@zopyra.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 17:31:20 -0600
Message-ID: <17866.24904.961511.205102@lisa.zopyra.com>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
	<17866.23050.937572.192253@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071526290.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwGB-000624-V8
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161491AbXBGXb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbXBGXb3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:31:29 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61883 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161491AbXBGXb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:31:28 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l17NVLD11179;
	Wed, 7 Feb 2007 17:31:21 -0600
In-Reply-To: <Pine.LNX.4.64.0702071526290.8424@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39000>

On Wednesday, February 7, 2007 at 15:29:40 (-0800) Linus Torvalds writes:
>...
>Even with the git you have, you can probably just do a
>
>	git repo-config --global core.logallrefupdates true
>
>and you'll have reflogs enabled for all of your repositories (well, at 
>least the ones that share that home directory and thus ~/.gitconfig)

Ok, this is good to know, thank you.


Bill
