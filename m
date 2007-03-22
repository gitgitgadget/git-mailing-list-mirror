From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 09:41:13 +0200
Message-ID: <20070322074051.GA29341@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 08:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUHuX-0006SE-CJ
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 08:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbXCVHkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 03:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbXCVHkb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 03:40:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:61532 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbXCVHka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 03:40:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so608963uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 00:40:28 -0700 (PDT)
Received: by 10.67.99.1 with SMTP id b1mr4466050ugm.1174549228664;
        Thu, 22 Mar 2007 00:40:28 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id k1sm2826705ugf.2007.03.22.00.40.27;
        Thu, 22 Mar 2007 00:40:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42845>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > BTW, is there some way to figure it out besides looking at the code
> > or grepping git archives?
> 
> Like SubmittingPatches?

SubmittingPatches is for people contributing to git.
But how are *users* of git-am supposed to figure it out?

-- 
MST
