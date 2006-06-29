From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [patch] Make git-svn init accept a target dir
Date: Wed, 28 Jun 2006 17:28:52 -0700
Message-ID: <20060629002852.GA29147@hand.yhbt.net>
References: <44A30BAD.60907@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 02:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvkOy-0006Ts-21
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 02:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWF2A25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 20:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWF2A25
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 20:28:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8161 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751844AbWF2A2y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 20:28:54 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 350587DC022; Wed, 28 Jun 2006 17:28:53 -0700 (PDT)
To: Luca Barbato <lu_zero@gentoo.org>
Content-Disposition: inline
In-Reply-To: <44A30BAD.60907@gentoo.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22828>

Luca Barbato <lu_zero@gentoo.org> wrote:
> Since I'm lazy I just hacked a bit git-svn in order to create a target
> dir and init it if is passed as second parameter.
> 
> git-svn init url://to/the/repo local-repo
> 
> will create the local-repo dir if doesn't exist yet and populate it as
> expected.
> 
> Maybe someone else could find it useful

Sounds useful and I'll probably accept it, but I don't see the actual
patch, though...

-- 
Eric Wong
