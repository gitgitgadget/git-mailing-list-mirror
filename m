From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 11:26:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
 <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com> <20100320210406.GA29899@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 11:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIMh-0000Gt-VX
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab0CUK0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 06:26:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752770Ab0CUK0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:26:24 -0400
Received: (qmail invoked by alias); 21 Mar 2010 10:26:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 21 Mar 2010 11:26:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZAMUGBSvZTLH73VI1BAf2pFYBd/bgU8uZl7DasQ
	jZyGndS4DV9MNA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100320210406.GA29899@progeny.tock>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142795>

Hi,

On Sat, 20 Mar 2010, Jonathan Nieder wrote:

> Ramkumar Ramachandra wrote:
> 
> > == Timeline ==
> 
> The one thing I worry about is that you are proposing to wait a while 
> before submitting your changes upstream.  I would suggest pushing 
> whatever pieces work to contrib/ early on to get more feedback from 
> reviewers and testers.  (I am saying this selfishly, as a potential 
> tester.)

I would rather have frequent updates about the progress on the mailing 
list, and a long-running branch in which the code is developed, only 
rebasing to Junio's next/pu when absolutely necessary.

After all, it would be additional work to put it first into contrib/ and 
then to integrate it fully into git.git.

Ciao,
Dscho
