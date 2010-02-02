From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH] gitk: Add shortcut Ctrl-W for closing the active window
Date: Tue, 2 Feb 2010 18:51:46 -0500
Message-ID: <20100202235146.GA13176@foursquare.net>
References: <4B68A310.6000807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 01:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcT5z-0005fF-JU
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 01:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab0BCA04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 19:26:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47969 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab0BCA0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 19:26:55 -0500
X-Greylist: delayed 2086 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 19:26:55 EST
X-Originating-Ip: 216.16.235.2
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id o12Npklc013386;
	Tue, 2 Feb 2010 18:51:46 -0500
Content-Disposition: inline
In-Reply-To: <4B68A310.6000807@web.de>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138793>

On Tue, Feb 02, 2010 at 11:11:28PM +0100, Jens Lehmann wrote:
> To make the user experience between git gui and gitk more homogeneous, use
> Ctrl-W in gitk too for closing the active window. When closing the main
> window doquit is called for proper cleanup.

This is sort of like when Mozilla claims Ctrl-U to show the page source,
and you're expecting it to clear the line.

At least in Mozilla, you can configure the browser to respect the
old meanings for Ctrl-U, etc.

- Chris
