From: Nicolas Pitre <nico@cam.org>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 01:14:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706200113020.20596@xanadu.home>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
 <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
 <46a038f90706192120q6c64a854re589f27b3bdbc0d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 07:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0sWp-0008JE-7j
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 07:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759078AbXFTFOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 01:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbXFTFOt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 01:14:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36215 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806AbXFTFOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 01:14:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJX00JZZ58O9OF0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jun 2007 01:14:48 -0400 (EDT)
In-reply-to: <46a038f90706192120q6c64a854re589f27b3bdbc0d5@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50534>

On Wed, 20 Jun 2007, Martin Langhoff wrote:

> OTOH, as a workaround, it _should_ work if I force a repack on the
> usb-repo after each push, right? It'll wear the USB disk out, waste
> human+cpu time and kill some kittens along the way, but it'll do for
> the time being.

Right.  And you don't need to use -f with git-repack for it to work.


Nicolas
