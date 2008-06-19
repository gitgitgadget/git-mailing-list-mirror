From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] completion: add --graph to log command completion
Date: Thu, 19 Jun 2008 18:06:18 -0500
Message-ID: <449c10960806191606j547e364er7a231ca879952b13@mail.gmail.com>
References: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com>
	 <20080619215842.GL11793@spearce.org>
	 <20080619224012.GA6705@mithlond.arda.local>
	 <20080619225552.GQ11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:07:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TDn-0002Xw-5c
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbYFSXGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYFSXGU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:06:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:29224 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYFSXGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:06:19 -0400
Received: by wr-out-0506.google.com with SMTP id 69so747272wri.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S1PWSIMbgHZmfG9cVrp9yJ95YZUTHp1ydqQfePhPShY=;
        b=P7NoHec+uFyyXpkj+NQ/seq0r4usdWAD0fWAr7L2/ZBBHEQEJa/Qkh8IsmaJtA18UA
         MRawgv/5RFK3I+WhnauDImmMeT/rj201uu99a6Pz81sRw64q/qqgyHyzdAHHY+zLOvA5
         YBcwTYkMOugaXpi8DqD5WVSPEcw+fmpheNdgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ABMhevsPE8u3d1N6BGJDW3QIi3DKovTWofSH927hsFSDrud42B4g1bpjfGQcL7BvzK
         Zerk/7kiZBh6hcZXE2bOiZrE9hU9WiPQsbc3Jo2s8uSxGznv8Fs+vz6dikNdqU9CJQww
         Xd1TOLkimFZVGtjDRXfJNudCJ7h5IUBX78gVc=
Received: by 10.90.106.6 with SMTP id e6mr3361812agc.41.1213916778191;
        Thu, 19 Jun 2008 16:06:18 -0700 (PDT)
Received: by 10.90.50.2 with HTTP; Thu, 19 Jun 2008 16:06:18 -0700 (PDT)
In-Reply-To: <20080619225552.GQ11793@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85560>

On Thu, Jun 19, 2008 at 5:55 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> This conflicts with the patch you are replying to, but it makes
> sense to do these options as well.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

It is more complete than mine though, so you can keep my name out of
the log this time.

Acked-by: Dan McGee <dpmcgee@gmail.com>
