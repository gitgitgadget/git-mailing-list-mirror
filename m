From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 12:47:39 -0700
Message-ID: <20050503194739.GA7082@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org> <20050503192753.GA6435@taniwha.stupidest.org> <Pine.LNX.4.58.0505031242330.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3Gm-0006ML-IL
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVECTro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVECTro
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:47:44 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:51650 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261644AbVECTrn
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:47:43 -0400
Received: from pimout3-ext.prodigy.net (pimout3-ext.prodigy.net [207.115.63.102])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j43Jld2j002396
	for <git@vger.kernel.org>; Tue, 3 May 2005 15:47:40 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j43JldY5295894;
	Tue, 3 May 2005 15:47:40 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 2B0A1528F26; Tue,  3 May 2005 12:47:39 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505031242330.26698@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 12:47:36PM -0700, Linus Torvalds wrote:

> Me, I refuse to slow down my habits for old filesystems. You can
> either fsck, or use a logging filesystem.

ok, so you're saying everyone use linux ext3 or similar more or
less...

how about we drop all the objects in one directory then?
