From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next] notes: fix core.notesRef documentation
Date: Mon, 12 Jan 2009 15:41:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901121541210.3586@pacific.mpi-cbg.de>
References: <1231769764-17294-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 12 15:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMNzb-0004an-Kk
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 15:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbZALOkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 09:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZALOkz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 09:40:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:36696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751674AbZALOkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 09:40:55 -0500
Received: (qmail invoked by alias); 12 Jan 2009 14:40:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 12 Jan 2009 15:40:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LpdZvLruLGbTi2N9UZtYxwfEEqvHBmHtUe/V5At
	A0qm7E/CfPcInp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231769764-17294-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105346>

Hi,

On Mon, 12 Jan 2009, Thomas Rast wrote:

> The path format was inconsistent with the one used in git-notes.sh: it
> supposedly split the sha1 in the same 2/38 format that .git/objects
> uses, but the code uses the full sha1 without a path separator.
> 
> While at it, also fix a grammatical error.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho
