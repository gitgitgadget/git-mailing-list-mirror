From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [OFF TOPIC] any views about the D programming language
Date: Thu, 26 Jun 2008 12:15:00 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261210120.9925@racer>
References: <48635047.30707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:18:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpUi-000601-0Q
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYFZLRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbYFZLRF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:17:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:39774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752162AbYFZLRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:17:04 -0400
Received: (qmail invoked by alias); 26 Jun 2008 11:17:00 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp030) with SMTP; 26 Jun 2008 13:17:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sMTVsezNsyRH6cBGyVEiFQk84sq9Oy0FZGJW2Df
	Q1FYzHXmgYDPKC
X-X-Sender: gene099@racer
In-Reply-To: <48635047.30707@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86432>

Hi,

On Thu, 26 Jun 2008, Ittay Dror wrote:

> I've read the language war thread (C vs C++) and I'm wondering if 
> someone would like to share their views about using D instead of C.

I would like to ;-)

This is open source.  You are free to do what you want to do.  You are 
even welcome to do so.

Just do not expect many people to be able to comment on your work, let 
alone be enthusiastic to use it, if you use an obscure language.

Just take Tcl as an example: it is not exactly obscure, has been around 
for ages, and many commercial programs actually use it as a scripting 
language.

Yet, there are preciously few people who _ever_ contributed anything to 
gitk or git-gui, and you hear that the main reason is the language.

OTOH C is a common denominator, educates its users to exercise lots of 
circumspection (which means that those users will invariably write less 
buggy code, even using other languages), and the code in Git is already 
written in it.  So why not stop bitching and just continue using it?

Ciao,
Dscho
