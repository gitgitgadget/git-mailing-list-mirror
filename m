From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/7] rev-list: implement --bisect-all
Date: Mon, 15 Oct 2007 00:39:49 +0200
Message-ID: <20071014223949.GG31659@planck.djpig.de>
References: <20071014142852.2516e083.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhC8B-0008D8-8r
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438AbXJNWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759534AbXJNWkJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:40:09 -0400
Received: from planck.djpig.de ([85.10.192.180]:3076 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbXJNWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:40:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 8FB0188231;
	Mon, 15 Oct 2007 00:40:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bwd8GBWBRuly; Mon, 15 Oct 2007 00:39:50 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 1ADBC88232; Mon, 15 Oct 2007 00:39:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071014142852.2516e083.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60921>

On Sun, Oct 14, 2007 at 02:28:52PM +0200, Christian Couder wrote:
> This is Junio's patch with some stuff to make --bisect-all
> compatible with --bisect-vars.
> 
> This option makes it possible to see all the potential
> bisection points. The best ones are displayed first.

--bisect-all is still missing a Documentation/ patch.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
