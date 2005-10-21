From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Fri, 21 Oct 2005 16:02:28 +1300
Message-ID: <43585A44.3050205@catalyst.net.nz>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 05:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESnAm-0006is-AQ
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 05:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVJUDCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 23:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVJUDCV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 23:02:21 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:38065 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964848AbVJUDCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 23:02:21 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ESnAi-0007Yw-5U; Fri, 21 Oct 2005 16:02:20 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051021005145.GB30889@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10410>

Petr Baudis wrote:

> Dear diary, on Mon, Oct 17, 2005 at 02:48:09AM CEST, I got a letter
> where "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> told me that...
> 
>>Petr Baudis hinted earlier that he might be coming, as did Linus (but
>>he was hoping for a sponsor, I'm not sure whether he'll be there or
>>not). Speak up if you'll be there!
> 
> 
> I'm sorry but I will not be there - it is too far away from my little
> country. :-(

Sad to hear that. I'll be soon in Europe, though, but not in CZ, 
unfortunately!

> (i) You might want to say "cg-export" instead of "git-tar-tree" (*shrug*)

You're right! I hadn't seen that.

> (ii) You say:
> 
> 	- Very fast stupid merge
> 	    ... and very smart, slow merges when stupid won't do
> 
>   What are you explicitly referring to? I don't think any kind of merge
> in GIT (unless something totally missed me) can be called "very smart".
> If it's a three-way merge, it's never "very smart".

See latest developments on git-merge.sh -- we should really revamp 
cg-merge ;)

> 	vim .gitignore

Then it'd be a bug, not a feature ;)

>>ps: lately, about 30% of my emails to git@vger from gmail have been 
>>dropped on the floor. This is starting to get annoying, is anyone seeing 
>>similar issues?
> 
> 
> Not me. Perhaps I'm in some VIP class. :^)

Oh, I figured that out! Gmail's "utf-8" mode encodes everything in 
base64. Awful sh*t. Reverted to ascii and life is good.



martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
