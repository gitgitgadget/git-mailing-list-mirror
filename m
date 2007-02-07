From: Bill Lear <rael@zopyra.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 17:00:26 -0600
Message-ID: <17866.23050.937572.192253@lisa.zopyra.com>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvmp-0002X2-S3
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbXBGXBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXBGXBI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:01:08 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61747 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161466AbXBGXBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:01:07 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l17N0Rt08058;
	Wed, 7 Feb 2007 17:00:27 -0600
In-Reply-To: <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38993>

On Wednesday, February 7, 2007 at 14:49:50 (-0800) Linus Torvalds writes:
>...
>The "reflog" is kind of that, and you can literally do
>
>	less .git/logs/refs/heads/master
>
>to get some kind of idea what's up.
>
>Newer gits enable reflogs by default, older gits don't (and *really* old 
>git versions don't support it at all).

Ah, I don't seem to have .git/logs at all.

We plan to upgrade to 1.5 when it's out, so I guess we'll just
have to wait.


Bill
