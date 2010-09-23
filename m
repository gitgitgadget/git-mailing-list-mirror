From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Improvements to `git checkout -h`
Date: Thu, 23 Sep 2010 20:26:42 +0200
Message-ID: <AANLkTikjqW5R4p90T3pWACPG9vGqd4uRETiE-Wb_BybS@mail.gmail.com>
References: <AANLkTikra1iE5JpXvvPnNcwE=XEDF6B=ubCteEi77dqX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 20:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyqVn-0004tt-Ci
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 20:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0IWS1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 14:27:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55691 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0IWS1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 14:27:05 -0400
Received: by pwj6 with SMTP id 6so375964pwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=3vA0nLECp3vuPZ0HhMg1UeYljmjXN3Nr1N7AtGe99HQ=;
        b=IVgAFmr8Se33rIV6//t/FKC/giTHZ06HUyZRMjWhzuKVJgSGMAQO9y8USMMAlSxN9H
         qDfsmVRNWuwsqEyQGDu8Ou2hQzXHpF1LqDV3owm7JcuNYc3s2bfAqkYISkHqBMuNQG0T
         MdLtPAphVHQCrqhSYwukS3YFdY6Y7rW3lJHF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=YKjNli2b93Zy5+ZoIf8O9BpZoMnn8veUmd1EXiSu2800oOUg9//fBalkAvsxCNavSY
         G2t36wgB1veTeIjGRK9MngFzR7BFXX5dyV0ia9zsbxm+AAlJf+lgX717dP1/3CN2oMWY
         6IAZ8RO4ZfQQHyXczAoHSNSzWobZ04/SRvgmQ=
Received: by 10.114.12.15 with SMTP id 15mr2294834wal.134.1285266423127; Thu,
 23 Sep 2010 11:27:03 -0700 (PDT)
Received: by 10.220.189.200 with HTTP; Thu, 23 Sep 2010 11:26:42 -0700 (PDT)
In-Reply-To: <AANLkTikra1iE5JpXvvPnNcwE=XEDF6B=ubCteEi77dqX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156893>

any thoughts on this one?

On Sun, Sep 19, 2010 at 9:41 PM, Knittl <knittl89@googlemail.com> wrote:
> print more information in `git checkout -h` to stop people from
> complaining about git's help ;)
>
> http://repo.or.cz/w/git/dkf.git/commitdiff/95209979cb1a0de071a3cceac593fbb40235b926
>
> cheers, daniel
>
> --
> typed with http://neo-layout.org
> myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
>



-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
