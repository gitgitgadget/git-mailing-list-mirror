From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [ANNOUNCE] GIT MinGW port is now at v1.5.3-rc4
Date: Thu, 16 Aug 2007 13:21:14 +0200
Organization: eudaptics software gmbh
Message-ID: <46C4332A.AF464A67@eudaptics.com>
References: <46C41C49.A92AEF07@eudaptics.com> <6020F7321DB14F7B9288F0782A316803@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 13:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILdPY-0004Tv-M2
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 13:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbXHPLUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 07:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755863AbXHPLUg
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 07:20:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56721 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbXHPLUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 07:20:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1ILdP0-0003J0-6W; Thu, 16 Aug 2007 13:20:34 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B3B09B662; Thu, 16 Aug 2007 13:20:33 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.394, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56005>

Dmitry Kakurin wrote:
> 
> ----- Original Message -----
> From: "Johannes Sixt" <J.Sixt@eudaptics.com>
> > I've just pushed an update of the MinGW port to:
> > clone:  git://repo.or.cz/git/mingw.git
> 
> We need to make sure that we don't duplicate our efforts.
> Have you looked at http://repo.or.cz/w/git/mingw/4msysgit.git ?
> We've made some progress while you were on vacation.

I've basically hiding under a stone when I was away. So, no, I didn't
see it until yesterday ;)

> Also I think it's now time to merge two repos.
> Two Johanneses (corresponding repo owners on the to: line), please coordinate with each other.

Sure! First thing I need to know is which branch I should keep an eye
on. master?

-- Hannes
