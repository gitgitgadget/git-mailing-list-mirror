From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v7 4/6] fast-import: test the new feature command
Date: Sat, 12 Sep 2009 11:52:12 -0700
Message-ID: <20090912185212.GR1033@spearce.org>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> <1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> <1252247748-14507-4-git-send-email-srabbelier@gmail.com> <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:52:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXhq-0005D3-NX
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbZILSwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbZILSwJ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:52:09 -0400
Received: from george.spearce.org ([209.20.77.23]:32954 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbZILSwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:52:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3EA67381FD; Sat, 12 Sep 2009 18:52:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128285>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Test that an unknown feature causes fast-import to abort, and that a
> known feature is accepted.

This should be squashed with the prior patch.
 
>  t/t9300-fast-import.sh |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)

-- 
Shawn.
