From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Tue, 05 Jul 2005 11:51:25 -0600
Message-ID: <m1br5hywde.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 19:53:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DprbX-0004MI-CH
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 19:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGERwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 13:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGERwy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 13:52:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35814 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261915AbVGERwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 13:52:45 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j65HpSdv016438;
	Tue, 5 Jul 2005 11:51:28 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j65HpPwm016437;
	Tue, 5 Jul 2005 11:51:25 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 5 Jul 2005 12:21:09 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Jul 2005, Eric W. Biederman wrote:
>
>> Could you include the person who generated the tag and the time the
>> tag was generated in the tag object?
>> 
>> For a tag like "latest" it would help quite a bit if you could actually
>> find out which was the latest version of it :)
>
> The fact that lots of tags get refs named with their contents is just due
> to tags only getting used for a small portion of their possible uses. This
> only happens when the feature you'd look something up under is a feature
> which is persistent.

True but if you can you will get multiple tags with the
same suggested name.  So you need so way to find the one you
care about.

Either a date or it's position in the tree, are all you have
to go on.

I picked on latest as that is an extreme example that had already
been mentioned.

Eric
