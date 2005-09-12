From: Junio C Hamano <junkio@cox.net>
Subject: Re: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 16:55:19 -0700
Message-ID: <7voe6x6dug.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
	<7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
	<Pine.LNX.4.58.0509121519310.3266@g5.osdl.org>
	<7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121542050.3266@g5.osdl.org>
	<7vslw96f6j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121635060.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 13 01:56:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEy8y-0006X6-89
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 01:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVILXzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVILXzV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 19:55:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62130 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932222AbVILXzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 19:55:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912235519.WJG7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 19:55:19 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509121635060.3266@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 16:46:53 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8454>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 12 Sep 2005, Junio C Hamano wrote:
>> 
>> Yeah, let's see how tolerant your barf-o-meter is today.
>
> I'm not barfing, but that's probably because my brain just shut down and 
> is desperately trying to gouge my eyes out with a spoon.
>
> Wouldn't it be _much_ nicer to just do

Yes.
