From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of
 contrib/stg-sink.
Date: Wed, 18 Apr 2007 11:33:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
 <4625314E.2050103@vilain.net> <b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com>
 <7vlkgqlezn.fsf@assigned-by-dhcp.cox.net> <4625874E.5040505@vilain.net>
 <Pine.LNX.4.64.0704180840100.4684@beast.quantumfyre.co.uk> <4625DDA5.60503@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He7UE-0005q3-6J
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXDRKdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbXDRKdz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:33:55 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49522 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342AbXDRKdy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 06:33:54 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E2435C6499
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 11:33:52 +0100 (BST)
Received: (qmail 29395 invoked by uid 103); 18 Apr 2007 11:33:09 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.039363 secs); 18 Apr 2007 10:33:09 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 11:33:09 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <4625DDA5.60503@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44882>

On Wed, 18 Apr 2007, Sam Vilain wrote:

> Julian Phillips wrote:
>>> Sure... and from my own perspective as a user, I didn't even realise
>>> what float did until now, and was surprised that "bury" would mean that.
>>> The metaphor is a stack, not a pool or a sandpit. I don't think those
>>> terms really assist in understanding, however cute they are.
>>>
>>
>> I find that bury is more natural than float (thinking of a stack of
>> documents on a desk ...).  But then I don't use stg ...
>>
>
> You demonstrate my point :) by apparently missing that "bury" and
> "float" are supposed to be the *opposite* of each other.

I didn't mean to give that impression.  I was aware that they were 
opposites, but was only commenting on my view of the intuitivness of each.

I can't really think of a single metaphor where float and bury are both 
appropriate though.

-- 
Julian

  ---
He's dead, Jim.
 		-- McCoy, "The Devil in the Dark", stardate 3196.1
