From: nadim khemir <nadim@khemir.net>
Subject: Re: git workshop in Sweden/Denmark
Date: Sun, 23 Nov 2008 19:48:26 +0100
Message-ID: <200811231948.26623.nadim@khemir.net>
References: <200811191858.21990.nadim@khemir.net> <4925257F.9060900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 19:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4K18-000521-9N
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 19:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYKWSrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYKWSrq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 13:47:46 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:42850 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752292AbYKWSrp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 13:47:45 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 9BFDD940027
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:47:41 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 833371264ECF
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:47:41 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4925257F.9060900@op5.se>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101572>

On Thursday 20 November 2008 09.53.19 Andreas Ericsson wrote:
> > Lund.pm and Data-foreningen are trying to organize a 'git' workshop.
> > - Can you be :
> >         - a speaker
> >         - a sponsor
>
> I've been speaking enough on oss conferences this year and feel I don't
> have time to spend on making slides and preparing for another conference,
> but I'd love to attend and can almost certainly help out on the workshop
> if needed.

Helping at the workshop is even better than having a talk. This is supposed to 
be hands on to help people learn git and fix problems they have.

> > - If you come, what would you like to learn, discuss?
>
> I'm primarily interested in finding developers that want to integrate git
> with other applications, such as IDE's. I need to know what they would
> need from a git library so I can properly prioritize the different todos
> for libgit2.
As you may have seen in my other mail, I will be taking over the maintenance 
of Git.pm and related perl modules. Having a Perlm module based on the 
functionality of libgit is in my plans. I've tried to follow the discussion 
around libgit (specially the re-licensing discussion) and I will certainly 
try to be actively listening to what happends there.

As for the integration in IDEs. How's the integration in Eclipse? There are 
two perl projects that may give you input. Padre and Kephra.

Cheers, Nadim
