From: Jeff King <peff@peff.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 4 Jan 2008 22:43:55 -0500
Message-ID: <20080105034355.GA26892@coredump.intra.peff.net>
References: <1199426431-sup-6092@south> <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org> <20080105010011.GV29972@genesis.frugalware.org> <1199500828-sup-502@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 04:44:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAzxY-0002rM-QU
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 04:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYAEDn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 22:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYAEDn6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 22:43:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4037 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbYAEDn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 22:43:58 -0500
Received: (qmail 22033 invoked by uid 111); 5 Jan 2008 03:43:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 22:43:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 22:43:55 -0500
Content-Disposition: inline
In-Reply-To: <1199500828-sup-502@south>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69637>

On Fri, Jan 04, 2008 at 06:54:02PM -0800, William Morgan wrote:

> Also, mine has color support. :)

On the current master, try:

  git config color.interactive auto
  git config color.diff auto
  git add -i

-Peff
