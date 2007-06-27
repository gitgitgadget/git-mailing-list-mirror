From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is it possible to "graft" a series of commits into/onto an
 existing repository?
Date: Wed, 27 Jun 2007 14:47:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706271446310.4438@racer.site>
References: <e2a1d0aa0706270625o538bff7dib81802f000592e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:52:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Xx4-0005es-AK
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbXF0Nw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXF0Nw4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:52:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:51767 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752130AbXF0Nwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:52:55 -0400
Received: (qmail invoked by alias); 27 Jun 2007 13:52:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 27 Jun 2007 15:52:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0v3pV2Dq0X8gml1rC0/Wks7gvPkf2T/63iPScb6
	6Oab+fNgoK8qFd
X-X-Sender: gene099@racer.site
In-Reply-To: <e2a1d0aa0706270625o538bff7dib81802f000592e51@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51042>

Hi,

On Wed, 27 Jun 2007, Patrick Doyle wrote:

> I have an empty directory, managed by git and I want to graft another
> (git) repository onto it, such that that history is maintained.  Is
> this possible?

Yes. See Documentation/repository-layout.txt for more (look for 
info/grafts).

Hth,
Dscho
