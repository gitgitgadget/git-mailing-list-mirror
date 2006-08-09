From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: setting up a git repo on apache
Date: Wed, 9 Aug 2006 18:43:05 +0200
Organization: M38c
Message-ID: <20060809164305.GA7841@nospam.com>
References: <44DA060B.2050601@eircom.net>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 18:43:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAr9J-0000qp-10
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 18:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHIQnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 12:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWHIQnK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 12:43:10 -0400
Received: from post-24.mail.nl.demon.net ([194.159.73.194]:60375 "EHLO
	post-24.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750996AbWHIQnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 12:43:09 -0400
Received: from wingding.demon.nl ([82.161.27.36]:38413)
	by post-24.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GAr99-0002zR-H2; Wed, 09 Aug 2006 16:43:07 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GAr97-0002rB-Ny; Wed, 09 Aug 2006 18:43:05 +0200
To: Alan Larkin <nobrow@eircom.net>
Content-Disposition: inline
In-Reply-To: <44DA060B.2050601@eircom.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25126>

On Wed, Aug 09, 2006 at 04:58:03PM +0100, Alan Larkin wrote:
> New user ... Hi.
> 
> I realise that this is really an apache question, but Im not getting any
> help from their mailing lists and figure that there must be someone here
> whos done this.
> 
> Can someone please help me get a GIT repo running on Apache 2.
> Specifically my problem is with DAV.
> 
> $ git push http://localhost:/webdav/git/myproj master
> Error: no DAV locking support on remote repo

This 'localhost:' is a typo, right?

(just to be sure)


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
