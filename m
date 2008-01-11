From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 13:03:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIc3-0002mJ-Fg
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 13:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbYAKMDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757991AbYAKMDW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 07:03:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:55868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757973AbYAKMDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 07:03:21 -0500
Received: (qmail invoked by alias); 11 Jan 2008 12:03:19 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp043) with SMTP; 11 Jan 2008 13:03:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7Qo4M0qf7kkLPD0rfNAYTZYHch3429TzVly3qJw
	fPU8ag3Wy3iyBK
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70149>

Hi,

On Thu, 10 Jan 2008, Mark Levedahl wrote:

> git's current support for remote nicknames other than
> "origin" is restricted to tracking branches where
> branch.<name>.remote is defined.

IIUC your patch only replaces the term "origin" by something 
user-specifiable.  I fail to see the use of it; care to explain what 
workflow is easier with your patches than without?

Ciao,
Dscho
