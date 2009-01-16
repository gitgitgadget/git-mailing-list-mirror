From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit.c: do not remove COMMIT_EDITMSG
Date: Fri, 16 Jan 2009 22:15:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162214550.3586@pacific.mpi-cbg.de>
References: <1232134805-19597-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 22:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNw2y-0001DJ-79
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 22:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416AbZAPVOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 16:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758173AbZAPVOo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 16:14:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:47429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755124AbZAPVOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 16:14:43 -0500
Received: (qmail invoked by alias); 16 Jan 2009 21:14:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 16 Jan 2009 22:14:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O4KNyVMTOgFNv9e4S5EoROeUDZ6XTfM2Rarr/VN
	78JDGSuZ5FO8Xw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232134805-19597-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105998>

Hi,

On Fri, 16 Jan 2009, Stephan Beyer wrote:

> This patch just removes the removal of COMMIT_EDITMSG.

LOL.  Let's hope we will not need a patch removing the remove of the 
removal.

Ciao,
Dscho
