From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: [ANNOUNCE] (H)gct 0.2
Date: Mon, 22 Aug 2005 00:44:31 +0100
Message-ID: <200508220044.31221.mark.williamson@cl.cam.ac.uk>
References: <20050821145851.GA24034@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>, pasky@suse.cz
X-From: git-owner@vger.kernel.org Mon Aug 22 01:47:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6zVz-0002Pn-DZ
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 01:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVHUXqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 19:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVHUXqF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 19:46:05 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:35041 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751164AbVHUXqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 19:46:04 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from maw48.kings.cam.ac.uk ([128.232.241.233]:50511 helo=maw48)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtps (TLSv1:RC4-MD5:128)
	id 1E6zVk-0002HR-OG (Exim 4.51)
	(return-path <mark.williamson@cl.cam.ac.uk>); Mon, 22 Aug 2005 00:45:56 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <20050821145851.GA24034@c165.ib.student.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Any chance a link to the (h)gct homepage could be added to the git homepage 
under "porcelain"?

Cheers,
Mark

On Sunday 21 August 2005 15:58, Fredrik Kuivinen wrote:
> Version 0.2 of (H)gct, a GUI enabled commit tool, has been released
> and can be downloaded from
> http://www.cyd.liu.se/~freku045/gct/gct-0.2.tar.gz
>
> There is also a Git repository for (H)gct at
> http://www.cyd.liu.se/users/~freku045/gct/gct.git/ (and a gitweb for
> this repository is available at
> http://www.cyd.liu.se/users/~freku045/gct/gitweb.cgi)
>
> Some screen shots can be found on the homepage at
> http://www.cyd.liu.se/~freku045/gct
>
>
> The major changes compared to v0.1 are:
>
> * User interface enhancements:
>   - automatically add signoff to commit message
>   - jump directly into an editor to modify files
>   - ignore file (hg only)
>   - preferences panel
>   - revert changes
>   - (un)select all changes
> * Support for Mercurial (hg) repositories via the "hgct" command
> * Generic SCM interface allows easy porting to other SCM systems
> * Assorted small bugfixes and enhancements
>
> Lots of thanks to Mark Williamson for the Hg support, patches and
> ideas.
>
> - Fredrik
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
