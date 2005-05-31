From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: I want to release a "git-1.0"
Date: 31 May 2005 07:45:33 -0600
Message-ID: <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 15:50:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd781-0002eu-4T
	for gcvg-git@gmane.org; Tue, 31 May 2005 15:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEaNwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEaNwb
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 09:52:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6310 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261760AbVEaNw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 09:52:29 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4VDkY9N032142;
	Tue, 31 May 2005 07:46:35 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.12.3/8.12.3/Debian-7.1) id j4VDjZGU032133;
	Tue, 31 May 2005 07:45:35 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, I'm at the point where I really think it's getting close to a 1.0, and
> make another tar-ball etc. I obviously feel that it's already way superior
> to CVS, but I also realize that somebody who is used to CVS may not 
> actually realize that very easily.

I way behind the power curve on learning git at this point but
one piece of the puzzle that CVS has that I don't believe git does
are multiple people committing to the same repository, especially
remotely.  I don't see that as a down side of git but it is a common
way people CVS so it is worth documenting.

Eric
