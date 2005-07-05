From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Tue, 05 Jul 2005 07:04:51 -0600
Message-ID: <m1vf3p2yks.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
	<42C5714A.1020203@zytor.com>
	<m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
	<42C5C75F.4040100@zytor.com>
	<m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
	<42C5DA77.4030107@zytor.com>
	<m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com>
	<42C6D318.8050108@zytor.com>
	<m1k6k9drfk.fsf@ebiederm.dsl.xmission.com>
	<42C6D5AD.9070304@zytor.com>
	<m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com>
	<42C7043C.9080904@zytor.com>
	<Pine.LNX.4.58.0507021432370.8247@g5.osdl.org>
	<42C70A5B.9070606@zytor.com>
	<Pine.LNX.4.58.0507021501450.8247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 15:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpn8P-000143-Aw
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 15:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVGENG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 09:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGENG1
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 09:06:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16098 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261823AbVGENGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 09:06:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j65D4t40014356;
	Tue, 5 Jul 2005 07:04:55 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j65D4qYp014247;
	Tue, 5 Jul 2005 07:04:52 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021501450.8247@g5.osdl.org> (Linus
 Torvalds's message of "Sat, 2 Jul 2005 15:17:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> (And you might also change tag contents occasionally. One reason might be
> a bug and you decide to re-tag something else. But a more common reason
> might be because you want to have tags like "latest" that don't actually
> update with development, but they update with some other event, like a
> release event or some automated test cycle completion or something like
> that. So tags aren't _immutable_ even from an expectation standpoint, 
> it's just that they tend to change _less_).

Could you include the person who generated the tag and the time the
tag was generated in the tag object?

For a tag like "latest" it would help quite a bit if you could actually
find out which was the latest version of it :)

Eric
