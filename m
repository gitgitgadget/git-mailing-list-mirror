From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC] libgit2 before the first evaluation
Date: Tue, 10 Aug 2010 17:58:56 -0500
Message-ID: <AANLkTi=qKGi3w2depLO7FDfCN3fBem6_xKZ70pD_af53@mail.gmail.com>
References: <AANLkTil46G2eI2cmXL5mHWrxFbCuavrFlcScT-7nwdoh@mail.gmail.com> 
	<201008101029.09718.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Andreas Ericsson <ae@op5.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Koch <thomas@koch.ro>, Git List <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>, Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oixn2-00079B-2u
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665Ab0HJW7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 18:59:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab0HJW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 18:59:17 -0400
Received: by gxk23 with SMTP id 23so3919249gxk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/LQR/nfh/dgYFDYyShfYReX4+HSxMdacvO8jhoMLWOQ=;
        b=Y78YCHLqSNWoImWQAGNEkIKFenOrMC6UBN6abMVhCdNC7o8hIV5OPFmtjSNecom0m2
         sPpnhELCPbKKr2Sx9jcMkip38WKMskMxnchwyGudmYSaM+lh2u9kMUldQsoAkZzwSy9G
         7CHgox2Q8riy2eXfo/5uag26OBy4ar/yWlquA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CeAJobQtNkeV1kDMd7S2MolUqJPHpRc283DeLrJI4xmy3obyyTSqJbVFjSBwZ3nEc5
         Su2iMFF6n9TVUA7L0IOXUjD8UrLlwCod8raUDbzKNKWgtXNJLWLn/SM9UirKmitkEwmq
         SDTGTGkw+q0+/X6EjHgM7jdNWjbJzV4xPo9QE=
Received: by 10.150.14.21 with SMTP id 21mr20885993ybn.65.1281481156223; Tue, 
	10 Aug 2010 15:59:16 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Tue, 10 Aug 2010 15:58:56 -0700 (PDT)
In-Reply-To: <201008101029.09718.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153172>

Heya,

On Tue, Aug 10, 2010 at 03:29, Thomas Koch <thomas@koch.ro> wrote:
> it has been one month since your last mail to the git mailing list.

On that note, wasn't it a _key goal_ of the libgit project to get it
integrated with git.git to prevent it from rotting? Why haven't I seen
_any_ emails about that yet? On that note, why has this been developed
almost entirely in the dark? Where were the weekly status updates? I'm
sure code is being produced, but a big part of GSoC is being part of
the community, and I've seen almost zero involvement.

-- 
Cheers,

Sverre Rabbelier
