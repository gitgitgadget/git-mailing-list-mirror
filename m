From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some guilt fixes
Date: Sun, 7 Jan 2007 01:16:50 -0500
Message-ID: <20070107061650.GD22162@filer.fsl.cs.sunysb.edu>
References: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 07:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3RLH-0001u8-RX
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 07:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbXAGGRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 01:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAGGRF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 01:17:05 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45091 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbXAGGRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 01:17:04 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:56TL/mpAWWCQAeMThpwF5f59PShA8zAi@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l076Gp5K007040;
	Sun, 7 Jan 2007 01:16:51 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l076GpoY007038;
	Sun, 7 Jan 2007 01:16:51 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36130>

On Sat, Jan 06, 2007 at 11:04:50PM -0300, Horst H. von Brand wrote:
> 
> The following two patches clean guilt up a bit.
> The first one cleans up the Makefiles, the second one
> runs the tests on the files at hand, not the installed ones
> (if they exist at all).
 
Thanks!
 
> Please consider placing a file giving contact information (and how to
> participate in its development) under Documentation.

Good point.

> I understand you have to point explicitly at the COPYING file in each
> of the files in the package to make the license stick. Please check
> this.

That makes sense.

Thanks a bunch, and congratulations to being the first Guilt contributor. :)

Josef "Jeff" Sipek.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
