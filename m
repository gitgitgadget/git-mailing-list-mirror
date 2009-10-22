From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Thu, 22 Oct 2009 09:09:13 +0200
Message-ID: <40aa078e0910220009p729b7dc6iaf14eab3bda37670@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
	 <20091022062145.6117@nanako3.lavabit.com>
	 <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 22 09:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0rnV-0005JF-9j
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 09:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbZJVHJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbZJVHJK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 03:09:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36394 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZJVHJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 03:09:09 -0400
Received: by fxm18 with SMTP id 18so8778088fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IKLoOvo02OIufYj2qByzUicCiLBJP0Psl+JPvJxKtpc=;
        b=ZFL1192JKH/mg4NdvOT6PHrhrWKlJ4wW+ytDsG9k7VL9StQHBPRGAbW2kupVT000ew
         8IpJ6UOPKuIsw+y1DL08nzdVZ7sdqun/OFCzfjtuIJJtWFe4Joli3Rl3pOBqE1nMaFON
         +s49JQQvSXVy3XFsl2bzg+vDEY7lFCB9TDStE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=iZ1V5/vCbjiL41RqGdw59t0dYOsyyhPaheTRRFCuGV9V2oVEJG78hHVv6dgJxIDgBs
         kPNdMcmVL2iMzlHrxa8ZnbK9PCx4Kh0SC5e578L/c2Eu2JrNvjDcRurvS1b5YbIZKqJA
         XrguKrYwre+TESXeH2/q4odDmFbPSTVGz5qxU=
Received: by 10.204.7.92 with SMTP id c28mr9000155bkc.170.1256195353679; Thu, 
	22 Oct 2009 00:09:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131000>

On Thu, Oct 22, 2009 at 2:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> My take on it:
>
> 1) --no-porcelain
>
> 2) we all are bike-shedding, not being constructive at all

In that case, I propose "--yellow".

-- 
Erik "kusma" Faye-Lund
