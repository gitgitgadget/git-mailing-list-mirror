From: demerphq <demerphq@gmail.com>
Subject: Re: Escape character for .gitconfig
Date: Wed, 21 Dec 2011 14:59:01 +0100
Message-ID: <CANgJU+U4Bq0yHmJYndV_4xaymFca2JVNg7sfuN9jB92ts=aFkg@mail.gmail.com>
References: <4EEC6A9D.1060005@icefield.yk.ca>
	<alpine.DEB.2.00.1112211352580.17957@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Blake <erik@icefield.yk.ca>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Dec 21 14:59:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdMhJ-00064Z-Na
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 14:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab1LUN7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 08:59:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49139 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab1LUN7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 08:59:02 -0500
Received: by yenm11 with SMTP id m11so4619719yen.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GMtbtKAlbtKF9FbIeqSzp+Fv1Veb92N9fYjn18ER9q0=;
        b=ABbQc4Eu1UdB2p3HoXje/Az2gSIousvBfPCWxe772TfQLua1euWY5WgkxpNDLSZhVW
         vQqbs3XPHuBAgsB/g8ZAIxouKDTfXgqXbZZ9ie+3ca/ku6HiFVwGYwyf0gMluBeM9fqz
         kdNteJ6MNJ66IrgIO49xHXEyhXrooah7kxthQ=
Received: by 10.236.152.35 with SMTP id c23mr9328708yhk.58.1324475941181; Wed,
 21 Dec 2011 05:59:01 -0800 (PST)
Received: by 10.236.72.132 with HTTP; Wed, 21 Dec 2011 05:59:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112211352580.17957@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187563>

On 21 December 2011 13:54, Peter Krefting <peter@softwolves.pp.se> wrote:
> Erik Blake:
>
>
>> As you can see, I'm running git on a Win7 64 machine. Is there any way to
>> escape the brackets? Or do I need to reinstall notepad++ on a different
>> path?
>
>
> Just use the 8.3 path instead, using either "C:/Progra~1" or "C:/Progra~2"
> (depending on how the system got installed). You can mix 8.3 and long paths
> in the same command (so keeping the "Notepad++" component is fine).

Or use a junction to make an alias of the name without strange chars....

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
