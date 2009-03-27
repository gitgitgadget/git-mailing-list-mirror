From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Fri, 27 Mar 2009 08:08:04 -0700 (PDT)
Message-ID: <m37i2b2ecu.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 16:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDgo-0005fc-Bh
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 16:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbZC0PIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZC0PIK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 11:08:10 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:63206 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZC0PIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 11:08:09 -0400
Received: by ewy9 with SMTP id 9so1096481ewy.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=JQkbBAdCRvurWB9/mmiARWS2Tad+QrkzgpfcmA584uM=;
        b=qEwvYHiTX332oA1AUFGpk3qw4kSgKVaGy8UspIWRdb2IGeWBtKfLwlME8C7sBPlmwx
         QxhjisxpHTJiACoc32Ii/kr/MRwG9uTRNLYCnk2869M2Diwn0pGNpUewHEN5GgUB9oEB
         0gEiD8ADlSr5zeW0KGYUsuK1prNu6RWjWkpzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ksCcf3oTm3ZPLVbOZRnXBYSqfG81QlSsF6ZQ9KVaomctAeEUMuVyQxYF8f2jKEILdc
         HV5VI4mqY79BRWMWQR98RH/3l4pJbioLBy+ojEk+OZPWlW7B7U5nxXlnXnLANgPeOz8q
         ONo5hyX2WAuvri26Yaefkq7ULUPc/5PSyv8lA=
Received: by 10.216.36.73 with SMTP id v51mr838416wea.215.1238166485725;
        Fri, 27 Mar 2009 08:08:05 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id u14sm2417497gvf.31.2009.03.27.08.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 08:08:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2RF82Xd009010;
	Fri, 27 Mar 2009 16:08:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2RF81Y0009007;
	Fri, 27 Mar 2009 16:08:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114903>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Dear fans of Git,
> 
> a while ago I announced the UGFWIINI contest, a glorious battle of ideas
> how to
> 
> 	Use Git For What It Is Not Indended
> 
> As most of you probably did not find my blog yet, this may come as a
> surprise to you, but it will not be the only surprise in this email.
[...]

Not exactly UGFWIINI yet, but:

  "Music collaboration via git?"
  http://www.37signals.com/svn/posts/1655-music-collaboration-via-git
  (sharing LilyPond source files for music notation).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
