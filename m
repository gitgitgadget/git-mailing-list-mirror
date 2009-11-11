From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 22:26:48 +0100
Message-ID: <20091111212648.GI27518@vidovic>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <20091111184215.GG27518@vidovic> <alpine.LFD.2.00.0911111408380.16711@xanadu.home> <20091111210727.GN12890@machine.or.cz> <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KiW-0006M8-QO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbZKKV0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759271AbZKKV0t
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:26:49 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:61437 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024AbZKKV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:26:48 -0500
Received: by ey-out-2122.google.com with SMTP id 9so342470eyd.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=zbrk4U0ah2EItlL6ChvwLLfvwcj3mD/omI6dhuvyTQY=;
        b=UxV9JGzf4w3h1qr2nawDxdqlnYXAWlDXSNyMpyfrwbfaFlfe67MeHk8GlDSaKaieC6
         amPw9JJtGRZAzKMHRzets3EjAweGFx/Xr5MuJyPArN234IryZoITFItDWJHvflR+swbA
         2VgKXgBht+ICT9WIJpHdWZxw9/mLkKcwvRQ+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QiDQaAzqblw4QtSSFUR6h0CBKkSPZN7MyKHJ3ja5SAWECuDKmu5hgXXL5zz7muoGWs
         Hs4/DQvBFCzqVhNoLNlrNS7JZk7tcM7M8Jld26owkLyvjzgHjk3p9NgA64h/4fgmGZ+F
         Z3Bb98J1ZQ2SIXc/VVZqh5HRAdntjTFtHBvtA=
Received: by 10.213.24.24 with SMTP id t24mr210241ebb.16.1257974813466;
        Wed, 11 Nov 2009 13:26:53 -0800 (PST)
Received: from @ (88-121-116-229.rev.libertysurf.net [88.121.116.229])
        by mx.google.com with ESMTPS id 7sm1468375eyb.32.2009.11.11.13.26.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:26:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132705>

The 11/11/09, Nicolas Pitre wrote:
> On Wed, 11 Nov 2009, Petr Baudis wrote:
> 
> > Yes, but nothing should have changed in git-daemon, that's the only part
> > of the infrastructure that uses system-wide git (which it perhaps
> > shouldn't). I cannot reproduce this problem, though. I have changed
> > git-daemon to use my local git version (about one week old master), does
> > this still happen for you?
> 
> No, it doesn't happen anymore.

I couldn't reproduce it, me neither.

> What was the git-daemon version before?

-- 
Nicolas Sebrecht
