From: Junio C Hamano <junkio@cox.net>
Subject: Re: contrib/ status
Date: Mon, 03 Jul 2006 14:04:25 -0700
Message-ID: <7vbqs6pfhi.fsf@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
	<200607030202.55919.jnareb@gmail.com>
	<7vodw7zgt2.fsf@assigned-by-dhcp.cox.net> <e89ock$gks$1@sea.gmane.org>
	<7vslljwiat.fsf@assigned-by-dhcp.cox.net>
	<7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net>
	<20060703080625.GB29036@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVao-0002F8-FG
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGCVE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWGCVE1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:04:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63707 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932124AbWGCVE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 17:04:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703210426.STM27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 17:04:26 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23210>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> > ... the
>> > things under contrib/ are not part of git.git but are there only
>> > for convenience....
>> 
>> This reminds me of something quite different.  I am getting an
>> impression that enough people have been helped by git-svn and it
>> might be a good idea to have it outside contrib/ area.
>
> That would be great.  IMHO, it puts git in a position to supplant
> centralized SVN usage one developer at a time, making it easier
> to make a gradual transition to git.  Of course, there's also svk
> in a similar position...

OK, then let's give a few days (it's a long weekend extendeding
into July 4th in the US) to let others from the list chime in,
and then please help me migrate your test scripts and Makefile
pieces into the toplevel project.
