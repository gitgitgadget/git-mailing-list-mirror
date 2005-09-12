From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 13:47:26 -0700
Message-ID: <7vr7bu9foh.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
	<4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:48:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvD8-0007t3-Ou
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVILUr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVILUr2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:47:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29315 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932227AbVILUr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 16:47:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912204725.CKSG11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 16:47:25 -0400
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4325AED6.8050401@citi.umich.edu> (Chuck Lever's message of "Mon,
	12 Sep 2005 12:37:42 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8426>

Chuck Lever <cel@citi.umich.edu> writes:

>> The sentence "This patch series is against the "proposed updates"
>> branch, as of a couple of days ago." should have also included a
>> commit ID. That way we would know where/when the patches would apply
>> cleanly for testing and dissection.
>
> i'm a dork.
>
> 6ae3d6e6d0f87cfa75b4bf213a485ff687defce8
>
> i will include the base ref in my future postings.

No need for any of that.  All the necessary bits are already in
the "master" branch.
