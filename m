From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Tue, 10 Jun 2008 03:39:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100338530.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer>
 <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org> <20080610011913.GA11793@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 04:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5tnu-0000VC-EV
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 04:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFJCko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 22:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbYFJCko
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 22:40:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:59188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751756AbYFJCkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 22:40:43 -0400
Received: (qmail invoked by alias); 10 Jun 2008 02:40:41 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 10 Jun 2008 04:40:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183SUUBXHg3lWG6+dq5d22nFV/E89E0v210vhI/fA
	3civGguFtAeR70
X-X-Sender: gene099@racer
In-Reply-To: <20080610011913.GA11793@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84470>

Hi,

On Mon, 9 Jun 2008, Shawn O. Pearce wrote:

> Likewise "show --dry-run" is nonsense.  What does it mean to show what 
> would show without showing it?  Just show it.  :)

Ah, that clarifies it.

Ciao,
Dscho
