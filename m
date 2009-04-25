From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: cygwin - clone on repo fails
Date: Sat, 25 Apr 2009 19:18:23 +0800
Message-ID: <be6fef0d0904250418h43749727t8979e9298187b47d@mail.gmail.com>
References: <81bfc67a0904231636l53d3970cycd1ff1dc70c8568c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 13:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxfw0-00041C-6r
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 13:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZDYLSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 07:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbZDYLSZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 07:18:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:51799 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZDYLSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 07:18:24 -0400
Received: by wa-out-1112.google.com with SMTP id j5so789210wah.21
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rEExKWXyewZ3oqQ9OoNnIEmjt41TpCiPHuEHONaTVjU=;
        b=MxjMT2LyxjvNfoqK5SO1djzDrlv+1QFX03iPN5B/yDg44gVY9cZTdVIZVpx6k/buyl
         tLSOXFglvywXQBWhzrwgZW5KERDMBq41/BMKJCA2biUIjHi0DvEguC1HfR5dAqG67W97
         wZWDcBhP10C6A9eNwTmPtmudnAHuVnHnZwNRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZHeU8R3OzCa66jvJJhJkMQhjSbTH8iDTCShEZ6zHphdrk6TCm3kEWIzp9zIYSMBlLf
         mmwolvXCXxwg+IxaUa7xR7AB7gzZvTUIxGP5Lb83q8b6hMYvk8kcsmI8BROyWv4MFxfe
         UL69Ldj3e94dODZHzM6Ho+QkLuzNBQOEHkIGI=
Received: by 10.115.48.12 with SMTP id a12mr1844829wak.167.1240658303040; Sat, 
	25 Apr 2009 04:18:23 -0700 (PDT)
In-Reply-To: <81bfc67a0904231636l53d3970cycd1ff1dc70c8568c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117548>

Hi,

On Fri, Apr 24, 2009 at 7:36 AM, Caleb Cushing <xenoterracide@gmail.com> wrote:
> repo works fine cloning to my linux system

that's a pretty hefty repo.

Could you check what version of git you have on cygwin (git --version)?

You could also try cloning the repo over http:// instead of git://.

-- 
Cheers,
Ray Chuan
