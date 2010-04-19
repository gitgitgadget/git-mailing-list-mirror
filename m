From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Compilation pb of git-1.7.0.5
Date: Mon, 19 Apr 2010 08:26:59 +0200
Message-ID: <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com>
References: <201004190759.15032.yves.caniou@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: yves.caniou@ens-lyon.fr
X-From: git-owner@vger.kernel.org Mon Apr 19 08:27:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3kSA-0007ys-Op
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 08:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab0DSG1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 02:27:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:48671 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0DSG1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 02:27:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1767329fga.1
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=xBiOxY1jSzD9naGfRwDj23czJzT9Tz/q1AJtw6I0JbM=;
        b=mO89rhipEYqxWv0a+6nhFIZh8bogrBq1J7MJJ/nxSWkyky2uguyNqbWvkX7UFI2XMc
         bBsaJZFEiqSMiNO1JaRxnLATNxlgZukXtw1dn5DEiCY9lITFZA4IvXHTK9Aj8x4AoUfk
         vzxD9eV1n2RuOtnMLvBxAk+j8njs554k1RAX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HhWdsGVYN2BfWIzOVaZnS91AAzNgk8AQHRbtKpe+ECBoRSmiMEp/X/xsiUApUr2WS/
         JwVya5izgkQOLIIuemhmQXRuHRLMl8Hp6ISynugECW6SUNfwGyAfK/6WKRGBlNWxUWUS
         hw7J555W6DhmTISF23Q/bVZ1f5gumntmbOFoo=
Received: by 10.86.90.12 with HTTP; Sun, 18 Apr 2010 23:26:59 -0700 (PDT)
In-Reply-To: <201004190759.15032.yves.caniou@ens-lyon.fr>
Received: by 10.87.38.3 with SMTP id q3mr3669247fgj.26.1271658439180; Sun, 18 
	Apr 2010 23:27:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145265>

Heya,

On Mon, Apr 19, 2010 at 07:59, Yves Caniou <yves.caniou@ens-lyon.fr> wrote:
> After the ./configure --prefix=$HOME/git, the make all gives me

Which revision are you trying to compile? Also, it's probably more
helpful to just post the result of 'make all' verbatim, rather than
snippets.

-- 
Cheers,

Sverre Rabbelier
