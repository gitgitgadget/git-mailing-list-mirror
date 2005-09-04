From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: Could not interpret heads/dbrt-test as something to pull
Date: Sun, 04 Sep 2005 20:34:13 +0300
Message-ID: <87y86c3ffu.fsf@litku.valo.iki.fi>
References: <87psrp5gvp.fsf@litku.valo.iki.fi>
	<46a038f9050904030517f6ddda@mail.gmail.com>
	<87irxh5eea.fsf@litku.valo.iki.fi>
	<7v7jdwiwwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 19:35:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EByNp-0002h7-Bw
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 19:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVIDReS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVIDReS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 13:34:18 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:50037 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932079AbVIDReR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 13:34:17 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep32-app.kolumbus.fi
          with ESMTP
          id <20050904173413.JIGE13434.fep32-app.kolumbus.fi@litku.valo.iki.fi>;
          Sun, 4 Sep 2005 20:34:13 +0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdwiwwo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 04 Sep 2005 10:07:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8063>

Junio C Hamano <junkio@cox.net> writes:

>> Rsync works for me also. But HTTP is still broken.
>
> Sorry, a broken repo.  Fix made on master should percolate
> through soonish.

HTTP clone works now, thanks.

-- 
Kalle Valo
