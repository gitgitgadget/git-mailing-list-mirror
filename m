From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/10] "git read-tree -m" and the like require worktree
Date: Tue, 11 Mar 2008 14:02:02 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111400430.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103316.GA8902@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ48C-0006dg-PG
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbYCKNB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756943AbYCKNB7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:01:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:55023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753295AbYCKNB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:01:58 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:01:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 11 Mar 2008 14:01:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qJ1Ycc4xq0wE1MNcRENjaaoP2hwYKzoNNAH6VbG
	odP4vH/xRbOiJ1
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103316.GA8902@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76838>

Hi,

How about

	git read-tree -m without -i requires work tree

Hmm?

Other than that, it looks like an obvious bugfix which is independent of 
the rest.

Ciao,
Dscho
