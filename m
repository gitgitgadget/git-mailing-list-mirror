From: James Purser <purserj@ksit.dynalias.com>
Subject: Re: Date handling.
Date: Sun, 24 Apr 2005 13:33:35 +1000
Message-ID: <1114313615.25535.1.camel@kryten>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	 <1113500316.27227.8.camel@hades.cambridge.redhat.com>
	 <20050424030416.GE16751@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 05:27:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXmO-0003Aw-Fq
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVDXDcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVDXDcT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:32:19 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:59009 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262239AbVDXDcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 23:32:17 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j3O3Xcfb025578;
	Sun, 24 Apr 2005 13:33:38 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j3O3XZ2q025577;
	Sun, 24 Apr 2005 13:33:35 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@ksit.dynalias.com using -f
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050424030416.GE16751@delft.aura.cs.cmu.edu>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wouldn't it be easier to force GMT or UTC as the base timezone for the
application. This would remove any confusion between different
timezones.
-- 
James Purser
http://ksit.dynalias.com

