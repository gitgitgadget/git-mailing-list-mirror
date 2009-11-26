From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII
 characters
Date: Thu, 26 Nov 2009 15:47:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911261546350.7500@intel-tinevez-2-302>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com> <20091126005423.GM11919@spearce.org> <4B0E7DF5.9040007@syntevo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 15:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDfdF-0007Sj-UA
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 15:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbZKZOr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 09:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbZKZOr1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 09:47:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:42756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754520AbZKZOr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 09:47:26 -0500
Received: (qmail invoked by alias); 26 Nov 2009 14:47:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 26 Nov 2009 15:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184hOEe/rY4sKatEXHYMDZ309x2aL5mVh8l0BIfZr
	ttVysqY/ZipUQO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B0E7DF5.9040007@syntevo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133798>

Hi,

On Thu, 26 Nov 2009, Thomas Singer wrote:

> [someone said, Thomas did not say who]
>
> > But as you said, this still doesn't make the Apple normal form any 
> > easier.  Though if we know we are on such a strange filesystem we 
> > might be able to assume the paths in the repository are equally 
> > damaged.  Or not.
> 
> Well, if the git-core folks could standardize on, e.g., composed UTF-8 
> (rather then just UTF-8), for storing file names in the repository, then 
> everything should be clear, isn't it?

You mean we should do the same thing as Apple with HFS?  Are you serious?

Ciao,
Dscho
