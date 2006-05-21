From: Jeff King <peff@peff.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 04:44:03 -0400
Message-ID: <20060521084403.GB12825@coredump.intra.peff.net>
References: <20060521054827.GA18530@coredump.intra.peff.net> <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net> <20060521081435.GA4526@coredump.intra.peff.net> <e4p83e$uqt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 10:44:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjXt-0000yH-Bq
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWEUIoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEUIoG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:44:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:36072 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751513AbWEUIoF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:44:05 -0400
Received: (qmail 707 invoked from network); 21 May 2006 08:44:03 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 May 2006 08:44:03 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 May 2006 04:44:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e4p83e$uqt$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20442>

On Sun, May 21, 2006 at 10:24:37AM +0200, Jakub Narebski wrote:

> Hmmm... isn't the patch slightly against git coding style?

Oops, yes (though the point is moot since the patch is conceptually
wrong). Is there a git coding style document somewhere?

-Peff
