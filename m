From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: 'j' and 'k' keyboard shortcuts backward
Date: Sat, 8 Oct 2011 18:04:07 +1100
Message-ID: <20111008070407.GB27056@bloggs.ozlabs.ibm.com>
References: <CA+Jd1rFzOOxL+-JVeovTiOwM5cmyyis65Y1+xiDmG=tkJ3b2Xw@mail.gmail.com>
 <20110919164950.GB2861@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Josh Triplett <josh@joshtriplett.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Robert Suetterlin <robert@mpe.mpg.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 10:04:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCRtN-0006D6-9C
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 10:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1JHIEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 04:04:15 -0400
Received: from ozlabs.org ([203.10.76.45]:42956 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1JHIEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 04:04:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2E1A7B70FF; Sat,  8 Oct 2011 19:04:08 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20110919164950.GB2861@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183140>

On Mon, Sep 19, 2011 at 11:49:50AM -0500, Jonathan Nieder wrote:

> How about this patch?
> 
> -- >8 --
> Subject: gitk: Make vi-style keybindings more vi-like

Thanks, applied, minus the .po file updates.  The translaters seem to
prefer that I leave the .po file updates to them.

Paul.
