From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Thu, 30 Apr 2009 11:44:19 +0800
Message-ID: <46dff0320904292044t54dfe955reed06fd8a9b6e57@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
	 <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 05:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzNCg-0001J4-Bn
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 05:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZD3DoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 23:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZD3DoU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 23:44:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:4469 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbZD3DoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 23:44:19 -0400
Received: by yx-out-2324.google.com with SMTP id 3so932086yxj.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 20:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xBk1Hrb0WRGmeyaE2QMplT0szPUodw1owFIqi5RhzLQ=;
        b=bqH5bs4w4z2l4cBuIEuSr1zuGfydTASZn8Vb+JIBVfP9s53rPWCkySmo4age5V2Uzk
         54WdVPVICtfoQGux/TkTxTTvO3cugAWxg+3ve7JmTj1uxaB1MYpz8dehGF5Z7jFbQdKQ
         1mx6vpgFCQ0KZmltHNE+dspBEw/25omNeZmxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m8pIYH9BE9JlqexRrlK/uG96O7IOQHE39yvllv3re5oBakkT7ci5wGPslme+44EedQ
         GjlD+oXNiUIwPvznr7JQsLGupVIvpI6vQR03AnlbT8PdQ9Gm3al1/6uFeB35ubLz5z3f
         1k/btPlwKIQaG71wzmvoi+ZDqU3TbatovPmFM=
Received: by 10.90.118.8 with SMTP id q8mr863328agc.80.1241063059307; Wed, 29 
	Apr 2009 20:44:19 -0700 (PDT)
In-Reply-To: <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117988>

> Resending just in case it got lost.
>
> Don't suppose anyone has any comments on this? =C2=A0It's just a firs=
t
> draft, so please let loose. =C2=A0I'm in desperate need of *some* kin=
d of
> solution like this, however.
>

I think it is a nice feature. Although there is a howto to introduce
merge as subtree, and i have done it several times, i can't still
remember the first step. A command like this is helpful for me.
Thanks.
