From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-rm suggestion
Date: Wed, 21 Sep 2005 16:15:52 +0200
Message-ID: <20050921141552.GC17981@pasky.or.cz>
References: <1126531426.6380.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 16:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI5OC-0005bN-RT
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 16:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVIUOPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 10:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVIUOPz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 10:15:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58855 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750974AbVIUOPy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 10:15:54 -0400
Received: (qmail 21238 invoked by uid 2001); 21 Sep 2005 16:15:52 +0200
To: jamal <hadi@cyberus.ca>
Content-Disposition: inline
In-Reply-To: <1126531426.6380.2.camel@localhost.localdomain>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9046>

Dear diary, on Mon, Sep 12, 2005 at 03:23:46PM CEST, I got a letter
where jamal <hadi@cyberus.ca> told me that...
> Folks,
> 
> I am not on the list so cc if you respond.
> 
> A small suggestion for cg-rm: Can you make the default not to physically
> remove the file since that is more destructive?
> Unless there is a way to recover it.
> 
> Let someone who wants to delete explicitly specify it. Or maybe even do
> the rm -i like option of prompting.

Yes, it was changed to only cg-rm -f physically removing the file.
Thanks for the suggestion.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
