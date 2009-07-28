From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 12:49:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkGA-0001Vz-WE
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 12:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZG1KtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 06:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZG1KtT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 06:49:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:52432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750848AbZG1KtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 06:49:19 -0400
Received: (qmail invoked by alias); 28 Jul 2009 10:49:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 28 Jul 2009 12:49:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+KWo7MLE+fdDzWeJNDfJAjUAf8oDNX9/+OIilGI
	loqGSrNh+jaKOE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124234>

Hi,

On Tue, 28 Jul 2009, Thomas Rast wrote:

> This means that 'git log -g --date=normal' shows the date, whereas 'git 
> log -g --date=default' shows the reflog entry number.

I find this highly unintuitive, sorry.  I'd prefer it if it showed the 
date whenever I specify a date format.  And I'd prefer not to have a 
distinction between "default" and "normal".

Sorry,
Dscho
