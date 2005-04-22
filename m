From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 00:24:37 -0700
Message-ID: <20050422072437.GC8467@ip68-225-251-162.oc.oc.cox.net>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422071626.GB8467@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 09:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOsTr-0005WX-RD
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 09:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVDVHZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 03:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVDVHZH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 03:25:07 -0400
Received: from orb.pobox.com ([207.8.226.5]:39321 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262008AbVDVHYl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 03:24:41 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id 9527C823; Fri, 22 Apr 2005 03:24:38 -0400 (EDT)
Received: from ip68-225-251-162.oc.oc.cox.net (ip68-225-251-162.oc.oc.cox.net [68.225.251.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 55D5A87;
	Fri, 22 Apr 2005 03:24:36 -0400 (EDT)
Received: by ip68-225-251-162.oc.oc.cox.net (Postfix, from userid 500)
	id 8197058DA9AA; Fri, 22 Apr 2005 00:24:37 -0700 (PDT)
To: "Barry K. Nathan" <barryn@pobox.com>
Content-Disposition: inline
In-Reply-To: <20050422071626.GB8467@ip68-225-251-162.oc.oc.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 12:16:26AM -0700, Barry K. Nathan wrote:
> With git-pasky 0.6.3, "git log" is unusable on my Mandrake 10.1 system.
> Basically I get a neverending flood of these until I press 'q' to quit
> less:
[snip sed segmentation faults which happen with 0.6.3 but not 0.6.2]
> I'm not sure if I have time tonight (or tomorrow) to troubleshoot this
> further, but I'll see if I can.

I had sed-4.1.1-2mdk. I downloaded sed-4.1.4-2mdk (from Mandriva 2005
Limited Edition) and updated to that, and the problem went away.

FWIW this is the second package I've had to update to the Mandriva 2005
LE level (the first was mktemp). I don't mind however.

-Barry K. Nathan <barryn@pobox.com>

