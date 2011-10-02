From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Sun, 2 Oct 2011 15:25:19 -0700
Message-ID: <CAE1pOi0HGCSXQL-=tVmOm-3p8BNd02h3MwyRMWRRANvQyovfUg@mail.gmail.com>
References: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<20110822210141.GA3880@elie.gateway.2wire.net>
	<CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
	<CAFzf2Xw6=BFsKauYTG-4cw0D_LzLSNb_wqz8dQJ83wJHNQXbdg@mail.gmail.com>
	<CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
	<CA+sFfMf=gi5CWyfZEt-Nmdr4J9g__maQTqy1WePr1x8D-AVr4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Michael Witten <mfwitten@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 00:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAUTT-00035H-Nr
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 00:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab1JBWZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 18:25:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54113 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab1JBWZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 18:25:20 -0400
Received: by qyk7 with SMTP id 7so3128611qyk.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AJX8DrymO1ej94aDnjyflT8lyjcKVSvbSRPJ6DqcNtQ=;
        b=Dc1etSyO63K0hDKYlrq1JfkaOTYRaYFKLKamgDGXXG6oH9uFFjJ55ElfYXUZBOUf0B
         vtUf6EyCseRbDL64Qy9TZsjBYAzXubC7lfutolzDK7hkoUkkglFSvnqrUjwS3efF9AMI
         c4g6rl83h6VVT4zcxhOpdSvgkaDrHDpS7/5K4=
Received: by 10.229.64.163 with SMTP id e35mr10484957qci.239.1317594319670;
 Sun, 02 Oct 2011 15:25:19 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Sun, 2 Oct 2011 15:25:19 -0700 (PDT)
In-Reply-To: <CA+sFfMf=gi5CWyfZEt-Nmdr4J9g__maQTqy1WePr1x8D-AVr4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182611>

On 2 October 2011 08:47, Brandon Casey <drafnel@gmail.com> wrote:
> On Aug 22, 2011 10:06 PM, "Hilco Wijbenga" <hilco.wijbenga@gmail.com> wrote:
>> Is it possible to do git stash
>> pop without losing the stash?
>
> That's called 'git stash apply'.

:-) Yeah, I had actually discovered that myself. I had been using
"pop" and "apply" interchangeably until I noticed I had a number of
stashes stored that I was not aware of. That's when I discovered they
did in fact *not* have exactly the same meaning. :-)
