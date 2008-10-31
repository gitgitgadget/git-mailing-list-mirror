From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 23:51:39 -0700
Message-ID: <1225435899.20883.25.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
	 <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
	 <20081030150135.GG24098@artemis.corp>
	 <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
	 <1225387882.19891.9.camel@maia.lan>   <gedhh6$urq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 07:53:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvnsV-0002Ew-UD
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 07:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYJaGvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 02:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbYJaGvu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 02:51:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52909 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbYJaGvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 02:51:49 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id F111E21C50D; Fri, 31 Oct 2008 19:51:47 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 39A2E21C488;
	Fri, 31 Oct 2008 19:51:41 +1300 (NZDT)
In-Reply-To: <gedhh6$urq$1@ger.gmane.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99555>

On Fri, 2008-10-31 at 00:55 +0100, Jakub Narebski wrote:
> > involves typing the branch name twice.  I end up writing things like:
> > 
> >   git checkout -b {,origin/}wr34251-do-something
> 
> Can't you use currently
> 
>     git checkout --track origin/wr34251-do-something

Ah, that's a new feature.  Still, I think it's poorly Huffman coded; far
too verbose.

But let's resume this discussion after I dig up the old thread about
pushing and pulling too... I think it makes sense to look at this as a
whole.

Cheers,
Sam.
