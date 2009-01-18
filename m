From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git-resurrect: find traces of a branch name and
 resurrect it
Date: Sun, 18 Jan 2009 17:19:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181718370.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de> <1232242703-19086-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOaOE-00048W-7X
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbZARQTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758230AbZARQTR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:19:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758700AbZARQTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:19:16 -0500
Received: (qmail invoked by alias); 18 Jan 2009 16:19:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 18 Jan 2009 17:19:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UWtczFA0UBqOcfVB9Za+6G/XoR2k2OAwECv38M9
	6vBCNE0LglQj8a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232242703-19086-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106238>

Hi,

On Sun, 18 Jan 2009, Thomas Rast wrote:

>  Makefile         |    1 +
>  git-resurrect.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++

Maybe have it in contrib/ instead?

Ciao,
Dscho
