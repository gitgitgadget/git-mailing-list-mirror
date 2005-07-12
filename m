From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Tue, 12 Jul 2005 11:14:59 -0600
Message-ID: <m1vf3gymi4.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<20050711210309.GT5324@shell0.pdx.osdl.net>
	<m1zmssyq0r.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507120959550.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:17:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsOMk-0005gv-29
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 19:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVGLRP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 13:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVGLRPv
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 13:15:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19356 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261704AbVGLRPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 13:15:19 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6CHF0m4001098;
	Tue, 12 Jul 2005 11:15:00 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6CHExSB001093;
	Tue, 12 Jul 2005 11:14:59 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507120959550.17536@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 12 Jul 2005 10:01:51 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ahh. Dang, I should have remembered this. We should call the rpm 
> "git-core-0.99", not just "git-0.99".
>
> Chris, I assume this is just changing the name in the spec-file from "git" 
> to "git-core"?

The name of the tarball needs to be updated as well.

Eric
