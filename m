From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add git-index-pack -l to list objects in a pack
Date: Wed, 06 Jun 2007 09:55:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706060952410.12885@xanadu.home>
References: <11811227811793-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvvz2-0003o5-HX
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 15:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXFFNzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 09:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbXFFNzX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 09:55:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbXFFNzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 09:55:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJ700H0IW06FIW0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Jun 2007 09:55:19 -0400 (EDT)
In-reply-to: <11811227811793-git-send-email-sam.vilain@catalyst.net.nz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49288>

On Wed, 6 Jun 2007, Sam Vilain wrote:

> I couldn't figure out how to make git-unpack-objects -n work.
> But it seems to be easy in the loop in index-pack

Why don't you simply use git-show-index?


Nicolas
