From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 08:28:05 +0200
Message-ID: <20070322062805.GD6303@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 07:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUGlr-0004vf-GF
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 07:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbXCVG10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 02:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXCVG10
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 02:27:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:10816 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXCVG1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 02:27:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so595942uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 23:27:23 -0700 (PDT)
Received: by 10.66.225.1 with SMTP id x1mr4396806ugg.1174544843751;
        Wed, 21 Mar 2007 23:27:23 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.8.45])
        by mx.google.com with ESMTP id b33sm6932059ika.2007.03.21.23.27.21;
        Wed, 21 Mar 2007 23:27:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd531yicx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42840>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> Quoting Junio C Hamano <junkio@cox.net>:
> >> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> >> 
> >> Would "Hi!" and "Would the following be appropriate?" be part of
> >> the final commit log message?
> >
> > Sigh. I wish there was a way to tell git-am "ignore text *before* this line"
> > just like --- means ignore text after this line.
> 
> Well, I'd sigh back.  I wish people imitated good examples, such as:
> 
> Message-ID: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>

I know that's how git-am wants the input to look.
But I claim that's not how most people *think* or *correspond*.

> which is not too hard to follow.

BTW, is there some way to figure it out besides looking at the code
or grepping git archives?

-- 
MST
