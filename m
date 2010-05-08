From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: tracking un-committed patches in mailing list?
Date: Sat, 8 May 2010 07:01:06 -0400
Message-ID: <l2u46a038f91005080401vf3e5b16t9fe26be5cd5baf92@mail.gmail.com>
References: <m2u46a038f91005071044w15594056sb7753b6268979228@mail.gmail.com> 
	<p2obe6fef0d1005080332k26621c2fw48ea2482e84202dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 13:01:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAhmm-0004cK-Cy
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 13:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab0EHLB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 07:01:27 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:47377 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0EHLB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 07:01:26 -0400
Received: by yxe1 with SMTP id 1so1380794yxe.33
        for <git@vger.kernel.org>; Sat, 08 May 2010 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=UhEaiKvxRC6lfwVf1vRx28Uf+jEGLW6E7/56czXZo1I=;
        b=g2x3vUd+kQPXlO5J3qgBZTnI6Tm8B9lhw19Nc3aPFyrb0zIOPZA7z0qezfSxTX3Ehv
         J4NJ/wNFO/ZXdcxik+DNuJh4hRtM/DizI4OWz331OTxptJvpMma1T/Aup17hn630uNtC
         1eKDf3emuBXEJ7/9rg7CA7k3tbaAkbjJ8B64s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Jf4cqCV5Jxvwr10XAgZtKN4yIrMUjqjZk1Wi2dmc/XrPMK5I5TyNpFi6zs9s+HBUkP
         KY3Jh0h3ffu/sQRJZ8b+WwtOUtTWDOW8DAkgnXMYC5XaiygVpp2GGXdH/sAwsg7P2Ics
         XHojUovnPHvRwsciBkSXEYjMrh0lvaXSkAq/s=
Received: by 10.231.168.85 with SMTP id t21mr898120iby.0.1273316486176; Sat, 
	08 May 2010 04:01:26 -0700 (PDT)
Received: by 10.231.120.230 with HTTP; Sat, 8 May 2010 04:01:06 -0700 (PDT)
In-Reply-To: <p2obe6fef0d1005080332k26621c2fw48ea2482e84202dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146657>

On Sat, May 8, 2010 at 6:32 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> AFAIK, except for the authors themselves of patches, I don't know of
> anything tracking them - well, that's my experience as a patch

I found it -- patchwork; see https://patchwork.kernel.org/

Not git specific, actually. But a damn good tool.



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
