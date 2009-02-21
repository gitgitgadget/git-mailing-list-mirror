From: Nicolas Pitre <nico@cam.org>
Subject: Re: whitespace checking in git-add?
Date: Sat, 21 Feb 2009 14:26:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902211424490.5511@xanadu.home>
References: <20090220230454.GA10112@foursquare.net>
 <alpine.LFD.2.00.0902202109010.5511@xanadu.home>
 <fabb9a1e0902210321k6bdd8726jea7c930a5a61cce5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Frey <cdfrey@foursquare.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaxVu-0005W2-SO
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbZBUT0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZBUT0W
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:26:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52073 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbZBUT0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:26:22 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFF002SVKNRFAD0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 21 Feb 2009 14:26:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e0902210321k6bdd8726jea7c930a5a61cce5@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110975>

On Sat, 21 Feb 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Sat, Feb 21, 2009 at 03:14, Nicolas Pitre <nico@cam.org> wrote:
> >  2) run 'git rebase -f --whitespace=fix HEAD~'
> 
> Thanks for the plug ;), but you should note that that only works on a
> very recent git. It's not even in master yet, according to [0] it's
> been in next for only 7 days.

Oh, OK...  Still better than a non existing feature.


Nicolas
