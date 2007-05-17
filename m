From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 16:38:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705171633440.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <20070517124006.GO4489@pasky.or.cz> <20070517202655.GB3079@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu May 17 22:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HomkV-0005BO-Ew
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbXEQUiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbXEQUiw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:38:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59619 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXEQUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 16:38:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI700LJCDCHZ1K0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 16:38:43 -0400 (EDT)
In-reply-to: <20070517202655.GB3079@efreet.light.src>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47555>

On Thu, 17 May 2007, Jan Hudec wrote:

> A particular case would be a group of students wanting to publish their
> software project (I mean the PRG023 or equivalent). Private computers in the
> hostel are not allowed to serve anything, so they'd use some of the lab
> servers (eg. artax, ss1000...). All of them allow full CGI, but running
> daemons is forbiden.

And wouldn't the admin authority for those lab servers be amenable to 
install a Git daemon service?  That'd be a much better solution to me.


Nicolas
