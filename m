From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] gitweb use sections
Date: Thu, 31 Jul 2008 22:32:50 +0200
Message-ID: <20080731203250.GO10151@machine.or.cz>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi> <b1f2b8c40807311243i5689683avcc3c3c91e4e6a900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:34:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeqr-0008Or-K2
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYGaUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbYGaUcy
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:32:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40720 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbYGaUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:32:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0E530393A2DF; Thu, 31 Jul 2008 22:32:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b1f2b8c40807311243i5689683avcc3c3c91e4e6a900@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90982>

  Hi,

On Thu, Jul 31, 2008 at 04:43:35PM -0300, Gustavo Sverzut Barbieri wrote:
> Since nobody replied and I missed some gitweb guys in CC, I'm adding
> Petr and Jakub, as some guys said on IRC.
> 
> Have anyone tried this patch, any problems?

  sorry, I have it in my review queue. At first pass it was looking
good, but I wanted to look at it better before commenting.

  One thing I'm wondering about is how to make this stuff configurable,
since I'm not very comfortable with adding more "unbound" configuration
variables and would rather prefer stuff to be added to the $features
array... I'm not at all sure about my own sentiment here, however.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
