From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Wed, 01 Jun 2005 16:05:55 -0700
Message-ID: <7v7jhdisoc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0506011742560.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 01:04:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdcF3-0005qu-Ao
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFAXGD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 19:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFAXGD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 19:06:03 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42670 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261356AbVFAXF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 19:05:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601230556.RVVO1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 19:05:56 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506011742560.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Wed, 1 Jun 2005 18:00:55 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> It shouldn't be hard to do one, except that locking with
DB> rsync is going to be a pain. I had a patch to make it work
DB> with the rpush/rpull pair, but I didn't get its dependancies
DB> in at the time. I can dust those patches off again if you
DB> want that functionality included.

Talking about pulls, wouldn't it be nicer to (re)name it to
git-ssh-pull, for consistency with others, especially before we
hit 1.0?


