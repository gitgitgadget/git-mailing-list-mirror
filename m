From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 10:42:36 +0300
Message-ID: <20060814074236.GG21963@mellanox.co.il>
References: <7v64gvg48b.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 09:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCX3x-0000EY-KQ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 09:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWHNHke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 03:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWHNHkd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 03:40:33 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:44260 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751915AbWHNHkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 03:40:33 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 0f820e44.2531359664.17459.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 01:40:32 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 10:46:34 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 10:42:36 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64gvg48b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 07:46:34.0562 (UTC) FILETIME=[C3EA2A20:01C6BF75]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25329>

Quoting r. Junio C Hamano <junkio@cox.net>:
> A shared repository style" does not mean anarchy; helping to
> name the same thing with multiple branch names at the central
> site is not something we would want to encourage anyway.
> 

OK. Do other reasons sound sufficiently convincing to you?

-- 
MST
