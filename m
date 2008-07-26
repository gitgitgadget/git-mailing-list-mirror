From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] Migrate rebase-i to sequencer
Date: Sat, 26 Jul 2008 16:52:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261652050.26810@eeepc-johanness>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <1217049644-8874-4-git-send-email-s-beyer@gmx.net> <1217049644-8874-5-git-send-email-s-beyer@gmx.net>
 <1217049644-8874-6-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMl8J-0005kI-N9
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbYGZOvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYGZOvb
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:51:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:55449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751954AbYGZOvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:51:31 -0400
Received: (qmail invoked by alias); 26 Jul 2008 14:51:29 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp066) with SMTP; 26 Jul 2008 16:51:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uTlkFRBuu+jf5Bjqb7sPIpU7kmqZom2SzJ2dQo1
	3c8fQlfU2qThCW
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217049644-8874-6-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90231>

Hi,

On Sat, 26 Jul 2008, Stephan Beyer wrote:

> For git-rebase-i -p (preserving merges) merges should be
> rewritten. For this, the sequencer instructions "mark", "merge"
> and "reset" are used.

Ah, the ugliness returns.

Ciao,
Dscho
