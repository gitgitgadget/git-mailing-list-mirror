From: Chris Wedgwood <cw@f00f.org>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 07:51:19 -0800
Message-ID: <20051114155119.GA23912@taniwha.stupidest.org>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz> <43789FED.7060401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 16:54:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbgcA-0007b6-67
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 16:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVKNPvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 10:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVKNPvX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 10:51:23 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:29099 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751160AbVKNPvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 10:51:22 -0500
Received: from ylpvm01.prodigy.net (ylpvm01-int.prodigy.net [207.115.5.207])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id jAEFphin008756
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 10:51:44 -0500
X-ORBL: [70.132.51.62]
Received: from stupidest.org ([70.132.51.62])
	by ylpvm01.prodigy.net (8.13.4 dk-milter linux/8.13.4) with ESMTP id jAEFtSvs014005;
	Mon, 14 Nov 2005 10:55:28 -0500
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 2D8AB528F22; Mon, 14 Nov 2005 07:51:19 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43789FED.7060401@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11805>

On Mon, Nov 14, 2005 at 03:32:13PM +0100, Andreas Ericsson wrote:

> Dunno. I only know bash-scripting, really. I'll replace them with
> some sed thing instead.

For some people /bin/sh != /bin/bash so you probably want "!/bin/bash"
instead.
