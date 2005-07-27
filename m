From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.4
Date: Wed, 27 Jul 2005 22:26:18 +0100
Message-ID: <1122499578.8047.4.camel@localhost.localdomain>
References: <1120899939.7125.4.camel@localhost.localdomain>
	 <42D3A415.5000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 23:57:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxtsx-0001Gv-8X
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVG0Vii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVG0V2R
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 17:28:17 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:56186 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262171AbVG0V0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 17:26:22 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050727212621.HETE22560.mta08-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Wed, 27 Jul 2005 22:26:21 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050727212621.DMCM9998.aamta12-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Wed, 27 Jul 2005 22:26:21 +0100
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42D3A415.5000709@gmail.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-07-12 at 07:05 -0400, Bryan Larsen wrote:
> Here's my wishlist.  Hopefully I'll be able to dig in and help out.
> 
> import: the complement to export

A first implementation of 'import' is available in the tonight's
snapshot (and in the StGIT git repository mirror).

> template files for the "series" output of export, to put it into a 
> format that "sendpatchset" understands.

As you noticed, I implemented the 'mail' command.

Once the current snapshot gets a bit more testing, I will release the
0.5 version. After that, I will focus more on a tutorial and the file
compatibility with Cogito.

-- 
Catalin
