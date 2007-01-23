From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: gets "-dirty" under fakeroot
Date: Tue, 23 Jan 2007 15:22:19 +0100
Message-ID: <20070123142219.GA21219@moooo.ath.cx>
References: <87ac0auhyy.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 15:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MXb-00011Y-LC
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbXAWOWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbXAWOWZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:22:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:50655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932968AbXAWOWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:22:24 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:22:23 -0000
Received: from pD9EBA479.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.164.121]
  by mail.gmx.net (mp041) with SMTP; 23 Jan 2007 15:22:23 +0100
X-Authenticated: #5358227
To: Yasushi SHOJI <yashi@atmark-techno.com>
Mail-Followup-To: Yasushi SHOJI <yashi@atmark-techno.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87ac0auhyy.wl@mail2.atmark-techno.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37524>

Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> How do you guys do when you create snapshot package like rpm or deb?
> or is this just me?
Use fakeroot -u.
