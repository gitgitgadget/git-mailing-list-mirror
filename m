From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix example in git-name-rev documentation
Date: Mon, 1 Sep 2008 13:07:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809011306550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48B9A2C7.3080001@dgreaves.com> <7v7i9ygt4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 13:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka7Bn-0006x5-7c
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 13:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYIALBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYIALBx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 07:01:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:33469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752742AbYIALBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 07:01:52 -0400
Received: (qmail invoked by alias); 01 Sep 2008 11:01:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 01 Sep 2008 13:01:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195bU0jlSZ5abGOOkkXvosVNWeBXhakMotq7/esRz
	0Ks4EdXFjAhBAn
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v7i9ygt4x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94573>

Hi,

On Sat, 30 Aug 2008, Junio C Hamano wrote:

> Since 59d3f54 (name-rev: avoid "^0" when unneeded, 2007-02-20), name-rev
> stopped showing an unnecessary "^0" to dereference a tag down to a commit.
> The patch should have made a matching update to the documentation, but we
> forgot.

ACK & sorry,
Dscho
