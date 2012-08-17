From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 03/12] git p4: gracefully fail if some commits could not
 be applied
Date: Fri, 17 Aug 2012 07:49:56 -0400
Message-ID: <20120817114956.GA29214@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
 <1345160114-27654-4-git-send-email-pw@padd.com>
 <502DEA6F.5080406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 13:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2L43-0003J1-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 13:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab2HQLuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 07:50:02 -0400
Received: from honk.padd.com ([74.3.171.149]:52150 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab2HQLuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 07:50:00 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 84F5FD27;
	Fri, 17 Aug 2012 04:49:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9B1A8313FD; Fri, 17 Aug 2012 07:49:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <502DEA6F.5080406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203610>

j.sixt@viscovery.net wrote on Fri, 17 Aug 2012 08:53 +0200:
> Am 8/17/2012 1:35, schrieb Pete Wyckoff:
> > +++ b/t/t9815-git-p4-submit-fail.sh
> > @@ -0,0 +1,93 @@
> > +
> > +#!/bin/sh
> 
> This initial blank line is an accident, right? ;-)

Yes, the paint on the font was still wet.  Thanks!

		-- Pete
