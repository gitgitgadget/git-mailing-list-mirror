From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] word diff: comments, preparations for regex
 customization
Date: Sun, 11 Jan 2009 14:41:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901111440410.3586@pacific.mpi-cbg.de>
References: <cover.1231669012.git.trast@student.ethz.ch> <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 14:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0Zl-00085U-2f
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbZAKNkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 08:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZAKNkg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:40:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:41660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750755AbZAKNkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:40:35 -0500
Received: (qmail invoked by alias); 11 Jan 2009 13:40:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 11 Jan 2009 14:40:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+OHQfpCU+ZPaUfnN5uMI9nhg/AVr4ehPGKtZxG7
	belv00In+niSuF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105181>

Hi,

On Sun, 11 Jan 2009, Thomas Rast wrote:

> This reorganizes the code for diff --color-words in a way that will be
> convenient for the next patch, without changing any of the semantics.
> The new variables are not used yet except for their default state.
> 
> We also add some comments on the workings of diff_words_show() and
> associated helper routines.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

It not only got bigger, it still fails to explain the idea to me.

I'll work on it myself, then,
Dscho
