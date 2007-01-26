From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 20:37:36 +0100
Message-ID: <20070126193736.GA7361@moooo.ath.cx>
References: <20070125173954.GA13276@spearce.org> <epcvsg$784$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 20:37:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAWtM-0002e9-8a
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 20:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbXAZThl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbXAZThl
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 14:37:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:47096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161218AbXAZThk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 14:37:40 -0500
Received: (qmail invoked by alias); 26 Jan 2007 19:37:39 -0000
Received: from pD9EB9FC4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.159.196]
  by mail.gmx.net (mp040) with SMTP; 26 Jan 2007 20:37:39 +0100
X-Authenticated: #5358227
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <epcvsg$784$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37881>

Jakub Narebski <jnareb@gmail.com> wrote:
> I'd rather use "%s+%i-g%s\n" here...
Ack, this makes it much easier to recognise what this number is.
