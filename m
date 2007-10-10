From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-gui: set NO_MSGFMT to force using pure tcl
 replacement in msysgit
Date: Wed, 10 Oct 2007 16:52:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101651360.4174@racer.site>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
 <11919995392158-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdrO-0001dl-GD
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbXJJPwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbXJJPwV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:52:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:56422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754552AbXJJPwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:52:20 -0400
Received: (qmail invoked by alias); 10 Oct 2007 15:52:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 10 Oct 2007 17:52:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oQFUeOTyoIHs+DgrT7Al+ci4cOq1jaYQqaS8Mz4
	TrfgrWu61YxOI2
X-X-Sender: gene099@racer.site
In-Reply-To: <11919995392158-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60513>

Hi,

On Wed, 10 Oct 2007, Steffen Prohaska wrote:

> Shawn's git-gui Makefile supports the pure tcl replacement for msgfmt if 
> setting NO_MSGFMT. This patch sets the NO_MSGFMT for msysgit.

Would it not be cleaner to set this in 4msysgit and export it?

Ciao,
Dscho
