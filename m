From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: Local copy of the repository files
Date: Mon, 7 Feb 2011 11:22:38 -0800
Message-ID: <AANLkTimmpKjoNR7X6ChpRMf1rsWGAkMcHOt21Q-AybNE@mail.gmail.com>
References: <4D503E0D.5050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Roberto <mrgreiner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWiD-0005MX-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab1BGTZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 14:25:20 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63218 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1BGTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 14:25:19 -0500
Received: by yib18 with SMTP id 18so1861337yib.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 11:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pfAp2/rjFcrxzeIL0neo4L5Q/D2c3gniA2VEomiqbQI=;
        b=I4OVbYj2KNLhHgdqpwsE4jPQot7FFUrSGL0qPIuy3KC2fgMHcikZpja/HYlZNKGIwt
         srmebFHZJfW5dhT63fd82w01ucIlH9EkfmYOb6FHZj16K+166U8fuy5DZC6ZkIsuVoMg
         /auhpJTKaYhI/9i+ZOxK6gUdm9djrjvKRnch4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tgrfD9TGscLK/p/qess5t5TbXumm93u+fjITn0aXvGJWgnGFmSQakaaRmg8vyecXJa
         ExV0z4pd8tgYOIYHi4s5usES7rxXSwhD3gFa1jBJsvNhhxGdP0HY+LE/AIza3GKvoLpk
         azueYl+dK4JSYnxmzX4YRxGlTAJ40AMaAArDQ=
Received: by 10.236.110.173 with SMTP id u33mr31774910yhg.46.1297106559076;
 Mon, 07 Feb 2011 11:22:39 -0800 (PST)
Received: by 10.236.109.147 with HTTP; Mon, 7 Feb 2011 11:22:38 -0800 (PST)
In-Reply-To: <4D503E0D.5050105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166272>

On 7 February 2011 10:46, Roberto <mrgreiner@gmail.com> wrote:
> Hi,
>
> I'm trying to make my git repository automatically make a local copy o f the
> repository files, but the appropriate command (or commands) is eluding me.
> Could somebody give me a hint (or point to the appropriate document) as of
> how to make it work?

There's a reasonably succinct guide to setting this up at
http://toroid.org/ams/git-website-howto

Conrad
