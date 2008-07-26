From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git sequencer prototype
Date: Sat, 26 Jul 2008 16:19:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMkc7-0002i6-Rk
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYGZOSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYGZOSP
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:18:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:57299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbYGZOSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:18:14 -0400
Received: (qmail invoked by alias); 26 Jul 2008 14:18:13 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp025) with SMTP; 26 Jul 2008 16:18:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SHpoiCMhSJnWz91zgvlDLVVFbwBlQw8hve8aTDA
	4bd0UmQOdJDwZH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90227>

Hi,

On Sat, 26 Jul 2008, Stephan Beyer wrote:

> In the last patchset I mentioned the issue, that the prototype is slow
> as hell.  I know some bottlenecks, but I have not even tried to change
> that, because this is no issue for the builtin.

Why is it no issue for the builtin?  Is it so much different from the 
prototype?

Personally, I think if the prototype is so much slower, there is no sense 
applying it into git.git, but I'd rather see you work on the builtin and 
finalize it.

Ciao,
Dscho
