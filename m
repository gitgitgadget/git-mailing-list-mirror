From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Mon, 16 Apr 2007 08:34:35 +0300
Message-ID: <20070416053435.GA23255@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdJrK-0001Us-7T
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 07:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbXDPFee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 01:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbXDPFee
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 01:34:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:16065 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbXDPFee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 01:34:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1026651uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 22:34:32 -0700 (PDT)
Received: by 10.67.116.13 with SMTP id t13mr1723136ugm.1176701579614;
        Sun, 15 Apr 2007 22:32:59 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id 29sm2016981uga.2007.04.15.22.34.31;
        Sun, 15 Apr 2007 22:34:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44581>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Display the subject of the commit just made.
> 
> WHY?  You just made the commit.

BTW, Junio, why does git-commit need to display the diffstat?
You just made the commit ...

-- 
MST
