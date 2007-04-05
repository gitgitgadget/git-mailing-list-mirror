From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to
 control pack size
Date: Thu, 05 Apr 2007 11:52:05 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704051147050.28181@xanadu.home>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
 <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
 <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
 <alpine.LFD.0.98.0704042203160.28181@xanadu.home>
 <20070405071511.GE5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZUG4-0007ZG-6P
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767115AbXDEPwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767117AbXDEPwR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:52:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767115AbXDEPwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:52:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG100G3F82THP10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 11:52:06 -0400 (EDT)
In-reply-to: <20070405071511.GE5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43837>

On Thu, 5 Apr 2007, Shawn O. Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 4 Apr 2007, Dana How wrote:
> > > I have a similar but much weaker reaction, but Linus specifically asked for
> > > this combination to work.
> > 
> > Linus is a total imcompetent who knows nothing about programming or good 
> > taste.  So never ever listen to what he says.  He is wrong, always.
> 
> Now now, I wouldn't go that far...

There was a well meant smiley along with my diatribe of course.


Nicolas
