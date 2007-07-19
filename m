From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 15:32:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707191531330.22541@xanadu.home>
References: <11848281302504-git-send-email-aroben@apple.com>
 <200707190848.54655.andyparkins@gmail.com>
 <95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbjv-0000SI-24
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938441AbXGSTck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938436AbXGSTck
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:32:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63001 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbXGSTci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:32:38 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLF00I1LYADEU40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Jul 2007 15:32:38 -0400 (EDT)
In-reply-to: <95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53026>

On Thu, 19 Jul 2007, Brian Gernhardt wrote:

> For many people commit is more "core" to their git usage than write-tree and
> commit-tree.  At this point, it's less an extra layer porcelain and more the
> standard interface.  It's a result of the wonderful attempts to make git more
> user friendly.
> 
> As far as [core] being only for plumbing, I disagree with that premise as
> well.  Any option that is used across many of the git commands is a core
> (meaning central) option.

That pov certainly makes sense to me.


Nicolas
