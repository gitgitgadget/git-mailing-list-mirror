From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: ghost refs
Date: Fri, 9 Apr 2010 01:04:19 +0200
Message-ID: <20100408230419.GA13704@vidovic>
References: <20100407210010.GB27012@coredump.intra.peff.net> <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com> <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com> <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com> <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com> <20100408043059.GA28768@coredump.intra.peff.net> <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com> <7vwrwh6fz8.fsf@alter.siamese.dyndns.org> <20100408194908.GB4222@sigill.intra.peff.net> <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 01:04:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O00m5-0000bv-T1
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 01:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838Ab0DHXE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 19:04:27 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:44022 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933780Ab0DHXEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 19:04:25 -0400
Received: by bwz1 with SMTP id 1so2173232bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OT83Zx/iD3DtRCXmgAmCueUmUI1mV7o9Pt/g6FLt4S8=;
        b=EUB+b/plIctfEF/5g33Rk/W4s0wZvagQJ9HbAUU0vMxaYkSM6NeR/qutHkkj/Hawe9
         EU3tKBX0KBaViAg9foqvNXlQ2ReJtxs8giG8xjLxxXwOe7Ecuald8rN333TAcSJsrqDF
         Bk/TqYOn16tanIqhoxgGlE5k8YVbQXjOrRsR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iy/2YJmRLfuI4KD7XjTCLs6WNMlh90U1pHMCdBoirE3S3q0u1kSI92wR7fMXKexe0V
         22Hm+71SvSwjqURexlaI44+Dt2mu+PEMWMagz5sAjXFqkEWoiePmF5y6ViyHOlXl3x+g
         h2V/2yMNEn1o1Vg1lTUj20xY18JF/tupGlY7c=
Received: by 10.204.141.133 with SMTP id m5mr915099bku.91.1270767864155;
        Thu, 08 Apr 2010 16:04:24 -0700 (PDT)
Received: from @ (88-121-119-67.rev.libertysurf.net [88.121.119.67])
        by mx.google.com with ESMTPS id x16sm4170524bku.11.2010.04.08.16.04.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 16:04:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144386>

The 08/04/10, Junio C Hamano wrote:
> 
> We might want to have a general concensus on what we want to have in the
> documentation.

<...>

> I'll list my preference off the top of my head as a firestarter.

Nice. If a concensus is found for writing consistent documentation I
think it's worth to save in a file like Documentation/README or
Documentation/CONTRIBUTE.

-- 
Nicolas Sebrecht
