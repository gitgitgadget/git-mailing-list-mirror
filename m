From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Sat, 10 Apr 2010 02:16:01 +0200
Message-ID: <g2vfabb9a1e1004091716i681a50e2k9597b57b577e1663@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com> 
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com> 
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 02:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ON9-0001e3-Fz
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 02:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab0DJAQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 20:16:22 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:40762 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab0DJAQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 20:16:22 -0400
Received: by gxk9 with SMTP id 9so2262376gxk.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=DpaMq53LKpJpZMD82iZebBCVAozcerz1pMSjPwhvzuA=;
        b=w643pcOTk+ZO17tamWBYwEwin4N2Yy6o5hTqYvt+1Fr2PW0IZ+pqbrtfxcas+0cP54
         nMNcjAt/4HJzJLVx2kYyOQmpl2RVGmtQlvQWpuNRkytYfvbG+X9pzC/F+JVzYgVvytE1
         LR5i3BEXGfWyeoMuzlkGOzNrt//gKkdy2wzmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gUcrIsvsNLMn44jEJNZjTh6AhAHCW+8BGCGTp05yCX8EZuIaMSrZhzUHlqcCCU37Tp
         KU9H+KLUiwIYyLARNfKMLSE4JDvBHkj7IkIPHDA0qSLQ67OrUWhoza4PqbMqGcqBLzmd
         WJZLBQw5MqGGYns/L+9dGA64jL9zXzavUazS8=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 17:16:01 -0700 (PDT)
In-Reply-To: <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
Received: by 10.101.101.2 with SMTP id d2mr1102946anm.240.1270858581127; Fri, 
	09 Apr 2010 17:16:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144493>

Heya,

On Sat, Apr 10, 2010 at 02:13, Aghiles <aghilesk@gmail.com> wrote:
> Oh, I should have read the documentation. I was certain that ".." stands
> for a range but it is a ... complement.

Err, yes, sorry, wrong link, should have been [0] :). Teaches me for
copy/pasting links from [1] without checking what I copy/paste,
they're right next to eachother :)

[0] http://en.wikipedia.org/wiki/Complement_(set_theory)
[1] http://en.wikipedia.org/wiki/Set_theory

-- 
Cheers,

Sverre Rabbelier
