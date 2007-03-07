From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker --boundary: show boundaries again
Date: Wed, 7 Mar 2007 01:00:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703070058240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703061252110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeanffi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjZs-0003lj-HQ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030742AbXCGAAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030743AbXCGAAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:00:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:37773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030742AbXCGAAP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:00:15 -0500
Received: (qmail invoked by alias); 07 Mar 2007 00:00:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 07 Mar 2007 01:00:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LJfhIkBeLpRGBTKqys6wbI74jO1bH/NzbLcluxX
	XHSt/8SAh3TET6
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xeanffi.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41624>

Hi,

On Tue, 6 Mar 2007, Junio C Hamano wrote:

> Thanks.
> 
> I noticed the breakage after those 4 series and have two fixups
> near the tip of 'next', namely 8839ac94.  Does it not work for
> you?

Yes, but I got those commits only _after_ I sent the patch.

Anyway, I saw that it broke when I was trying to make really, really sure 
that bundles worked as expected, by writing a strict test case.

Ciao,
Dscho
