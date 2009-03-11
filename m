From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 21:37:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com> <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 21:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhVC7-0002r7-Mq
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZCKUgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZCKUgP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:36:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:59780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751858AbZCKUgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 16:36:14 -0400
Received: (qmail invoked by alias); 11 Mar 2009 20:36:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 11 Mar 2009 21:36:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SAOI692kS+KTzUagDgYywcth1jwEemHwKo8dVLw
	X6swvIgE6zBN/0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112976>

Hi,

On Wed, 11 Mar 2009, david@lang.hm wrote:

> there are two types of helpers that can be written
> 
> 1. a low-level part that does the simple merges automaticaly and leaves 
>    behind appropriate conflict markers when it can't
> 
> [...]
> 
> 
> 2. after a conflict has taken place, a helper to work with the user to 
>    resolve the conflict

I thought that from my description on the wiki it was obvious that both 
are needed.

Ciao,
Dscho
