From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Thu, 17 Aug 2006 02:08:54 -0700
Message-ID: <7v1wrfu3tl.fsf@assigned-by-dhcp.cox.net>
References: <7vac67g5t5.fsf@assigned-by-dhcp.cox.net>
	<20060814075305.GH21963@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:09:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDds8-0000IT-1M
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWHQJI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWHQJI7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:08:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1977 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932361AbWHQJI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:08:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817090856.EDKY12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 05:08:56 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060814075305.GH21963@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 14 Aug 2006 10:53:05 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25560>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Quoting r. Junio C Hamano <junkio@cox.net>:
>> Are you by any chance running a version of git that has some
>> unofficial patches that affect the generation of not-for-merge
>> markers?
>
> No, I just reproduced this on plain 1.4.2.

Doesn't reproduce for me and I am getting worried.
Has anybody else seen this?
