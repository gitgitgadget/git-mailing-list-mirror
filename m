From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/3] rev-list: implement --bisect-all
Date: Tue, 9 Oct 2007 12:04:01 +0200
Message-ID: <20071009100401.GC31659@planck.djpig.de>
References: <20071009062511.fb6f6222.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBws-0006aO-U6
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXJIKEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 06:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXJIKEN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:04:13 -0400
Received: from planck.djpig.de ([85.10.192.180]:3795 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbXJIKEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 06:04:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 2C9CA88231;
	Tue,  9 Oct 2007 12:04:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cM6aEGU9uehQ; Tue,  9 Oct 2007 12:04:01 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id A048E88232; Tue,  9 Oct 2007 12:04:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071009062511.fb6f6222.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60378>

On Tue, Oct 09, 2007 at 06:25:11AM +0200, Christian Couder wrote:
> This is Junio's patch with some stuff to make --bisect-all
> compatible with --bisect-vars.
> 
> This option makes it possible to see all the potential
> bisection points. The best ones are displayed first.

The whole series is missing patches for the manual pages.

Just saying.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
