From: Jon Loeliger <jdl@freescale.com>
Subject: Re: cogito remote branch
Date: Fri, 09 Nov 2007 10:28:11 -0600
Message-ID: <1194625691.1471.3.camel@ld0161-tx32>
References: <1IqTj5-24rt3I0@fwd33.aul.t-online.de> <47345E85.8090702@op5.se>
	 <1IqUGN-1XXOVs0@fwd33.aul.t-online.de>
	 <Pine.LNX.4.64.0711091417060.4362@racer.site>
	 <1IqWRW-0QQ4LA0@fwd26.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWmO-0008Rf-UU
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbXKIQcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbXKIQcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:32:09 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:49304 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbXKIQcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:32:08 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id lA9GSChj020842;
	Fri, 9 Nov 2007 09:32:02 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA9GSCYQ018938;
	Fri, 9 Nov 2007 10:28:12 -0600 (CST)
In-Reply-To: <1IqWRW-0QQ4LA0@fwd26.aul.t-online.de>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64215>

On Fri, 2007-11-09 at 10:10, MichaelTiloDressel@t-online.de wrote:
>  There are just some features
> which simplify things for me in cogito. E.g. in cogito in the simplest
> way you don't need to be aware of the index. While with git
> you have to remember to add the changes to the index explicitly
> to get them committed. 
> 
> Cheers,
> Michael

"git commit -a ..." might be useful for you.

Other lingering cogito-isms you think are lacking in git?

jdl
