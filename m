From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:11:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171910390.4991@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5kX-0006Qu-7l
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbZHQRLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326AbZHQRLw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:11:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:54089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756150AbZHQRLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:11:52 -0400
Received: (qmail invoked by alias); 17 Aug 2009 17:11:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 17 Aug 2009 19:11:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DyfBEFyGDXVTWR8Dky5DPK7GS4n/tOPBuawaCdl
	snhvbdaTGEgp4k
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126237>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Add libgit.vcproj to build common library.
> Add git.vcproj to build git program.
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

The commit subject should read "... files", as you add two files, not one.

I hope that somebody else is going to review this patch...

And don't you lack .vcproj files for the non-builtins?

Ciao,
Dscho
