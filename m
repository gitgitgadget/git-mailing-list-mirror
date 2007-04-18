From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Wed, 18 Apr 2007 22:19:26 +0200
Organization: Dewire
Message-ID: <200704182219.26410.robin.rosenberg.lists@dewire.com>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625DDA5.60503@vilain.net> <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:16:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGZV-00088A-69
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992549AbXDRUQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992550AbXDRUQF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:16:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12146 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S2992549AbXDRUQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:16:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C94F0802881;
	Wed, 18 Apr 2007 22:10:12 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08102-08; Wed, 18 Apr 2007 22:10:12 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6C8AB80265E;
	Wed, 18 Apr 2007 22:10:12 +0200 (CEST)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44939>

onsdag 18 april 2007 12:33 skrev Julian Phillips:
> On Wed, 18 Apr 2007, Sam Vilain wrote:
> 
> > Julian Phillips wrote:
> >>> Sure... and from my own perspective as a user, I didn't even realise
> >>> what float did until now, and was surprised that "bury" would mean that.
> >>> The metaphor is a stack, not a pool or a sandpit. I don't think those
> >>> terms really assist in understanding, however cute they are.
> >>>
> >>
> >> I find that bury is more natural than float (thinking of a stack of
> >> documents on a desk ...).  But then I don't use stg ...
> >>
> >
> > You demonstrate my point :) by apparently missing that "bury" and
> > "float" are supposed to be the *opposite* of each other.
> 
> I didn't mean to give that impression.  I was aware that they were 
> opposites, but was only commenting on my view of the intuitivness of each.
> 
> I can't really think of a single metaphor where float and bury are both 
> appropriate though.

The stack is transparent, so the "float" comes from thinking of the stack as a 
column (glass pillar) of water with things in it. So I wanted to float patches. I
didn't think too much about the name, it just popped out. At least that is what
I *think* I was thinking at the time.

The logical opposide thing is to "sink" things you don't work to work on.  "bury" 
implies  you don't see things, which just isn't true.

I did consider raise, but then you can raise things only a little. Floating a patch
makes it move all the way to the top.

-- robin
