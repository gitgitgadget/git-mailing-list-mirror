From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: SHA1 hash safety
Date: Tue, 19 Apr 2005 18:48:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504191848300.29929@cag.csail.mit.edu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
 <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
 <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
 <4261852B.6090507@khandalf.com> <20050418074323.GA29765@hexapodia.org>
 <20050419223027.GA26100@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Isaacson <adi@hexapodia.org>, omb@bluewin.ch,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:45:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1TT-0007d4-L9
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVDSWtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVDSWtY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:49:24 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:26546 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261721AbVDSWtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:49:17 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DO1Wl-0001KA-00; Tue, 19 Apr 2005 18:49:07 -0400
To: David Meybohm <dmeybohmlkml@bellsouth.net>
In-Reply-To: <20050419223027.GA26100@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, David Meybohm wrote:

> But doesn't this require assuming the distribution of MD5 is uniform,
> and don't the papers finding collisions in less show it's not? So, your
> birthday-argument for calculating the probability wouldn't apply, because
> it rests on the assumption MD5 is uniform, and it isn't.

No, the collision papers don't show this at all.
  --scott
atomic strategic HBDRILL SARANAC COBRA JUDY Ft. Meade assassination politics 
Mossad HOPEFUL ZPSEMANTIC DTFROGS HTKEEPER LITEMPO LIONIZER operation
                          ( http://cscott.net/ )
