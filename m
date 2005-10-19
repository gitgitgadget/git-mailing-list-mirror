From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: git-daemon enabled on kernel.org
Date: Wed, 19 Oct 2005 10:35:42 +0200
Organization: Harddisk-recovery.com
Message-ID: <20051019083542.GA31526@harddisk-recovery.com>
References: <43554D4F.7040403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 10:37:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9Qc-0003c5-Sq
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJSIfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVJSIfp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:35:45 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:24362 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932462AbVJSIfo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 04:35:44 -0400
Received: (qmail 32428 invoked by uid 501); 19 Oct 2005 10:35:42 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43554D4F.7040403@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10274>

On Tue, Oct 18, 2005 at 12:30:23PM -0700, H. Peter Anvin wrote:
> After getting gitweb behind mod_cache, the load on kernel.org has gotten 
> down into the tolerable range, so I have enabled git-daemon in an 
> attempt to fix that :)
> 
> The URL, obviously, is git://git.kernel.org/pub/scm/...
> 
> (or, to specify a specific server, git1.kernel.org or git2.kernel.org.)

How do I tell git to change the default repository to pull from?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
