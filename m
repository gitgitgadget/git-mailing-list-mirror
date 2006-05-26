From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
Date: Fri, 26 May 2006 22:23:17 +1000
Message-ID: <20060526122317.GC5372@gondor.apana.org.au>
References: <11486091783808-git-send-email-normalperson@yhbt.net> <11486091793385-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 14:53:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjboZ-0006z9-Rq
	for gcvg-git@gmane.org; Fri, 26 May 2006 14:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEZMxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 08:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWEZMxI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 08:53:08 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:41989 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750700AbWEZMxH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 08:53:07 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1FjboL-0002pD-T8; Fri, 26 May 2006 22:53:01 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1FjbLZ-0001lf-00; Fri, 26 May 2006 22:23:17 +1000
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <11486091793385-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20809>

On Thu, May 25, 2006 at 07:06:17PM -0700, Eric Wong wrote:
> None of the variables seem to conflict, so local was unnecessary.

BTW, dash supports (and has always supported) local which is a quite
useful feature.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
