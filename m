From: Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Tue, 28 Sep 2010 16:38:32 -0700
Message-ID: <20100928233832.GA20224@soprano.nvidia.com>
References: <20100928222332.GA28859@soprano.nvidia.com>
 <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Joe Kain <JKain@nvidia.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 29 01:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0jn3-0006Sc-I7
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 01:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab0I1Xks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 19:40:48 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:7360 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0I1Xks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 19:40:48 -0400
Received: from hqnvupgp02.nvidia.com (Not Verified[172.17.98.15]) by hqemgate03.nvidia.com
	id <B4ca27e040000>; Tue, 28 Sep 2010 16:45:15 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp02.nvidia.com (PGP Universal service);
  Tue, 28 Sep 2010 16:40:47 -0700
X-PGP-Universal: processed;
	by hqnvupgp02.nvidia.com on Tue, 28 Sep 2010 16:40:47 -0700
Received: from soprano.nvidia.com (172.16.173.9) by hqemhub02.nvidia.com
 (172.17.98.27) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 28 Sep
 2010 16:38:33 -0700
Content-Disposition: inline
In-Reply-To: <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157497>

On Tue, Sep 28, 2010 at 03:40:11PM -0700, Brandon Casey wrote:
> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
> > Switching to a detached head prints something like
> > 
> >   HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning
> > 
> > These dots get selected when you double-click on the abbreviated
> > commit hash, which makes it annoying to copy and paste.
> 
> This must be another gnome-terminal/konsole "innovation".
> 
> xterm still does the "right thing"(tm) _and_ it doesn't eat my
> alt keystrokes like alt-b to move the cursor back a word. /rant

How is your xterm configured?  On my stock Ubuntu 9.10 system, it doesn't
do the "right thing"... the dots are selected.  Gvim gets it right.

Also, Alt-B appears to work fine in gnome-terminal.  I don't have Konsole
to try.

-- Aaron
