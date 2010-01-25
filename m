From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/18] rebase -i: For pure fixups, do not start log
 message editor
Date: Mon, 25 Jan 2010 19:38:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001251937310.8733@intel-tinevez-2-302>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUEO-0001Ah-Fs
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab0AYTEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 14:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900Ab0AYTEH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:04:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:57150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753852Ab0AYTEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 14:04:04 -0500
Received: (qmail invoked by alias); 25 Jan 2010 18:38:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 25 Jan 2010 19:38:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19K0a0Yf6dKxUFeyREpI+JB18tFjYbO+SB9BjeZVa
	pqfr9Fvj1JbWBr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137981>

Hi,

On Thu, 14 Jan 2010, Michael Haggerty wrote:

> This patch series is a successor to mh/rebase-fixup, which causes
> "rebase -i" to skip opening the log message editor when processing a
> block of "fixup" commands that does not include any "squash"es.

I knew why I kept this patch series as the last thing I would do before 
going offline: it is real elegantly done.

Ciao,
Dscho
