From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: your mail
Date: Fri, 20 Oct 2006 16:42:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201638510.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1GavIN-0007Vi-00@dvr.360vision.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavZl-0001wc-Km
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946361AbWJTOmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946411AbWJTOmR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:42:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:34258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946361AbWJTOmR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:42:17 -0400
Received: (qmail invoked by alias); 20 Oct 2006 14:42:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 20 Oct 2006 16:42:15 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: andyparkins@gmail.com
In-Reply-To: <E1GavIN-0007Vi-00@dvr.360vision.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29480>

Hi,

your email is horridly mixed here. I get an empty subject here, and the 
complete email header at the beginning of the email:

On Fri, 20 Oct 2006, andyparkins@gmail.com wrote:

> >From 9c128bc4b9b85385b7b98ceae0c89283d70e5d45 Mon Sep 17 00:00:00 2001
> From: Andy Parkins <andyparkins@gmail.com>
> [... complete email header including MIME header ...]
> Content-Disposition: inline
> 
> git-send-email doesn't exist; so don't refer to it in the documentation.

But it does! I just removed it, and "make" remade it. I don't even see in 
the Makefile why it should _not_ be made...

Ciao,
Dscho
