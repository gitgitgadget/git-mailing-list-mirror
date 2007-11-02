From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New script: git-changelog.perl
Date: Fri, 2 Nov 2007 18:27:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711021821410.4362@racer.site>
References: <67837cd60711020855v5badf7a6o9b777f339df070f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:29:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1GQ-0003Wb-7q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbXKBS2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbXKBS2L
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:28:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:37267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755450AbXKBS2K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:28:10 -0400
Received: (qmail invoked by alias); 02 Nov 2007 18:28:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 02 Nov 2007 19:28:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I12w8d8uIszHgz2ZiaSsPPi6OmxseWTH/oQe9Ks
	38LhxbNcUCJ0qV
X-X-Sender: gene099@racer.site
In-Reply-To: <67837cd60711020855v5badf7a6o9b777f339df070f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63151>

Hi,

On Fri, 2 Nov 2007, Ronald Landheer-Cieslak wrote:

> I've written a little script that will format the changes as reported
> by git-log in a ChangeLog-like format.

Jakub already commented on the availability of git2cl, but I thought I'd 
clarify: once upon a time I even wrote some builtin to perform that 
transformation, and it was met with unilateral disgus^Wagreement not to 
include it into core git.

Therefore I think it would be sanest to enhance git2cl until it does what 
you want to do.

Ciao,
Dscho
