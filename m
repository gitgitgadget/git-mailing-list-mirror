From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: gitweb tags feed, Re: New version announcements?
Date: Thu, 24 Jul 2008 16:04:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0807241600190.7093@reaper.quantumfyre.co.uk>
References: <3B8DB770-5ADC-4B99-9A12-F1DABA20C34D@bunster.org>
 <20080724144939.GI10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jordi Bunster <jordi@bunster.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:31:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2me-0004uH-Qn
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 17:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427AbYGXP3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 11:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757400AbYGXP3f
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 11:29:35 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49094 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757368AbYGXP3e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 11:29:34 -0400
X-Greylist: delayed 1446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2008 11:29:34 EDT
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 98B00F3DE9
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:05:26 +0100 (BST)
Received: (qmail 14362 invoked by uid 103); 24 Jul 2008 16:04:03 +0100
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.92.1/7807. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.02856 secs); 24 Jul 2008 15:04:03 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 24 Jul 2008 16:04:03 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20080724144939.GI10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89896>

On Thu, 24 Jul 2008, Petr Baudis wrote:

>  Hi,
>
> On Thu, Jul 24, 2008 at 10:38:24AM -0400, Jordi Bunster wrote:
>> I've been following the git mailing list to stay on top of new releases,
>> but the traffic got too high.
>>
>> Any way that a git-announce list could be created for security fixes and
>> new releases? Or maybe an RSS feed on the website?

An RSS feed already exists, have a look at http://gitrss.q42.co.uk/.

>>
>> If there's a news file or some-such, I'd be glad to write the code to
>> convert it to a subscription feed.
>
>  I believe you meant to write this to the list directly, I'm cc'ing it
> now. Basically, this depends on whether Junio finds it worth-while. :-)
> I think these requests do not pop up often, but that might mean that
> most people are simply discouraged right away and too shy to ask for it.

There was a request for RSS feeds some time ago, and I setup the above 
feeds which automatically process the git mailing list traffic - haven't 
bothered to actually monitor if anyone is using them though ;)

>
>  One thing that comes on my mind would be to implement RSS feed of new
> tags to gitweb; this could supply the information about new releases
> easily. Any bored gitweb hacker willing to implement this? ;-)
>
>  (Of course, it is a bit of pity that release announcements aren't part
> of the tag comment when Git already makes tag comments possible; that
> could be a part of the feed. Maybe with the feed as a nice use-case,
> Junio could get convinced to do that though, if it doesn't disrupt his
> release workflow too much.)
>
>

-- 
Julian

  ---
Peter's hungry, time to eat lunch.
