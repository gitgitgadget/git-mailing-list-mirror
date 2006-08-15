From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] make inline is_null_sha1 global
Date: Wed, 16 Aug 2006 00:28:20 +0200
Message-ID: <20060815222819.GA1145@diku.dk>
References: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com> <20060815215812.GB15797@diku.dk> <Pine.LNX.4.63.0608151510120.5555@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 00:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD7Of-0005Kp-Hx
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 00:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHOW20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 18:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWHOW20
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 18:28:26 -0400
Received: from [130.225.96.91] ([130.225.96.91]:20876 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750765AbWHOW2Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 18:28:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8B8D277002B;
	Wed, 16 Aug 2006 00:28:22 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07427-14; Wed, 16 Aug 2006 00:28:21 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1C767770028;
	Wed, 16 Aug 2006 00:28:21 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 627106DF835; Wed, 16 Aug 2006 00:27:14 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DE79C629F3; Wed, 16 Aug 2006 00:28:20 +0200 (CEST)
To: David Rientjes <rientjes@google.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608151510120.5555@chino.corp.google.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25491>

David Rientjes <rientjes@google.com> wrote Tue, Aug 15, 2006:
> On Tue, 15 Aug 2006, Jonas Fonseca wrote:
> 
> > Looks like this should be !is_null_sha1(...) in both cases.
> > 
> 
> Correct, thanks for pointing that out.  Please ack the following patch that 
> fixes it.
> 
> 		David
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Acked-by: Jonas Fonseca <fonseca@diku.dk>

-- 
Jonas Fonseca
