From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: Could not interpret heads/dbrt-test as something to pull
Date: Sun, 04 Sep 2005 13:13:49 +0300
Message-ID: <87irxh5eea.fsf@litku.valo.iki.fi>
References: <87psrp5gvp.fsf@litku.valo.iki.fi>
	<46a038f9050904030517f6ddda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 12:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBrVh-0007WA-Jx
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 12:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVIDKNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 06:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVIDKNx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 06:13:53 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:13979 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751337AbVIDKNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 06:13:52 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep32-app.kolumbus.fi
          with ESMTP
          id <20050904101350.HGJC13434.fep32-app.kolumbus.fi@litku.valo.iki.fi>;
          Sun, 4 Sep 2005 13:13:50 +0300
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f9050904030517f6ddda@mail.gmail.com> (Martin Langhoff's
	message of "Sun, 4 Sep 2005 22:05:51 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8055>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> error: Couldn't get http://www.kernel.org/pub/scm/git/git.git/refs/heads/dbrt-test for heads/dbrt-test
>
> Tried to repro, but takes ageson my puny cablemodem. Cloning via rsync
> seems to work well though.

Rsync works for me also. But HTTP is still broken.

-- 
Kalle Valo
