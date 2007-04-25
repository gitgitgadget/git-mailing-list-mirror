From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Feature Request] Download transfer rate display
Date: Wed, 25 Apr 2007 09:11:29 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704250909200.12375@xanadu.home>
References: <1177489402.12689.42.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 15:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HghHU-0000bu-OS
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 15:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992564AbXDYNLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 09:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992717AbXDYNLe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 09:11:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24217 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992564AbXDYNLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 09:11:33 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH200I6D1Z7SDD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 09:11:31 -0400 (EDT)
In-reply-to: <1177489402.12689.42.camel@localhost>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45522>

On Wed, 25 Apr 2007, Tim Ansell wrote:

> It would be nice if when downloading git could report the download
> progress (a kb/sec would be really cool).

Yes, actually I had that in mind when I did the progress reporting 
cleanup.  Will do that next time I'm bored.


Nicolas
