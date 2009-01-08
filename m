From: Sam Vilain <sam@vilain.net>
Subject: Re: Google Summer of Code 2009
Date: Thu, 08 Jan 2009 20:55:50 +1300
Message-ID: <1231401350.6067.4.camel@maia.lan>
References: <20090107183033.GB10790@spearce.org>
	 <81b0412b0901071512k64a7d5e2u2c602b903f5233d3@mail.gmail.com>
	 <20090107231431.GC10790@spearce.org>
	 <alpine.DEB.1.00.0901080024170.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 08:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKpli-0002gD-Vw
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 08:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZAHH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 02:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZAHH4F
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 02:56:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50168 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbZAHH4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 02:56:04 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 790C921D5F1; Thu,  8 Jan 2009 20:56:01 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9765521D1E8;
	Thu,  8 Jan 2009 20:55:56 +1300 (NZDT)
In-Reply-To: <alpine.DEB.1.00.0901080024170.7496@intel-tinevez-2-302>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104896>

On Thu, 2009-01-08 at 00:30 +0100, Johannes Schindelin wrote:
> However, from what Sam said at the GitTogether, it might be a much better 
> idea to look at the existing code as a fact-finding experiment, scrap it 
> (excluding the experience), and start modifying git-daemon.
> 
> AFAICT Sam has a pretty clear idea how to go about it, and staying with C 
> should make it much easier for other people to comment.
> 
> Note that there has been a flurry of emails on the gittorrent list a few 
> weeks back, where somebody challenged the approach Sam wants to take, 
> saying that BitTorrent has some very nice features that are absolutely 
> necessary, such as its pretty awkward custom encoding.
> 
> But AFAICT Sam did a pretty good job at dispelling all of the objections.

Yes, this is accurate as I know it.  I've renamed and reworded the
heading under the SoC2009Ideas page to point to the most current design.
It's all in a "just add JFDI" point right now I think ;-).

Sam.
