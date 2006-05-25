From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 17:19:29 -0700
Message-ID: <7virnv3qi6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
	<7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241631340.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 02:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj3Zl-00030D-9E
	for gcvg-git@gmane.org; Thu, 25 May 2006 02:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWEYATb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 20:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEYATb
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 20:19:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37000 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932336AbWEYATa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 20:19:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525001929.IMGX19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 20:19:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605241631340.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 May 2006 16:35:18 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20713>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 24 May 2006, Junio C Hamano wrote:
>>
>> It was very pleasant to read the changes that way, especially around 
>> write_sha1_to_fd() vs repack_object().  xxdiff is my new friend.
>
> I think "kompare" (the KDE diff tool) is nicer.

I'd love to give it a whirl, but aptitude says it will consume
73.5MB diskspace to install it, with download size 22.4MB, which
makes me go ... hmmmm (my machines are currently KDE free so the
above counts slurping in the kdelibs essentials).  
