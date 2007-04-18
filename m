From: Nicolas Pitre <nico@cam.org>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 13:50:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181346440.4504@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home>
 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
 <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <17958.19499.813637.324723@lisa.zopyra.com> <vpqejmhy3x2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEIE-00039A-JU
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992953AbXDRRuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992956AbXDRRuF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:50:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22731 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992953AbXDRRuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 13:50:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP00G7QG7FW700@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 13:50:03 -0400 (EDT)
In-reply-to: <vpqejmhy3x2.fsf@bauges.imag.fr>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44921>

On Wed, 18 Apr 2007, Matthieu Moy wrote:

> Then, I can't even find it in the tutorial, but somewhere, it should
> be mentionned to say who I am in ~/.gitconfig.

One of the very first thing you can find in Documentation/tutorial.txt 
is:

	It is a good idea to introduce yourself to git with your name and
	public email address before doing any operation.  The easiest
	way to do so is:

	------------------------------------------------
	$ git config --global user.name "Your Name Comes Here"
	$ git config --global user.email you@yourdomain.example.com
	------------------------------------------------


Nicolas
