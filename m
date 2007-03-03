From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cygwin and git 1.5.0
Date: Sat, 3 Mar 2007 19:40:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031938310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E9BEE6.8000506@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZ9r-00046S-S8
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbXCCSkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbXCCSkI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:40:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:55113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030370AbXCCSkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 13:40:07 -0500
Received: (qmail invoked by alias); 03 Mar 2007 18:40:05 -0000
X-Provags-ID: V01U2FsdGVkX196DkhDaEx6fs0f5z9PVRtTo62p9n3MG+phbfb/bV
	0u0E6o0qLjx9QL
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E9BEE6.8000506@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41313>

Hi,

On Sat, 3 Mar 2007, Ramsay Jones wrote:

> As I note in the [PATCH 2/6] email, I should have deleted that setting 
> from the Makefile, rather than commenting it out, but I didn't have the 
> energy to re-do all the commits/emails. ;-)

In these cases, I (carefully) edit the diffs. In your case, I would have 
deleted the line starting with "+", and would have decreased the last 
number on the line starting with "@@" by 1.

Hth,
Dscho
