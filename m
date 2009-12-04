From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes
	at once
Date: Fri, 4 Dec 2009 23:07:30 +0100
Message-ID: <20091204220730.GB3979@book.hvoigt.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <20091029073454.GA25843@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Epler <jepler@unpythonic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGgJn-0000ql-Lc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 23:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZLDWHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZLDWH2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 17:07:28 -0500
Received: from darksea.de ([83.133.111.250]:32902 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbZLDWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 17:07:26 -0500
Received: (qmail 29105 invoked from network); 4 Dec 2009 23:07:30 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 4 Dec 2009 23:07:30 +0100
Content-Disposition: inline
In-Reply-To: <20091029073454.GA25843@m62s10.vlinux.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134579>

Hi,

On Thu, Oct 29, 2009 at 08:34:54AM +0100, Peter Baumann wrote:
> On Wed, Oct 21, 2009 at 04:20:21PM -0500, Jeff Epler wrote:
> > 
> > Jeff Epler (2):
> >   Fix applying a line when all following lines are deletions
> >   Make it possible to apply a range of changes at once
> > 
> >  git-gui.sh   |   15 +++-
> >  lib/diff.tcl |  224 ++++++++++++++++++++++++++++++++--------------------------
> >  2 files changed, 135 insertions(+), 104 deletions(-)
> 
> Cc ing Shawn as the git gui maintainer, as he might have missed this series
> during his away time.
> 
> The original series including user comments can be found at
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/130732
> 
> whereas the newest version is here:
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/130968

Ping? A short reminder for Shawn as I do not see the patches in his
tree.

cheers Heiko
