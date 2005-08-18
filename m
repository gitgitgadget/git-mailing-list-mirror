From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Subject: [PATCH] Updates to glossary
Date: Thu, 18 Aug 2005 23:36:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508182336240.6724@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508182117160.6210@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508181702051.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 23:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5s48-0005Av-9a
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 23:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVHRVgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVHRVgp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 17:36:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50397 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932470AbVHRVgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 17:36:45 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5291E136A68; Thu, 18 Aug 2005 23:36:44 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3CAB899CE5; Thu, 18 Aug 2005 23:36:44 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2928E99CC9; Thu, 18 Aug 2005 23:36:44 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1DA1136A68; Thu, 18 Aug 2005 23:36:43 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508181702051.23242@iabervon.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Aug 2005, Daniel Barkalow wrote:

> On Thu, 18 Aug 2005, Johannes Schindelin wrote:
> 
> >  tree object::
> > -	An object containing a list of blob and/or tree objects.
> > -	(A tree usually corresponds to a directory without
> > -	subdirectories).
> > +	An object containing a list of file names and modes along with refs
> > +	to the associated blob and/or tree objects. A tree object is
> > +	equivalent to a directory.
> 
> Actually, it contains object names, not refs, to be completely precise.
> (refs would imply an additional indirection.)

Agree.
Dscho
