From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Wed, 12 Nov 2008 19:14:28 +1100
Message-ID: <18714.36964.666759.654975@cargo.ozlabs.ibm.com>
References: <200811112355.43352.angavrilov@gmail.com>
	<491A827C.3010000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0AtF-0006Go-Nx
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbYKLIOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYKLIOg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:14:36 -0500
Received: from ozlabs.org ([203.10.76.45]:38386 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYKLIOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:14:36 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 91A1FDDDD8; Wed, 12 Nov 2008 19:14:33 +1100 (EST)
In-Reply-To: <491A827C.3010000@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100720>

Johannes Sixt writes:

> Alexander Gavrilov schrieb:
> > Transient windows cause problems on these platforms:
> ...
> > diff --git a/gitk b/gitk
> > index 9b2a6e5..e6aafe8 100755
> 
> I'd appreciate if you could make it a habit to base your patches on
> versions of gitk etc. that are available from a public repository

You mean, like, git://git.kernel.org/pub/scm/gitk/gitk.git, for
instance? :)  That is the primary repository for gitk and it seems to
be what Alexander bases his patches on.

Paul.
