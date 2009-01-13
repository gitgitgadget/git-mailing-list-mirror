From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/vim: change URL to point to the latest syntax
	files
Date: Tue, 13 Jan 2009 02:16:24 -0500
Message-ID: <20090113071623.GB12631@coredump.intra.peff.net>
References: <200901130310.26727.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 08:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMdX5-0001VT-JF
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 08:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbZAMHQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 02:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZAMHQ1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 02:16:27 -0500
Received: from peff.net ([208.65.91.99]:49330 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbZAMHQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 02:16:26 -0500
Received: (qmail 20893 invoked by uid 107); 13 Jan 2009 07:16:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Jan 2009 02:16:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2009 02:16:24 -0500
Content-Disposition: inline
In-Reply-To: <200901130310.26727.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105463>

On Tue, Jan 13, 2009 at 03:10:26AM +0100, Markus Heidelberg wrote:

> Vim's SVN repository doesn't offer the latest runtime files, since
> normally they are only updated there on a release. Though currently
> there is no difference between the SVN and HTTP/FTP version of the git
> syntax files.

So their version control _doesn't_ have the latest version, but it is
available on the website? It's not that I don't believe you, but I don't
think I want to know the version control workflow that leads to that.

> -  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitsendemail.vim
> +  http://ftp.vim.org/pub/vim/runtime/syntax/git.vim

Certainly they are nicer looking URLs, and I had just assumed the
originals would be recent-ish version. So:

Acked-by: Jeff King <peff@peff.net>

-Peff
