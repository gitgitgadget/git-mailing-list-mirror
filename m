From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Mon, 20 Feb 2006 03:01:47 +0100
Message-ID: <20060220020147.GB8759@diku.dk>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 20 03:02:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB0Nf-0008Ii-Ra
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 03:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWBTCBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 21:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWBTCBv
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 21:01:51 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:8672 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932543AbWBTCBv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 21:01:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 6D26252D5EB;
	Mon, 20 Feb 2006 03:01:50 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05293-06; Mon, 20 Feb 2006 03:01:47 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C307452D4D8;
	Mon, 20 Feb 2006 03:01:47 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 408EE6DF823; Mon, 20 Feb 2006 03:00:47 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A82EA61C01; Mon, 20 Feb 2006 03:01:47 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16464>

Marco Costalba <mcostalba@gmail.com> wrote Sun, Feb 19, 2006:
> +	- *gitview*  (contrib/)
> +
> +            gitview is a GTK based repository browser for git
> +
> +
> +	- *gitweb* (ftp://ftp.kernel.org/pub/software/scm/gitweb/)
> +
> +            GITweb provides full-fledged web interface for GIT repositories.

You can make it more asciidoc-friendly if you convert the list to use
the format:

*gitview* (contrib)::

	gitview is a GTK based repository browser for git

ftp://ftp.kernel.org/pub/software/scm/gitweb/[*gitweb*]::

	GITweb provides full-fledged web interface for GIT repositories.

-- 
Jonas Fonseca
