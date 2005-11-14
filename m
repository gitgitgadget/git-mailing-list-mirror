From: Chris Wedgwood <cw@f00f.org>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 09:45:35 -0800
Message-ID: <20051114174535.GA25978@taniwha.stupidest.org>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz> <43789FED.7060401@op5.se> <20051114155119.GA23912@taniwha.stupidest.org> <4378B74E.2060208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 18:46:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbiP5-0002sk-T4
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 18:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVKNRps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 12:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVKNRps
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 12:45:48 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:42658 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751211AbVKNRpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 12:45:47 -0500
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id jAEHk6in017372
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 12:46:07 -0500
X-ORBL: [70.132.51.62]
Received: from stupidest.org ([70.132.51.62])
	by pimout5-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id jAEHjZdL104610;
	Mon, 14 Nov 2005 12:45:42 -0500
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 7D433528F22; Mon, 14 Nov 2005 09:45:35 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4378B74E.2060208@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11828>

On Mon, Nov 14, 2005 at 05:11:58PM +0100, Andreas Ericsson wrote:

> Ach no. The configure script really needs to be portable. POSIX (or
> SUS or some such) define a minimum syntax that any shell must
> support when invoked as /bin/sh.

Then bashism need to go away and it should be test with
dash/ash/whatever.
