From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make cherry-pick use rerere for conflict resolution.
Date: Mon, 11 Aug 2008 01:12:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218368935-31124-1-git-send-email-ams@toroid.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSK1d-0001t5-R2
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbYHJXHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbYHJXHg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:07:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:48294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752104AbYHJXHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:07:35 -0400
Received: (qmail invoked by alias); 10 Aug 2008 23:07:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 11 Aug 2008 01:07:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XBSgn2JfXlWD4QNP/79PyG2lq6JPFgmoQ7xjh9Z
	66/IfdB6NCYNAy
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218368935-31124-1-git-send-email-ams@toroid.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91899>

Hi,

On Sun, 10 Aug 2008, Abhijit Menon-Sen wrote:

> Trivial change plus test, as requested by Johannes Schindelin.

I would have preferred some convincing rationale for the change instead.

Ciao,
Dscho
