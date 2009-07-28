From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 12:51:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281250390.8306@pacific.mpi-cbg.de>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:52:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkHo-0002Pn-GX
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 12:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZG1KvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZG1KvX
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 06:51:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:38452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751882AbZG1KvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 06:51:23 -0400
Received: (qmail invoked by alias); 28 Jul 2009 10:51:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 28 Jul 2009 12:51:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jwr8YkdWjOpVGkrKkujSCXKkIx13h3eB0WcvV8/
	pMLKke5o+/NHN8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124235>

Hi,

On Tue, 28 Jul 2009, Johannes Schindelin wrote:

> And I'd prefer not to have a distinction between "default" and "normal".

IOW I like the DATE_UNSPECIFIED idea (that we talked about on IRC) better.

Ciao,
Dscho
