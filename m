From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] A simple python script to parse the results from
 the testcases
Date: Mon, 12 May 2008 14:00:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121400200.30431@racer>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>  <1210584832-16402-3-git-send-email-srabbelier@gmail.com>  <m3hcd34ynv.fsf@localhost.localdomain> <bd6139dc0805120316oe704c8ek149d37552d72ab30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	dsymonds@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 15:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvXfm-0007hs-B3
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 15:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYELNBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 09:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758078AbYELNBS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 09:01:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:39768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754660AbYELNBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 09:01:05 -0400
Received: (qmail invoked by alias); 12 May 2008 13:01:00 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp023) with SMTP; 12 May 2008 15:01:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/wXRs2+V/QQ7xzcdSNwIJTI5HGSwSAItMB/IXS2
	jkvZnRr+QGRHBv
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0805120316oe704c8ek149d37552d72ab30@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81859>

Hi,

On Mon, 12 May 2008, Sverre Rabbelier wrote:

> On Mon, May 12, 2008 at 12:14 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Or Perl, as Perl was created for that.  I'd rather don't reintroduce 
> > Python dependency...
> 
> I'm sure Perl would work just fine, except that I'm not good with Perl 
> either. If anyone feels like writing up something in Perl I'd be happy 
> to test it and send in a new patch with the Perl script.

Umm.  Perl cannot be so difficult as to reintroduce the dependency.  
Remember: msysGit comes _without_ Python.

Ciao,
Dscho
