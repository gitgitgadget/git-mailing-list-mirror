From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 21:44:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOK2p-0007Sa-Ut
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 21:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXCEUo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 15:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbXCEUo2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 15:44:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:45978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932368AbXCEUo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 15:44:27 -0500
Received: (qmail invoked by alias); 05 Mar 2007 20:44:26 -0000
X-Provags-ID: V01U2FsdGVkX1+Yk5BYkVKY12FTWX+jGsAqa0okLn2gyGT90GaB1U
	QxRIFAqtCQQNoi
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17900.30394.172067.743310@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41484>

Hi,

On Mon, 5 Mar 2007, Bill Lear wrote:

> On Monday, March 5, 2007 at 20:16:35 (+0100) Johannes Schindelin writes:
>
> >If somebody (might be even you yourself) pushes into your repo, under 
> >the name of the branch to which you switch back to right after that. 
> >Bingo. Files changed.
> 
> Yes, they change, and so would the timestamp.  So what?

Think about it. Why would the timestamp change? Because Git wrote the 
file? But that was exactly the behaviour you were complaining about.

Ciao,
Dscho
