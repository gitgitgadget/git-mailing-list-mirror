From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 1 Sep 2008 15:20:09 +0530
Message-ID: <20080901095008.GB6555@toroid.org>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <20080901094412.GB3993@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 11:51:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka64C-00023w-FH
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYIAJuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYIAJuS
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:50:18 -0400
Received: from fugue.toroid.org ([85.10.196.113]:48417 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbYIAJuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:50:17 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 04D9D5582EB;
	Mon,  1 Sep 2008 11:50:16 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 08EAFADC36D; Mon,  1 Sep 2008 15:20:09 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20080901094412.GB3993@blimp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94555>

At 2008-09-01 11:44:12 +0200, raa.lkml@gmail.com wrote:
>
> IOW, copy the commit resolution from some other merge commit. Maybe
> can be a way to use rerere mechanism with that?

That's what I'm trying to implement on Dscho's suggestion. I'm still
just trying to understand the code, so any suggestions about how to
do this are very welcome.

-- ams
