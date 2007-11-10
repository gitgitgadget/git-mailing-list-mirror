From: David Brown <git@davidb.org>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 09:45:59 -0800
Message-ID: <20071110174559.GA2200@old.davidb.org>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 18:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IquPU-0003pk-23
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 18:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbXKJRqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 12:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXKJRqB
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 12:46:01 -0500
Received: from mail.davidb.org ([66.93.32.219]:41444 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbXKJRqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 12:46:00 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IquP9-0000b2-KT; Sat, 10 Nov 2007 09:45:59 -0800
Mail-Followup-To: bob <kranki@mac.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64361>

On Sat, Nov 10, 2007 at 12:40:16PM -0500, bob wrote:

> I am guessing that the "Bus error" is an Apple
> problem and it did produce a crashreport.  So,
> I am going to submit it to Apple since it is easily
> reproducible.

The crash report is probably not all that useful to Apple, since it occurs
in a program you have built.  Perhaps you should send the stack trace from
the crash report here and people might have some ideas about what might be
the problem.

David
