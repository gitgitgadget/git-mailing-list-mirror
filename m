From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of
 contrib/stg-sink.
Date: Wed, 18 Apr 2007 08:41:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704180840100.4684@beast.quantumfyre.co.uk>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
 <4625314E.2050103@vilain.net> <b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com>
 <7vlkgqlezn.fsf@assigned-by-dhcp.cox.net> <4625874E.5040505@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4n6-0001Gh-Lk
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbXDRHlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXDRHlV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:41:21 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38064 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932903AbXDRHlU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 03:41:20 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AF2B8C6491
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 08:41:19 +0100 (BST)
Received: (qmail 24318 invoked by uid 103); 18 Apr 2007 08:40:37 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035479 secs); 18 Apr 2007 07:40:37 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 08:40:37 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <4625874E.5040505@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44868>

On Wed, 18 Apr 2007, Sam Vilain wrote:

> Junio C Hamano wrote:
>>>> But 'bury' means to hide or even kill.
>>>>
>>>> How about "raise" and "lower" ?
>>>>
>>> Or "immerse" ("immerge"?) as another opposite of "float" :-)
>>>
>>> I don't have any opinion on this, it's up to Yann to argue.
>>>
>> As a user, to me, 'bury' feels perfect and I am not annoyed by
>> the connotation, perhaps maybe I am used to 'bury-buffer' in
>> Emacs.
>>
>
> Sure... and from my own perspective as a user, I didn't even realise
> what float did until now, and was surprised that "bury" would mean that.
> The metaphor is a stack, not a pool or a sandpit. I don't think those
> terms really assist in understanding, however cute they are.

I find that bury is more natural than float (thinking of a stack of 
documents on a desk ...).  But then I don't use stg ...


-- 
Julian

  ---
Do nothing unless you must, and when you must act -- hesitate.
