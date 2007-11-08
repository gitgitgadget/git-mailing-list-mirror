From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 23:01:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711082301020.4362@racer.site>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net>
 <20071108102412.GA31187@atjola.homenet> <Pine.LNX.4.64.0711081332550.29952@iabervon.org>
 <20071108191601.GA22353@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIzM-0006iv-2K
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbXKIBsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbXKIBsh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:48:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:45529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754316AbXKIBsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:48:36 -0500
Received: (qmail invoked by alias); 08 Nov 2007 23:01:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp036) with SMTP; 09 Nov 2007 00:01:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PgKoLv0QP0IUdH//dJv0siOlobHhvLcKNnwAxeD
	/OFU42RIJTbah1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071108191601.GA22353@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64112>

Hi,

On Thu, 8 Nov 2007, Mike Hommey wrote:

> Maybe some commands such as commit should fail or at least emit warning 
> when used during a rebase ?

No, that would disrupt comming (and valid!) workflow too much.  Even a 
warning.

Ciao,
Dscho
