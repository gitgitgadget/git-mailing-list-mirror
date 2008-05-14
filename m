From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 14 May 2008 18:55:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805141844500.19665@iabervon.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:56:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPtF-0002FE-St
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbYENWzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYENWzP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:55:15 -0400
Received: from iabervon.org ([66.92.72.58]:33700 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842AbYENWzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:55:13 -0400
Received: (qmail 30012 invoked by uid 1000); 14 May 2008 22:55:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 May 2008 22:55:11 -0000
In-Reply-To: <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82157>

On Wed, 14 May 2008, Junio C Hamano wrote:

> * db/clone-in-c (Sun Apr 27 13:39:30 2008 -0400) 8 commits
>  + Build in clone
>  + Provide API access to init_db()
>  + Add a function to set a non-default work tree
>  + Allow for having for_each_ref() list extra refs
>  + Have a constant extern refspec for "--tags"
>  + Add a library function to add an alternate to the alternates file
>  + Add a lockfile function to append to a file
>  + Mark the list of refs to fetch as const
> 
> For 1.5.6; please give it a good beating.

Last time, you said you were going to review this again; did you review it 
and find nothing to comment on, decide to just make sure it gets a 
beating, or are you still planning to review it more? (Just wondering so I 
can try to arrange to have time to respond to comments if there's going to 
be a bunch)
