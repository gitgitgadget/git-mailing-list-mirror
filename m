From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-am: Clean up the asciidoc documentation
Date: Tue, 15 May 2007 14:23:57 +0200
Message-ID: <20070515122357.GF5272@planck.djpig.de>
References: <1179153893715-git-send-email-frank@lichtenheld.de> <11791538941022-git-send-email-frank@lichtenheld.de> <7vd513lztp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 15 14:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnw4W-0003w9-9G
	for gcvg-git@gmane.org; Tue, 15 May 2007 14:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXEOMYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 08:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756330AbXEOMYE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 08:24:04 -0400
Received: from planck.djpig.de ([85.10.192.180]:1739 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbXEOMYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 08:24:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id A5456274016;
	Tue, 15 May 2007 14:24:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RANMSWJeOAu; Tue, 15 May 2007 14:23:58 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8D566274015; Tue, 15 May 2007 14:23:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd513lztp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47340>

On Mon, May 14, 2007 at 05:01:38PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> >  -i, --interactive::
> > -	Run interactively, just like git-applymbox.
> > +	Run interactively, just like `git-applymbox` (see gitlink:git-applymbox[1]).
> 
> This is an unclear description from the original, but I think we
> should say just like `git-applybox -i`, or drop this altogether.

Hmm, your comment doesn't make any sense to me, because applymbox has
no -i option.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
