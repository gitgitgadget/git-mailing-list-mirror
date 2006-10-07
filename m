From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 7 Oct 2006 19:32:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
 <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
 <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
 <eg82tq$2uq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 19:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWG2L-0003EN-Er
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 19:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWJGRc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWJGRc1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 13:32:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:64933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932398AbWJGRc1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 13:32:27 -0400
Received: (qmail invoked by alias); 07 Oct 2006 17:32:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 07 Oct 2006 19:32:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eg82tq$2uq$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28488>

Hi,

On Sat, 7 Oct 2006, Jakub Narebski wrote:

> Perhaps use undocumented (hint, hint! for whoever did code this)
> per-user ~/.gitconfig?

A good idea to use this (hint, hint! whoever finds out how it works can 
document it as well) feature.

HOWEVER, Junio pointed out that he'd like a finer grain than per-repo, and 
.gitconfig is a coarser one! (BTW why do you strip Junio from your Cc: 
when you respond directly to his email?)

Ciao,
Dscho
