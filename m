From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Basic Zsh completion support
Date: Sat, 18 Mar 2006 17:23:39 +0100
Message-ID: <20060318162339.GA4470@c165.ib.student.liu.se>
References: <20060318145347.15128.85902.stgit@c165> <dbfc82860603180725w2eb3057ey17fa8d9dc746127@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 18 17:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKeDU-00009f-Vf
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 17:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWCRQXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 11:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCRQXq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 11:23:46 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:54934 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751423AbWCRQXp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 11:23:45 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 440344114; Sat, 18 Mar 2006 17:39:46 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FKeDL-00044K-00; Sat, 18 Mar 2006 17:23:39 +0100
To: Nikolai Weibull <now@bitwi.se>
Content-Disposition: inline
In-Reply-To: <dbfc82860603180725w2eb3057ey17fa8d9dc746127@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17700>

On Sat, Mar 18, 2006 at 04:25:04PM +0100, Nikolai Weibull wrote:
> On 3/18/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> >
> > Based on the completion code for quilt in the Zsh distribution.
> 
> Actually, there's an almost-complete implementation in 4.3 already. 
> Written by me nonetheless.  You can take a look and make suggestions
> if you like :-).  I have an updated version to deal with post
> 1.0-changes locally that I'm going to put in Zsh's CVS soon enough.
> 

Oh, I didn't know about that.

<updates zsh>

Very nice! Much better than my crude cut-and-paste work.


Junio: Please don't apply the patch.

- Fredrik
