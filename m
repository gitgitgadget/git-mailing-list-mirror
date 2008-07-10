From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in
 fetch/push output
Date: Fri, 11 Jul 2008 00:25:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110024480.3279@eeepc-johanness>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <1215670403-19191-3-git-send-email-spearce@spearce.org> <200807102056.43912.robin.rosenberg@dewire.com> <200807102217.38459.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4aX-0006RG-Ag
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYGJWZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYGJWZL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:25:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:59946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752278AbYGJWZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:25:10 -0400
Received: (qmail invoked by alias); 10 Jul 2008 22:25:08 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2008 00:25:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Lk+8c80MLb4LpTPeN89sueK1V1/AgWsKlOlnfWn
	ZSOlvDR5lkAlJY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807102217.38459.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88018>

Hi,

On Thu, 10 Jul 2008, Robin Rosenberg wrote:

> >From 99c09cf2321f36eb81043aed2fa6834811ee762b Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Thu, 10 Jul 2008 22:16:19 +0200
> Subject: [PATCH] Avoid password leak from URIIsh

What is this new fashion of sending them headers in the mail body?  Robin, 
I thought you knew better.

Ciao,
Dscho
