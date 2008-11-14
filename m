From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH v2 00/11] gitweb: display remote heads
Date: Fri, 14 Nov 2008 16:25:21 +0100
Message-ID: <bd6139dc0811140725m37cbcd9erd61e21048f0def2f@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811141533.15427.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 16:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L10ZF-0006Y7-OP
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 16:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYKNPZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYKNPZY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 10:25:24 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:61798 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbYKNPZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 10:25:22 -0500
Received: by hs-out-0708.google.com with SMTP id 4so661273hsl.5
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ALkl6IjMYWSk26USTrlMdssKdakb04NddORAtFVEAMM=;
        b=V29B75Ac/lBlXD61jdmHnD4xLPK7UggZHFD00gzSmyAiMCGFk9qXASKOAhKAlalgza
         mgIclt6XkHLwapGW5/mz5xGZRcMmE04kf2J8c2lgjNRSGRQDXSfb1DwFF13/f2GBpRpA
         AauW2ZB7C3Lzf6up/7Xc/Aeu532GWPuDLwZ+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=JOeB0464Sc044Vj3olEJWay9v3a0aApcjKTm8Ovd9ri51PIjDyrQQd/d7YWdGBsJ3/
         3F8hCOMaLBiGvKdu78Rrv20QM82TiQIZ+wzxr01gxyrS5ccknzR3ofmQnhfp5n4venUD
         Q/lB7yV/ikOCxP4enwMbJQ4WYBptg4wx+QXzk=
Received: by 10.151.42.13 with SMTP id u13mr1987711ybj.237.1226676321824;
        Fri, 14 Nov 2008 07:25:21 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Fri, 14 Nov 2008 07:25:21 -0800 (PST)
In-Reply-To: <200811141533.15427.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100983>

On Fri, Nov 14, 2008 at 15:33, Jakub Narebski <jnareb@gmail.com> wrote:
> Note that on GMane NNTP (news) interface I can see only two last
> patches. Could anyone not CC-ed confirm or deny if this is VGER
> anti-SPAM filter at work, or some GMane archive hiccup?

I got all of the patches just fine, and I'm not CC-ed ;).

-- 
Cheers,

Sverre Rabbelier
