From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to manage multiple personal projects
Date: Wed, 15 Jul 2009 10:45:32 -0700 (PDT)
Message-ID: <m3ws69u9g0.fsf@localhost.localdomain>
References: <a1138db30907150900j7d6152ebs755d83adf7717287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 19:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR8Y4-0005tN-Cf
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 19:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbZGORpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 13:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZGORpf
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 13:45:35 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42188 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807AbZGORpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 13:45:34 -0400
Received: by fxm18 with SMTP id 18so3609052fxm.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RZXAhQxb8nCAXFI+2K4dZPfsQfvM88MhhILbQLL/Aqg=;
        b=epliyIVDNbHYmUkAh/l72j+zhVREFlsXlWgGU0DTkkWc21mYZo+hPNAyTohFVGCEL6
         w7zBq2X/ASQgsJlDtp2DVMCymRGqM/GcrZxkbmQwWT0mjd1p1HCPS/OOfELi5ddJku3Y
         oMWegsDL18+2Uk74wE1GKnQ3a6AA5CRjdmDPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rom9uaofpLAcb6Ra1ssAH5l8iCaKKch+A4Kmp9CNvZRPvcYOjLQtYx5G8JfJBKAa0t
         XzxCEcq1kietwTyCIUOpq12gOwA4NDORrzJfyi8JCD4E8z5QucrkUpjtjnSVIimpjDYt
         whZha4NW5tIc3+56o2PzQq/RdWjVrqdLu2Fqg=
Received: by 10.86.59.2 with SMTP id h2mr5266180fga.60.1247679933152;
        Wed, 15 Jul 2009 10:45:33 -0700 (PDT)
Received: from localhost.localdomain (abuz24.neoplus.adsl.tpnet.pl [83.8.197.24])
        by mx.google.com with ESMTPS id 12sm8759846fgg.14.2009.07.15.10.45.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 10:45:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6FHjRSu008545;
	Wed, 15 Jul 2009 19:45:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6FHjKq5008541;
	Wed, 15 Jul 2009 19:45:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a1138db30907150900j7d6152ebs755d83adf7717287@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123328>

Paul Richards <paul.richards@gmail.com> writes:

[...]
> I believe the correct choice with Git is to create a repository per
> project.  This would work OK for me, but I worry about the shear
> number of repositories I'd end up creating.  Part of the nice thing
> with my current Subversion setup is that starting a new project is
> very easy and cheap, I don't create a new repository each time.
[...]

Perhaps 'repo' tool developed by Google will be what you want?

  http://android.git.kernel.org/?p=tools/repo.git
  http://newblogtopic.blogspot.com/2008/11/gerrit-and-repo-android-source_04.html 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
