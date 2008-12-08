From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ETA for release of gjit 0.4?
Date: Mon, 8 Dec 2008 08:21:23 -0800
Message-ID: <20081208162123.GD31551@spearce.org>
References: <49393BFC.6010606@wellfleetsoftware.com> <200812061947.27905.robin.rosenberg.lists@dewire.com> <493ACAFC.5040605@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9isc-0003Lq-3I
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYLHQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYLHQVY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:21:24 -0500
Received: from george.spearce.org ([209.20.77.23]:46376 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYLHQVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:21:23 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4D67138200; Mon,  8 Dec 2008 16:21:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <493ACAFC.5040605@wellfleetsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102550>

Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>
> I could but maven (and good project release) practices are that a  
> project's release version should be managed by the project and not  
> consumers of the project.
>
> BTW, If there is interest in maveninzing the project I can offer to  
> contribute that change to the project. Just let me know if that is  
> something the project wishes to do.

Have you seen the jgit-maven subdirectory?  It has a jgit/pom.xml
contributed by Imran M Yousuf for exactly this reason.  I think we
also have a Maven distribution site:

  http://code.google.com/p/egit/wiki/ConfiguringMaven

The issue is getting one of the developers to tag and upload a build.
Myself, I don't actually use Maven, so I don't build with it.

-- 
Shawn.
