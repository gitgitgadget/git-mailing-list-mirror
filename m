From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix regression tests on Cygwin
Date: Tue, 24 Oct 2006 16:53:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610241653020.2106@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11616320733093-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 16:54:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcNew-0004MJ-OE
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 16:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWJXOxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 10:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWJXOxj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 10:53:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:32919 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932433AbWJXOxi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 10:53:38 -0400
Received: (qmail invoked by alias); 24 Oct 2006 14:53:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 24 Oct 2006 16:53:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <11616320733093-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29980>

Hi,

On Mon, 23 Oct 2006, Lars Hjemli wrote:

> On Cygwin, "make test" failes due to missing ".exe" a couple of places.

Last time I made "test" on cygwin, it did not complain. "../git" works 
perfectly here.

Ciao,
Dscho
