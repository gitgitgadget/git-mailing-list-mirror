From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: GIT_DIR question
Date: Tue, 19 Jun 2007 09:15:55 +0200
Message-ID: <20070619071555.GA25338@moooo.ath.cx>
References: <f36b08ee0706170829w59979d86i7bf09bc35ff28fca@mail.gmail.com> <f36b08ee0706170834m464ce57dl3fd5b549b23abb16@mail.gmail.com> <20070617215235.GA27753@moooo.ath.cx> <f36b08ee0706181243x64241585rfb64ca48323dea1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 09:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xwf-0000fR-OD
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 09:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbXFSHQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 03:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbXFSHQG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 03:16:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:43240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753198AbXFSHQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 03:16:05 -0400
Received: (qmail invoked by alias); 19 Jun 2007 07:16:01 -0000
Received: from pD9EBB464.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.100]
  by mail.gmx.net (mp049) with SMTP; 19 Jun 2007 09:16:01 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/qBaYJBIvqjSVY22yLPuT0cRsvtT875uRvgGeAC/
	xfRxMq2zf3P92A
Content-Disposition: inline
In-Reply-To: <f36b08ee0706181243x64241585rfb64ca48323dea1e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50450>

Yakov Lerner <iler.ml@gmail.com> wrote:
> Does your patch allow to use absolute filenames and being cwd
> outside of working dir ? I like to use absolute filenames (sometimes.
> Most modern VSCes allow absolute pathnames).

Nope, that's not possible (yet).  I can't think of an easy way to do
this right now..
