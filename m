From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Thu, 1 Oct 2009 14:07:11 +0200
Message-ID: <20091001120711.GB5583@Pilar.aei.mpg.de>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com> <a4c8a6d00909301518v43784d7ah6364be0134a6e7d@mail.gmail.com> <20091001080206.GB13436@coredump.intra.peff.net> <20091001115846.GA5583@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 14:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtKSR-0000Wy-K3
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 14:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbZJAMIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2009 08:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbZJAMIS
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 08:08:18 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:35019 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbZJAMIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 08:08:17 -0400
Received: by bwz6 with SMTP id 6so57042bwz.37
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KcMnWBD8NHJDOEuY7hj4ii2mmdBV9CfN+QDpJiZBLEs=;
        b=KW775ZAkLBfJLPckzE5vO6dqB8uZWQg/MAwBVHDeEsI5UmST3auFGloE9x7Ymx6Zgl
         YQiXAbmniWrbL0zm7t/UoPC6BlKWXgduCdSpNCeDiobqM1zHrOFwhEvD0MV4M8qjFmk6
         uU8w030rZSBUsLwNjCWB+4cjSLx5JF76FnmnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aiqQWQCpdR9McZ2JxH+oSPdnWgvFpsuI4j3YAW7YvY8r5QiynoWREdjdoEcUO8vd1T
         GcQFO0OfUSMTetcdAOaeXndZSnEVkrBrCClP2ZfwS6nCTgPGquRl1sRRXK7b+3z+HTyD
         12HNk9VbQfbA/uJzGe8RRMxLK0a/cjdpPC5tE=
Received: by 10.204.3.22 with SMTP id 22mr886693bkl.181.1254398900731;
        Thu, 01 Oct 2009 05:08:20 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id 9sm7534fks.4.2009.10.01.05.08.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 05:08:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091001115846.GA5583@Pilar.aei.mpg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129388>

On Thu  1.Oct'09 at 13:58:46 +0200, Carlos R. Mafra wrote:
> I read the patch. The changes are correct and improve the quality
> of the text.

=46rom the Portuguese point of view the change below is
correct,

-cabe=C3=A7alho Subject: e o resto no corpo.
+cabe=C3=A7alho "Assunto:", e o resto no corpo.

but I don't know if "Subject:" should be translated in
this context. Does git-am accept "Assunto:" instead
of "Subject:" if one is using a Portuguese locale?
