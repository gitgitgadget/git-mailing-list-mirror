From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] mergetool: Clean up description of files and prompts for merge resolutions
Date: Fri, 30 Mar 2007 00:29:05 +0200
Message-ID: <20070329222905.GA25347@moooo.ath.cx>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830652230-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX37d-000867-8D
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945900AbXC2W3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945907AbXC2W3M
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:29:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:33096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945900AbXC2W3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:29:10 -0400
Received: (qmail invoked by alias); 29 Mar 2007 22:29:09 -0000
Received: from pD9EBBCCA.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.188.202]
  by mail.gmx.net (mp033) with SMTP; 30 Mar 2007 00:29:09 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19dKBpQ2LRdzB+hz5bg1FT84fAgKDTx/8jihimShe
	TxKLuss4irlrbJ
Content-Disposition: inline
In-Reply-To: <11751830652230-git-send-email-tytso@mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43485>

Theodore Ts'o <tytso@mit.edu> wrote:
> +    printf "  {$branch}: "
This should use %s too.
