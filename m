From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 10:04:40 +0800
Message-ID: <CACSwcnTsEiV7ehanPAxJm-SGP+P16FgvWYpEXtF9NK8fG2aNHA@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:04:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYmk-0005Di-OE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab3DOCEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:04:42 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:56054 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab3DOCEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:04:42 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so2570208lab.39
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9sRnC7B2h37cg6TejVAXqnJRv1CWSS3JTLiiJ72vLUQ=;
        b=nVb1JQri9CrLfrY68EHkusdh29sMSP+7auUsDqCwsiqoSf82ObUyfxD0wlsB7O17Dy
         eSZB2FA73CjBkl6gYAKsRCO4ZzttxRq2EtjmvsQK3WTZM5yqEsJKoXaeCn8rqKCDPxHv
         llPt9Od8lQ5piOrFjn8ugZTbDE2SrQXwGXYJwO6zZdsI2DG3Wkzdq7Qjvk+D9OzWFLjX
         GvTpFVw3oeHCYD2ui2LtsNpJMcF0TC65+gi631osdXR3BNHONhN1uy/qk9IZK2dOllER
         VcjOhF9Brqa8F/odSxFNpSsoGMt3ByNioMhtpA2MbC/VCDWhrTp6SeKuXAuMlCzccq3c
         v+PQ==
X-Received: by 10.112.125.134 with SMTP id mq6mr2767382lbb.33.1365991480463;
 Sun, 14 Apr 2013 19:04:40 -0700 (PDT)
Received: by 10.152.135.140 with HTTP; Sun, 14 Apr 2013 19:04:40 -0700 (PDT)
In-Reply-To: <vpqobdg515m.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221182>

> 15 git rebase --stash, git pull --rebase --stash

It seems that Ramkumar Ramachandra is working on this in his "[PATCH
v2 0/3] Introduce pull.autostash" series
Ping Yin


On Mon, Apr 15, 2013 at 4:04 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> Like the years before, I'm going to offer my students a 1 month project
> (end of May -> end of June) where they can contribute to a free
> software, in particular Git.
>
> Students are free to pick the feature they want, but I maintain a list
> of small project ideas on the wiki to help them:
>
>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
>
> fell free to edit and comment. Students will anyway have to discuss here
> before starting to code anything non-trivial.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
