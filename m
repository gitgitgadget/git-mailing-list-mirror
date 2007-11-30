From: Emanuele Giaquinta <e.giaquinta@glauco.it>
Subject: Re: git-cvsimport bug
Date: Fri, 30 Nov 2007 19:41:23 +0100
Message-ID: <20071130184123.GA75770@orion.lan>
References: <20071127150136.GA50697@orion.lan> <20071128165746.GC20308@coredump.intra.peff.net> <20071128185504.GA11236@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyAp9-0000dI-EZ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764076AbXK3Sme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 13:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764262AbXK3Smd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 13:42:33 -0500
Received: from 62-101-89-40.ip.fastwebnet.it ([62.101.89.40]:2749 "HELO
	mx0.glauco.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1763135AbXK3Sma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 13:42:30 -0500
Received: FROM pcnmail BY mx0.glauco.it ; Fri Nov 30 19:42:24 2007 +0100
Received: FROM localhost ([79.2.28.128]) BY pcnmail WITH ESMTP ; Fri, 30 Nov 2007 19:42:23 +0100
Content-Disposition: inline
In-Reply-To: <20071128185504.GA11236@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66657>

On Wed, Nov 28, 2007 at 01:55:04PM -0500, Jeff King wrote:

>   2/3: cvsimport: use show-ref to support packed refs
> 
>        This fix is hopefully obvious, and the included test fails
>        without it (and this should probably fix Emanuele's problem).

It does, thanks!

Emanuele
