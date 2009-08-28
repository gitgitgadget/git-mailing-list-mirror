From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 28 Aug 2009 03:22:58 -0700 (PDT)
Message-ID: <m3skfckzk1.fsf@localhost.localdomain>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, teamgit@googlegroups.com
To: Abhijit Bhopatkar <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgybr-0002R4-2Y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 12:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZH1KW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZH1KW6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 06:22:58 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42742 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZH1KW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 06:22:57 -0400
Received: by fxm17 with SMTP id 17so1479056fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gZsQn37i5DEo+xd3LmoEsNks7/x+0G4HfswEuyMSceI=;
        b=kWtfgJhOJmKgo7fLji7wjLKJ8KwYlraiCRYQ+PkxZGSgqzl45z6DTaXVxkn6nbFWg3
         acSszBkxubojlelypKAVaM8N+pGJGr0TB1cnZgGV9qW72LUxAv4fFB6VIo+/oqnAgDLG
         RXSXilbk3EuYziACRldsW/SBC7qAgYcPosubk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DbzLzHQfFHyS5+ig8g/HF141QwX4zhZOT0+T1tcJ8rRT6NPF3KMQW5mKWCPJaienuj
         K3SzGkF+AhAyJhzwmTcL3ivLsW3z4f6ZESk6oHykoteJR+fWK/BSOzqjAlNAjy5WhXH1
         3bEusAArdN67JvoU0/h5G1Gk4FVsfED/f8tKs=
Received: by 10.102.204.21 with SMTP id b21mr177336mug.9.1251454978908;
        Fri, 28 Aug 2009 03:22:58 -0700 (PDT)
Received: from localhost.localdomain (abvl130.neoplus.adsl.tpnet.pl [83.8.209.130])
        by mx.google.com with ESMTPS id e8sm4516070muf.6.2009.08.28.03.22.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 03:22:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7SAMurn022623;
	Fri, 28 Aug 2009 12:22:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7SAMtgc022620;
	Fri, 28 Aug 2009 12:22:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127286>

Abhijit Bhopatkar <bain@devslashzero.com> writes:

> So I ask you people, is there a solution already cooking someplace?
> may be something i can integrate with teamGIT? (e.g. bonjour plugin
> for git dameon)

There is gitjour:
  http://rubyforge.org/projects/gitjour
  http://github.com/chad/gitjour

-- 
Jakub Narebski
Poland
ShadeHawk on #git
