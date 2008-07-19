From: Petr Baudis <pasky@suse.cz>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git
	cloning.
Date: Sat, 19 Jul 2008 20:20:14 +0200
Message-ID: <20080719182014.GD32184@machine.or.cz>
References: <20080719174742.GA4253@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:21:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKH3W-0000pz-JV
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbYGSSUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbYGSSUS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:20:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60906 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbYGSSUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:20:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 40DB2393B489; Sat, 19 Jul 2008 20:20:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080719174742.GA4253@2ka.mipt.ru>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89124>

On Sat, Jul 19, 2008 at 09:47:43PM +0400, Evgeniy Polyakov wrote:
> $ git --version
> git version 1.4.4.4
> 
> Fresh 32bit Debian testing.

Are you sure?  http://packages.debian.org/testing/git-core says

	Package: git-core (1:1.5.6.2-1)

Your sounds more like the Debian stable version.

				Petr "Pasky" Baudis
