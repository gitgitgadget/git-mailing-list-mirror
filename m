From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 21:24:54 +0200
Message-ID: <20090420212454.203b9b72@gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
	<20090420113216.GC25059@dpotapov.dyndns.org>
	<49EC6596.8060208@drmicha.warpmail.net>
	<20090420132414.GD25059@dpotapov.dyndns.org>
	<alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
	<20090420184746.GG25059@dpotapov.dyndns.org>
	<alpine.DEB.1.00.0904202117010.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvz91-00056o-Hn
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 21:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbZDTTZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbZDTTZN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 15:25:13 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55502 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757AbZDTTZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 15:25:10 -0400
Received: by fxm2 with SMTP id 2so2147352fxm.37
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=O1bBfLjD5e2rA5aDt+BJptPGkfRWSvTGhdI/nkgZc1A=;
        b=HCNm/ZIDnzRML9Nyxo8F04SN3F2SCCHeO1E5gmlYbO3YZjM8VsDSkRaHrpv/B8X2oQ
         8d7gfb7WT6wXq+/RCKv+zA6z1q61QOvpO2K8RSm9GOUPIvPoTLDt90NDTTN2X8q9J+aR
         /21LxD4gRvrEe7FAdgNz4GvWuxYoDsCqetjak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=GF8pURVIr4XzNhkqQynZPf8o5ZLAlZWt9KwerXme5J1yTAndDtc/KBqUeCQkrcaN4a
         i4/a1T0UF02+XvvTUIPyCAdsLhnkUQmr/AfN7UF+dUt/KZjX+sX4KSrImH+FZENU85s0
         fZKJZUs0NWhsxPJAcKUCF4Juj7pccCq3G7mEs=
Received: by 10.103.6.18 with SMTP id j18mr3303850mui.33.1240255507338;
        Mon, 20 Apr 2009 12:25:07 -0700 (PDT)
Received: from localhost (87-205-58-126.adsl.inetia.pl [87.205.58.126])
        by mx.google.com with ESMTPS id u26sm14599693mug.27.2009.04.20.12.25.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 12:25:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904202117010.6771@intel-tinevez-2-302>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117025>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I'm sorry, the direction of this discussion does not please me.
> 
> The purpose of my message was to make Git old-timers _aware_ of the 
> problems newbies have with our notion of branches.  And a wish to
> come up with less confusing documentation.
> 
> The purpose was not to discuss at length what branches are in Git
> (and the intended discussion was certainly not about CVS!).
> 
> Ciao,
> Dscho

I think you did something more. You made them aware that
they do not even agree what a branch in Git is.

Michal Kiedrowicz
