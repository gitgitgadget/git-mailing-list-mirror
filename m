From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 20 Mar 2010 11:48:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>  <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 11:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NswDe-0000yh-9q
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 11:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0CTKre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 06:47:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:32908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980Ab0CTKrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 06:47:33 -0400
Received: (qmail invoked by alias); 20 Mar 2010 10:47:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 20 Mar 2010 11:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Y27pAvvjYd1iTcFFd76PCG/gxGAzwtTEUyzLSlN
	/O7d0bh1MHH5SK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142701>

Hi,

On Fri, 19 Mar 2010, Avery Pennarun wrote:

> On Fri, Mar 19, 2010 at 2:39 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > On Fri, Mar 19, 2010 at 19:32, Avery Pennarun <apenwarr@gmail.com> wrote:
> >> - all those "extra commands" that git-svn supports are considered
> >> backwards compatibility, even if they're absolutely obsolete because
> >> of newer commands, and therefore will be very hard to justify getting
> >> rid of
> >
> > I don't think this is true. The proposal is to implement
> > git-remote-svn, which would allow _native_ interaction with svn
> > repositories, so without using 'git svn'. It would allow 'git clone
> > svn://example.com/myrepo' and subsequent "git pull"s from that svn
> > source. Do you agree that makes (part of) your comments moot, or am I
> > missing something?
> 
> I don't know enough about the proposal to comment on this part of the 
> design.

How about reading it? It's on the Wiki.

Ciao,
Dscho
