From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do get a specific version of a particular file?
Date: Wed, 28 Feb 2007 01:36:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280135350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0702280059050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271626410.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCng-0004FS-8y
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbXB1AgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXB1AgF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:36:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:37229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbXB1AgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:36:04 -0500
Received: (qmail invoked by alias); 28 Feb 2007 00:36:01 -0000
X-Provags-ID: V01U2FsdGVkX1+SmoFbxBmSZuKgDfsIfgxPk3VWYUtUTphe0DD738
	JCaw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271626410.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40864>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> On Wed, 28 Feb 2007, Johannes Schindelin wrote:
> > 
> > 	$ git show v1.5.0..v1.5.0.1
> > 
> > is _identical_ to
> > 
> > 	$ git show v1.5.0 v1.5.0.1
> 
> No, it's not.

My fault. Crossed eyes...

Ciao,
Dscho
