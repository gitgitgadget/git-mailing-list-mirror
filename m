From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH 4/4] Do not break git-gui messages into multiple lines.
Date: Thu, 5 Apr 2007 16:45:19 +0400
Message-ID: <20070405124519.GU26348@codelabs.ru>
References: <20070327103155.GR14837@codelabs.ru> <20070404164300.GB5167@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZRLM-0005Dl-4U
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 14:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766964AbXDEMpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766969AbXDEMpc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 08:45:32 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:61114 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766964AbXDEMpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 08:45:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=KdQNaZgi4Xi/VnZAkHDlKvMCmXd4fD11o4L95IBGngNPzGy5CfVb7YzGPDgXxcAo20kpXqA0UFar03SrnDiHdF4xfeeN3eeFZU1Bd2hX/Vhm0Bb25AXY4KPoPIHTa8PHnHy3kytmBComWjrG07jP6HPHfJHjcRG8sPCQRShiKiw=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HZRLA-000N2A-L0; Thu, 05 Apr 2007 16:45:24 +0400
Content-Disposition: inline
In-Reply-To: <20070404164300.GB5167@spearce.org>
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43820>

Shawn, good day.

Wed, Apr 04, 2007 at 12:43:00PM -0400, Shawn O. Pearce wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> > Many git-gui messages were broken into a multiple lines to make
> > good paragraph width. Unfortunately in reality it breaks the paragraph
> > width completely, because the dialog window width does not coincide
> > with the paragraph width created by the current font.
> 
> Thanks.  I've applied this series, except for the option menu fix.
> I'll test later on Windows to make sure there is no breakage there,
> but I think it looks sane and will move to my master branch soon.

OK, thank you!

> Sorry it took so long, been busy...  ;-)

No problems ;))
-- 
Eygene
