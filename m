From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 14:03:38 -0800
Message-ID: <3ab397d0812301403y53e0aecbo7f1e153ad3b76de5@mail.gmail.com>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
	 <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
	 <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org>
	 <gjdmm6$9oj$4@ger.gmane.org>
	 <3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com>
	 <gje4ff$ip6$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:05:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmhy-0008Eb-9V
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYL3WDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYL3WDk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:03:40 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:17520 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbYL3WDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 17:03:40 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4344648qwe.37
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 14:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=c8sCSiWKuOKwGptDckP7/qo2Y9peLIZWCVaW8vjG66o=;
        b=HMxeK/zEZ11PorlT7+1vJh0vQk1pKtt2MBV+C8oFhWAH1OEHgogqc4qsuwdc2cwBVX
         +37yjVWkjYm14owYDmrMav5RZz6mjRzmYiwcbY9QR/YSQcV2p0IHuBvN+egNns1wGSE8
         fFf5zd+d/h5h61Mp7FsTO64zM6w8Io0RQvCFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YBbAGgYr6FJIiUf8oAYjVlbHBiZDKr+4f+R/pWAOIS1a67jwXD+NNdk2hpYnRMCUtt
         ymbK/vRKfqXFxdlx7fJEebx2hc+QED0QLZVr4yhuMh925W6EDVTA1cUzHnhstraJ/bM0
         Yz0FY72uAl3bV2y01GMZ9E4/fZtBzQh+CyvoE=
Received: by 10.214.60.4 with SMTP id i4mr13137743qaa.363.1230674618927;
        Tue, 30 Dec 2008 14:03:38 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Tue, 30 Dec 2008 14:03:38 -0800 (PST)
In-Reply-To: <gje4ff$ip6$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104213>

>> good news, use "git checkout versionA", not "git checkout versionA ."
>> (so, use it wihtout the dot), and you should be back in working order.
>
> ** yes but I don't get the files copied out into the tree which is all my
> little heart ever desired

you dont "get the files copied out into the tree"...  i have zero idea
what that means wihtout punctuation and context, but i'm pretty sure
that you want to do a "git checkout versionA", not  "git checkout
versionA .".  if i'm wrong, then maybe try a git clean?

> But you're right - chances of using are slim - but you could say that about
> every version sitting in any given SCM repo.
> Thats why we have SCM, and why we insure our cars etc etc. :-)

i punish myself for saying what i did.  shame on me.  you're totally right.
