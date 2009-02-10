From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 13:47:52 -0600
Message-ID: <1234295272.10335.26.camel@ld0161-tx32>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
	 <slrngp21uj.i22.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWybl-0006Uv-DW
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbZBJTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZBJTr5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:47:57 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:65265 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbZBJTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:47:56 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n1AJlraT004029;
	Tue, 10 Feb 2009 12:47:53 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1AJlqQe003406;
	Tue, 10 Feb 2009 13:47:52 -0600 (CST)
In-Reply-To: <slrngp21uj.i22.sitaramc@sitaramc.homelinux.net>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109297>

On Tue, 2009-02-10 at 04:51 +0000, Sitaram Chamarty wrote:

> I use cross-branch stashes all the time.  Stash it here, go
> there, and pop the stash.  I hope that does not change :-)

Perhaps 'git checkout -m other_branch'?

jdl
