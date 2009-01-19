From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: how to track multiple upstreams in one repository
Date: Mon, 19 Jan 2009 16:29:09 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0901191627480.4115@reaper.quantumfyre.co.uk>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 19 17:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOxLb-0004EJ-3E
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 17:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbZASQuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 11:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbZASQuK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 11:50:10 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44788 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364AbZASQuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 11:50:09 -0500
X-Greylist: delayed 1247 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 11:50:09 EST
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 637E523E0AC
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 16:29:20 +0000 (GMT)
Received: (qmail 13133 invoked by uid 103); 19 Jan 2009 16:29:09 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94.1/8875. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.029391 secs); 19 Jan 2009 16:29:09 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 19 Jan 2009 16:29:09 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106366>

On Sun, 18 Jan 2009, david@lang.hm wrote:

> for linux I want to track both the linus tree and the -stable tree. Ideally I 
> want to be able to do a checkout of tags from either tree from the same 
> directory (along with diffs between items in both trees, etc)
>
> I have found documentation on how to clone from each of them, but I haven't 
> found any simple documentation on how to work with both of them.

You could always just use 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git 
?  It already contains both the linus tree and all the stable trees ...

>
> David Lang
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

-- 
Julian

  ---
Flattery is like cologne -- to be smelled, but not swallowed.
 		-- Josh Billings
