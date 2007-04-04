From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 4 Apr 2007 09:18:56 +0300
Message-ID: <20070404061856.GD31984@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYypz-0000Wg-U0
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992688AbXDDGS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992689AbXDDGS7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:18:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992688AbXDDGS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:18:58 -0400
Received: by ug-out-1314.google.com with SMTP id 44so550446uga
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 23:18:56 -0700 (PDT)
Received: by 10.67.99.1 with SMTP id b1mr1197545ugm.1175667536383;
        Tue, 03 Apr 2007 23:18:56 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id l40sm1605479ugc.2007.04.03.23.18.54;
        Tue, 03 Apr 2007 23:18:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43710>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> > *Maybe* git can be even smarter, and notice that only
> > commit message has changed, and preserve the author automatically
> > in this case? I haven't looked at how hard that would be to do.
> 
> Maybe you can try what you complain about out before you rant?
> I amend other people's commit messages after the fact almost
> *every* *day*.

Right. Sorry.

-- 
MST
