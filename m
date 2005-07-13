From: Darrin Thompson <darrint@progeny.com>
Subject: Re: [PATCH (contingency)] Document "curl" requirements.
Date: Wed, 13 Jul 2005 15:50:58 -0500
Message-ID: <1121287859.3968.16.camel@localhost.localdomain>
References: <20050713021240.88AAD63780@morimoto.progeny.com>
	 <7vk6juxy97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:55:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoFk-0000eN-Ns
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVGMUxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVGMUwH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:52:07 -0400
Received: from zealot.progeny.com ([216.37.46.162]:21650 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262780AbVGMUvD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 16:51:03 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id B6CB5636AB; Wed, 13 Jul 2005 15:51:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6juxy97.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-07-13 at 13:11 -0700, Junio C Hamano wrote:
> darrint@progeny.com (Darrin Thompson) writes:
> 
> > Cause setting environment variable GIT_SSL_NO_VERIFY to turn off
> > curl's ssl peer verification.
> >
> > Only use curl for http transfers, instead of curl and wget.
> 
> I do not mind curl per se, since we already require libcurl for
> http-pull, but it would be nice if we document what external
> software we depend on in one place.  Something like this on top
> of what you posted?

I have no problem with it. Do I need to take some action?

--
Darrin
