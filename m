From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] stg import documentation incorrect.
Date: Tue, 5 Aug 2008 22:07:01 +0100
Message-ID: <b0943d9e0808051407k3ae902cbma9b5bef8b0219c05@mail.gmail.com>
References: <48907221.5030608@docte.hr>
	 <20080804124823.GA12232@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jurko Gospodneti?" <jurko.gospodnetic@docte.hr>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:08:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQTlJ-0007MK-2r
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762636AbYHEVHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762536AbYHEVHE
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 17:07:04 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:52910 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761452AbYHEVHC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 17:07:02 -0400
Received: by py-out-1112.google.com with SMTP id p76so1447993pyb.10
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HDfC6/PHrvnI0X0F9lmMKNV1HLxp4Efyc/rlThOy2gI=;
        b=vx6SZE+9LXjfPC4T5bjAhSZVjxW1+mW5/Vzgzo5XFmh1fj6VXBjcP0E6Dc9b+e7Kl+
         elsA+hXqWF2pD+RG9eGkU7U5F5QckZCnhlC6wEqNHqxtUVTspXUsesMstN8PSO0a3xs0
         BNt3QfznfFkiRXRELvBMgRSYEvZbRDIEHG7zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cVz/oU1TdLFUtfzh534y9iAIOYYRks9pgYlCJ8WpKyzvBaZ9YYUvKO5S6tTNoHk+zF
         YckcGMFkoG4pb7pRYC54Ab+Y8VguQkH2dylaoa7Id9dtVtW+Ay6hpSdxiHYB1w+SkNvk
         LQSvrXyguWAKBPImOgPce0hD6pX4SyxGF3160=
Received: by 10.114.148.2 with SMTP id v2mr205275wad.202.1217970421315;
        Tue, 05 Aug 2008 14:07:01 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 5 Aug 2008 14:07:01 -0700 (PDT)
In-Reply-To: <20080804124823.GA12232@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91462>

2008/8/4 Karl Hasselstr=F6m <kha@treskal.com>:
> Yes, the tutorial is in sore need of a fresh coat of paint.

Now that you mentioned it, should we just replace the wiki tutorial by
a static page generated from Documentation/tutorial.txt?

If no-one feels like writing documentation, I'll have a go at updating
the tutorial.

--=20
Catalin
