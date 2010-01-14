From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 11:31:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de>
References: <op.u6g8jnixg402ra@nb-04> <20100114154154.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:26:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVMu6-0002Sn-BL
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 11:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab0ANK0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 05:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528Ab0ANK0J
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 05:26:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:60205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755158Ab0ANK0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 05:26:08 -0500
Received: (qmail invoked by alias); 14 Jan 2010 10:26:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 14 Jan 2010 11:26:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EYhYhtUBEqhjC3ar4lOUESSPzEdDFOBYWAgQNNS
	DxdEG638qYqmGe
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100114154154.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136980>

Hi,

On Thu, 14 Jan 2010, Nanako Shiraishi wrote:

> Quoting Rudolf Polzer <divVerent@alientrap.org>
> 
> > I'd like a feature to automatically "transform" a non-tracking local
> > branch into a tracking branch on push. A patch to do that is attached.
> 
> How well does this take earlier discussions on the same topic into account? For example, did you study the design discussion in
>   http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=135390

Thank you for looking up that reference.

Do you remember what the outcome was?  (Peff mentioned that there was some 
talk about putting this code into transport.c and some needed 
restructurings, but I do not remember the details, and I did not have time 
to follow the development of that file in the recent months.)

Ciao,
Dscho
