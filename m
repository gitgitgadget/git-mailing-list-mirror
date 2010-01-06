From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cmake, was Re: submodules' shortcomings
Date: Wed, 6 Jan 2010 10:24:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001061021370.11013@intel-tinevez-2-302>
References: <4B3F6742.6060402@web.de>  <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>  <4B421F90.4090402@web.de>  <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>  <3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com> 
 <alpine.DEB.1.00.1001060005010.4985@pacific.mpi-cbg.de> <3af572ac1001051717u7757f0dep9392fbb7b02cbbca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSS7o-00037h-RC
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 10:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab0AFJYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 04:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674Ab0AFJYM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 04:24:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:56678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755667Ab0AFJYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 04:24:09 -0500
Received: (qmail invoked by alias); 06 Jan 2010 09:24:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 06 Jan 2010 10:24:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c+V0N95fcZdtg2vnqduc8odf9XQkh1Oi5qB6V9b
	LKvkti50A8b/jk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <3af572ac1001051717u7757f0dep9392fbb7b02cbbca@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136255>

Hi,

On Wed, 6 Jan 2010, Pau Garcia i Quiles wrote:

> On Wed, Jan 6, 2010 at 12:06 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 5 Jan 2010, Pau Garcia i Quiles wrote:
> >
> >> For instance, I'd like to have a 'cmake' repository where I store all 
> >> the FindBlah.cmake modules, so that I can share them from every 
> >> repository, and not worry about users changing and committing in the 
> >> main project instead of the submodule.
> >
> > ... which reminds me... it was you who wanted to provide a working 
> > recipe to compile and install CMake on msysGit, right?
> 
> Right
> 
> > What happened in the meantime?
> 
> What happened is I was very busy until November. Now I've got some free 
> time.
> 
> At this moment, what stops me from beginning this project is a simple 
> question: is it worth my time?

Well, I thought you wanted to show that CMake is superior to what we have 
right now, and for me as msysGit maintainer, that implies that CMake 
actually works within msysGit.

Now, I do not think that it is hard to get CMake to compile in msysGit, 
but then, I just lost access to the last Windows computer, so I cannot do 
that myself.

As Miles said, it is up to you to decide whether it is so complicated, or 
whether CMake is likely not to convince, that the time balance turns out 
positive or negative.

Ciao,
Dscho
