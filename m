From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: GitWiki lost ability to parse macros
Date: Wed, 6 Sep 2006 17:15:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0609061712410.7168@reaper.quantumfyre.co.uk>
References: <edm7h3$nij$1@sea.gmane.org> <20060906113052.GC23891@pasky.or.cz>
 <edmcd6$9or$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 18:15:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL03k-00005o-Nr
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWIFQPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 12:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWIFQPZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 12:15:25 -0400
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:21224 "EHLO
	neutron.quantumfyre.co.uk") by vger.kernel.org with ESMTP
	id S1751380AbWIFQPY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 12:15:24 -0400
Received: (qmail 9969 invoked by uid 103); 6 Sep 2006 17:15:21 +0100
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.4/1811. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.029939 secs); 06 Sep 2006 16:15:21 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 6 Sep 2006 17:15:21 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edmcd6$9or$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26538>

On Wed, 6 Sep 2006, Jakub Narebski wrote:

> Hmm... I still get for http://git.or.cz/gitwiki/RecentChanges
>
> {{RandomQuote()}}
>
> {{RecentChanges}}
>
>

MoinMoin caches a copy of the generated html page, which is automatically 
updated when you edit the page.  Since fixing the macros doesn't mean 
updating the page you have to manually delete the cache - this can be done 
from the "More Actions:" list.

-- 
Julian

  ---
If you are smart enough to know that you're not smart enough to be an
Engineer, then you're in Business.
