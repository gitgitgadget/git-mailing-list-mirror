From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 07:02:02 +0200
Message-ID: <20070322043604.GA6303@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 06:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUFQT-0004T8-2Q
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 06:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965696AbXCVFBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 01:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965705AbXCVFBV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 01:01:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:13115 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965696AbXCVFBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 01:01:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so582012uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 22:01:19 -0700 (PDT)
Received: by 10.67.26.7 with SMTP id d7mr4276560ugj.1174539679390;
        Wed, 21 Mar 2007 22:01:19 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.8.45])
        by mx.google.com with ESMTP id e1sm2696676ugf.2007.03.21.22.01.17;
        Wed, 21 Mar 2007 22:01:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42837>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> Would "Hi!" and "Would the following be appropriate?" be part of
> the final commit log message?

Sigh. I wish there was a way to tell git-am "ignore text *before* this line"
just like --- means ignore text after this line.

-- 
MST
