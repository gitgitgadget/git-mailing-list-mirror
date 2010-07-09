From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 9 Jul 2010 07:40:06 -0500
Message-ID: <AANLkTinS2jd0HPn5I6jI4s_Wo-hIqJhNhce9DWSmOrSH@mail.gmail.com>
References: <20100708083516.GD29267@debian> <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl> 
	<alpine.561.2.00.1007081113210.3936@daniel2.local> <4C36706E.7070400@orcaware.com> 
	<4C36DAF3.7090208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Blair Zajac <blair@orcaware.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <bert@qqmail.nl>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	dev@subversion.apache.org, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 14:40:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXCsb-0007mJ-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 14:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab0GIMk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 08:40:28 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35802 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab0GIMk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 08:40:27 -0400
Received: by gxk23 with SMTP id 23so1119439gxk.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=yqXfxL6k6ZjRgm1z+9lvGdIt76tubFCZr5j5OHTwqUk=;
        b=XgOXDyR7WKjqIyEw0LOzbsSzkOULefbKZQk9Mrjq/nERelJawDF5TmMjWa7s1OG2Sp
         6Nrq3Lm6xq/UVrgr0XlkhArvEe/lXzTYLwmNPhAmEDlRKMTgYI1Vaz58WoJWGMuAPCgq
         Pwq2vtvKtakVSwyUFjalVzsE7qxB0bI7deKJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eEM+XHXomGFxBGPFHd7l2MrJlCQjImihfEMa/FlqIxbd1hb5pOMxIX558uriCwIeYh
         tcvx2Ns26NVIOhXfsYSPnCW9sbl983SqaIUb1Eq5gtKjJa5FlEtL99X1RSqPC7TZTbGL
         0ZXOdqS3kgyaIe7P1kJP+prguWgdtL1Gp7bLM=
Received: by 10.151.122.13 with SMTP id z13mr1797038ybm.353.1278679226289; 
	Fri, 09 Jul 2010 05:40:26 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Fri, 9 Jul 2010 05:40:06 -0700 (PDT)
In-Reply-To: <4C36DAF3.7090208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150657>

Heya,

On Fri, Jul 9, 2010 at 03:16, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> In fact, on the git list we tend to trim as little as possible.

Huh? Quite the opposite I thought...

-- 
Cheers,

Sverre Rabbelier
