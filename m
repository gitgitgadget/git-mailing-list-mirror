From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: using git with Google Code
Date: Thu, 25 Nov 2010 09:03:57 -0600
Message-ID: <20101125150357.GB16049@burratino>
References: <AANLkTiksVbmUX9QE6B385UjboqcvgAo+mwKP_X--P+83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bond <jamesbond.2k.g@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 16:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdMq-0001jB-V3
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab0KYPEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 10:04:07 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47893 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0KYPEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 10:04:05 -0500
Received: by qwb7 with SMTP id 7so1051850qwb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tBZPxWap5Eks8RxJukPjDRyGv9he1OglIowO1udO2ZE=;
        b=dmPIZ3VBND/gPzDF+5EDsc8QgTrEPgTe19qtg5n/3hv0TZf2wIND9ouLG9X0l577wJ
         h9zlsYBDDTpMMel5puf2yZthCKA4/V2q8PQZYoprxJed8YhMp7znyVYqJ3lxc1pU2QrO
         FU8lSWWOQxnrtsc3cNRTpV6oNi3DUHUlRkguk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Uf2NpeawSD08QbD6i9LAdnvlI6wSh7VzgYkP5j6d7zo4aGTKXqEcUeW20IhnynkRvi
         QprqNusCNcNs5uzkGmy2tO82og1yWNin1EmzKyRPxsGPnsEmo9LVrssdH6c267MKpd+W
         +K11plt0PQ2mFC2OY/8IJiYDTJhithLSzasQg=
Received: by 10.224.216.134 with SMTP id hi6mr826664qab.299.1290697445295;
        Thu, 25 Nov 2010 07:04:05 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm504541qcb.24.2010.11.25.07.04.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 07:04:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTiksVbmUX9QE6B385UjboqcvgAo+mwKP_X--P+83@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162135>

Bond wrote:

> git svn clone --username me  https://myproject.googlecode.com/svn/trunk
> git: 'svn' is not a git command. See 'git --help'.
> 
> Did you mean one of these?
> 	fsck
> 	show

Is git-svn installed?
