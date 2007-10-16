From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git homepage: remove all the references to Cogito
Date: Tue, 16 Oct 2007 04:19:33 +0200
Message-ID: <20071016021933.GH12156@machine.or.cz>
References: <20071015233800.6306e414@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 04:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhcSl-0007r8-HN
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 04:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbXJPCqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 22:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756847AbXJPCqH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 22:46:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33169 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650AbXJPCqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 22:46:06 -0400
X-Greylist: delayed 1588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2007 22:46:06 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id 320755A4D3; Tue, 16 Oct 2007 04:19:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071015233800.6306e414@paolo-desktop>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61064>

On Mon, Oct 15, 2007 at 11:38:00PM +0200, Paolo Ciarrocchi wrote:
> @@ -286,15 +285,6 @@ a gitweb interface, at <a href="http://repo.or.cz/">http://repo.or.cz/</a>.</p>
>  
>  <dl>
>  
> -<dt id="cogito">Cogito</dt>
> -<dd>
> -<a href="http://git.or.cz/cogito/">Cogito</a>
> -is a popular version control system on top of Git.
> -It aims at seamless user interface and ease of use, providing
> -generally smoother user experience than the "raw" Git interface
> -and indeed also many other version control systems. However, it
> -also lacks many advanced capabilities of Git and is currently
> -being slowly phased out.</dd>
>  
>  <dt id="stgit">StGIT</dt>
>  <dd><a href="http://www.procode.org/stgit/">Stacked Git</a> provides

I'm not sure this is good idea, Cogito is still quite frequently used
and it should be documented that it exists.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
