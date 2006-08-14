From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Mon, 14 Aug 2006 20:55:23 +0300
Message-ID: <20060814175523.GC16821@mellanox.co.il>
References: <20060814075305.GH21963@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 19:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCgdj-00071f-6r
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 19:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWHNRxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHNRxg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 13:53:36 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:57497 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932605AbWHNRxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 13:53:18 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id e88b0e44.2690804656.121967.00-013.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 11:53:18 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 20:59:20 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 20:55:23 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060814075305.GH21963@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 17:59:20.0968 (UTC) FILETIME=[5E668080:01C6BFCB]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25372>

Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
> So it seems git pull behaves differently depending on whether
> the origin pull line is first or not?

Where do I find the code that decides whether to make an octopus
or many fetches?

-- 
MST
