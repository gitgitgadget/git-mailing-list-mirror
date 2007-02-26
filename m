From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Merge doc/ and Documentation/ directories.
Date: Mon, 26 Feb 2007 23:14:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262312100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070226220929.12064.98992.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 23:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLo7j-0005NA-QC
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 23:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbXBZWOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbXBZWOf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 17:14:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:33303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161289AbXBZWOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 17:14:34 -0500
Received: (qmail invoked by alias); 26 Feb 2007 22:14:32 -0000
X-Provags-ID: V01U2FsdGVkX1/SjF9HR+zS2JZJnCB5EodxBE0ft5Op3jebk3m8jT
	ymZQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070226220929.12064.98992.stgit@gandelf.nowhere.earth>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40671>

Hi,

On Mon, 26 Feb 2007, Yann Dirson wrote:

>  Documentation/tutorial.txt  |  413 +++++++++++++++++++++++++++++++++++++++++++
>  doc/tutorial.txt            |  413 -------------------------------------------
>
> [...]
> 
> diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
> new file mode 100644
> index 0000000..5899c38

AFAICT the diff option "--no-renames" can override "-M", so why turn "-M" 
on by default for format-patch and show?

Ciao,
Dscho
