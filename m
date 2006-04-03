From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 3 Apr 2006 16:03:48 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060403140348.GE16823@harddisk-recovery.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 16:03:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQPeq-0000Et-Sk
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDCODu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWDCODu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:03:50 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50590 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751102AbWDCODt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:03:49 -0400
Received: (qmail 14262 invoked by uid 501); 3 Apr 2006 16:03:48 +0200
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1143956188.2303.39.camel@neko.keithp.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18328>

On Sat, Apr 01, 2006 at 09:36:28PM -0800, Keith Packard wrote:
> The UI is a total disaster, sufficient for testing. You must create an
> Authors file in the current directory which looks like the git-cvsimport
> authors file. You must also have a edit-change-log program in your path
> which edits the commit message in place. /bin/true will work if you
> don't need to edit the messages.
> 
> I should clearly steal the existing git-cvsimport command line arguments
> and use those.

What is the current way to use it? I get the impression it reads raw ,v
files, but how do I get along with a remote CVS repository?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
