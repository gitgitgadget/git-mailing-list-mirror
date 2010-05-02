From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: RFD: tables in documentation
Date: Sun, 02 May 2010 15:43:14 +0100
Message-ID: <1272811394.24767.7.camel@dreddbeard>
References: <4BDC74F3.2020206@drmicha.warpmail.net>
	 <20100502050622.GF14776@coredump.intra.peff.net>
	 <4BDD7E96.2050603@drmicha.warpmail.net>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 16:44:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8aP1-0006Nq-SK
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 16:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621Ab0EBOng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 10:43:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36663 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab0EBOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 10:43:35 -0400
Received: by wwb34 with SMTP id 34so1145735wwb.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=REf7lWyVBkZa5WnP93NJjDIEBXz3mFh2uAvK9SWxIlc=;
        b=EX4vZ3g9EnjaO4Hp7yVOIWc+cntu2S/j93x7n7gDaFpsYVIlrPTHzcYhCPqHK7EIAo
         u4yN6BYqzuSnSEwbKF7kn73bKe0NReWFDdRS/HeP3YLVMiGkBnMzGnCKjhxzl993rO4v
         hTR/d6DXDz3cY1GPNOHu+MLO8io88BLEV7Tbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lDzEYeSks21lCGXwugIWoMdMi2p7Pf/ViovXtsiD6LV8x0hs+cohYrP7tkZDwNLsw8
         5OwHIqLKsSEX73uqpLF/+4EkkCKJdm2WZDYUCGEMC5PAxoJfvGEKirdwEvSdBcY+jITG
         zalTFQ9JdTAyHADgyeUP49BXVb09WkPlSyNJQ=
Received: by 10.216.157.4 with SMTP id n4mr10427677wek.53.1272811413519;
        Sun, 02 May 2010 07:43:33 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id u8sm33067409wbc.23.2010.05.02.07.43.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 07:43:33 -0700 (PDT)
In-Reply-To: <4BDD7E96.2050603@drmicha.warpmail.net>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146178>

On Sun, 2010-05-02 at 15:31 +0200, Michael J Gruber wrote:
> Jeff King venit, vidit, dixit 02.05.2010 07:06:
> > On Sat, May 01, 2010 at 08:37:39PM +0200, Michael J Gruber wrote:
> > Did you put the source up anywhere? I didn't see it, but it would be
> > interesting to see how painful it is to write.
> 
> http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables
> 
> Tough guess, I know ;)
> 
> Michael

that looks suspiciously like a format that's intended to be readable in
both plaintext and eventually-generated form. This is me speaking in
pure ignorance, but would something like:



-- 
-- Will
