From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/2] bookmarks (was: Re: git-fetch and unannotated tags)
Date: Thu, 26 Apr 2007 10:00:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704260958120.22894@reaper.quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
 <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
 <200704260908.07108.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgzpx-0005XE-LU
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 11:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbXDZJAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 05:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbXDZJAW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 05:00:22 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42189 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754776AbXDZJAV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 05:00:21 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id EB4CAC61CD
	for <git@vger.kernel.org>; Thu, 26 Apr 2007 10:00:19 +0100 (BST)
Received: (qmail 468 invoked by uid 103); 26 Apr 2007 09:59:14 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3162. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.035902 secs); 26 Apr 2007 08:59:14 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 26 Apr 2007 09:59:14 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200704260908.07108.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45622>

On Thu, 26 Apr 2007, Andy Parkins wrote:

> On Wednesday 2007 April 25, Julian Phillips wrote:
>
>> While I like the idea of private tags, I find the idea of them having
>> their own namespace to be much more attractive than simply having the
>> ability to not export lightweight tags.
>
> The problem I have with this is that in my mind lightweight tags /are/
> bookmarks - why create another namespace for them with all the extra code
> that is needed to deal with them?  If we implemented this bookmark stuff then
> I can't envisage ever using a lightweight tag.

Well, I was thinking more about having private full tags ... but I think 
the tagopt thing you mentioned later already covers it.

>
> Maybe I'm missing the point - what do people see lightweight tags as useful
> for if not for marking revisions in a not-to-be-published fashion?

I use them in private projects 'cos I'm lazy - but that's not really 
relevant ...

-- 
Julian

  ---
Lewis's Law of Travel:
 	The first piece of luggage out of the chute doesn't belong to anyone,
 	ever.
