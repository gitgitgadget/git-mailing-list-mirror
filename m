From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git rebase -s ours
Date: Mon, 3 Mar 2008 00:41:26 -0500
Message-ID: <20080303054126.GB24210@coredump.intra.peff.net>
References: <20080301111716.GA3263@glandium.org> <20080302010527.GB22843@coredump.intra.peff.net> <20080302124848.GB8696@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 06:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW3Ra-0000nY-14
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 06:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbYCCFla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 00:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbYCCFla
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 00:41:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3257 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYCCFl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 00:41:29 -0500
Received: (qmail 3289 invoked by uid 111); 3 Mar 2008 05:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Mar 2008 00:41:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2008 00:41:26 -0500
Content-Disposition: inline
In-Reply-To: <20080302124848.GB8696@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75885>

On Sun, Mar 02, 2008 at 01:48:48PM +0100, Mike Hommey wrote:

> I don't have a workflow in mind, but I have expectations: considering
> the documentation, I would expect git rebase -s ours to do what git
> filter-branch can do with grafts.

I'm not sure I follow. Can you elaborate?

-Peff
