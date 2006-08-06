From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 1/6] gitweb: Refactor untabifying - converting tabs to spaces
Date: Sun, 6 Aug 2006 10:31:16 +0200
Message-ID: <20060806083116.GA25594@moooo.ath.cx>
References: <200608060206.49086.jnareb@gmail.com> <200608060208.31862.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 10:31:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9e2e-0002iu-OS
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 10:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWHFIbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWHFIbV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 04:31:21 -0400
Received: from moooo.ath.cx ([85.116.203.178]:33191 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932624AbWHFIbU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 04:31:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200608060208.31862.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24967>

Jakub Narebski <jnareb@gmail.com> wrote:
> +		# one out of three implementations used ($pos - 1) instead of $pos
Perhaps this should be in the commit message instead of the source?
I think no one will later understand this comment without the commit.
