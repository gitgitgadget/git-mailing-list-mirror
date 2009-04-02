From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Wed, 01 Apr 2009 19:33:37 -0500
Message-ID: <op.urqg6bhmso3nzr@sulidor.mdjohnson.us>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
 <20090329121700.GN22446@genesis.frugalware.org>
 <op.urk20nanso3nzr@sulidor.mdjohnson.us>
 <20090330110335.GF22446@genesis.frugalware.org>
 <op.urnad7jbso3nzr@sulidor.mdjohnson.us> <20090401180627.GA14716@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Clemens Buchacher" <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Apr 02 02:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpAtv-0002g4-1G
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 02:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761309AbZDBAdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 20:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760410AbZDBAdv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 20:33:51 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:49962 "EHLO
	looneymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759119AbZDBAdu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 20:33:50 -0400
Received: from sulidor.mdjohnson.us (216.49.248-IP-55.ckt.net [216.49.248.55])
	by looneymail-a3.g.dreamhost.com (Postfix) with ESMTP id 4DD4227B7E;
	Wed,  1 Apr 2009 17:33:47 -0700 (PDT)
In-Reply-To: <20090401180627.GA14716@localhost>
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115427>

On Wed, 01 Apr 2009 13:06:27 -0500, Clemens Buchacher <drizzd@aon.at>  
wrote:

> On Tue, Mar 31, 2009 at 02:14:21AM -0500, Michael Johnson wrote:
>> It would appear that the patch has already been applied to 1.6.2.1.
>
> I don't think it has. But judging from the stack trace this bug is  
> unrelated to the patch anyways.

When I tried to appy the patch I got a conflict (I applied it directly to  
Debian's source package for git-core). When I compared the code to the  
patch it appeared it had been applied. Of course, I'm far from an expert  
at applying patches, so I might have misread the direction of the patch.

> If nobody else is dealing with this I'd like to have a look at it. Could  
> you please send me a copy of the repo.

It doesn't sound like anyone else is. So I'll send you a copy shortly, off  
list.

Thanks for all the help,
Michael

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
