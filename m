From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 23:54:52 +0200
Message-ID: <CACBZZX4dYjHETCyMFQngBKoS80gkmcAZKKYc0VkE0ufaAg-gZg@mail.gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com> <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com> <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net> <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
 <20160504200635.GA22787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 23:55:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4lP-0001vR-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbcEDVzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:55:17 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34812 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbcEDVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:55:15 -0400
Received: by mail-qg0-f45.google.com with SMTP id 90so31218138qgz.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DnGv0sp2prtbX+MSzJ4LJ+IVhQeB0lfCPnO3jz9lFz8=;
        b=BeWq8YCE9PGK1uwxgb/w93F8Wtg3a0Tp8YN+AyBTcmCeA1iqg8xPm7d0yvtI0b+Dxw
         w0UgeKAEu3e827aKUq7jgqBLMdf/bGmC096y9Bhm5Syzg+qOdRIAnbMJxr+R8zPCb7uU
         +kMiAtupsY40UCYxI9D779jDT3m6kPFTL6c5MUBmvxOfKTOXsZDX5ei5aBqjG7gDCBBh
         xKUPdCfVcEmjuZTOlOybHj1G4hqG3C4hhC0N6GLA9npna8ME+ZJzq0BJpxg360h3oB3B
         fY7k5n7dBZybJK1QU6u8V5WwuEQ4LYh1Im8Uczibu9xY5xS4uyw0wf9HfXa4ILlSJ8G4
         gCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DnGv0sp2prtbX+MSzJ4LJ+IVhQeB0lfCPnO3jz9lFz8=;
        b=jbdFMsffcG0EcNcldYMOkF++ZV7qxi1wDKshgulSQoXEaNmpeajVjAgzect8y1wZKb
         rwV8Bt1OtWkajaX1eDDf+Ky3cr8kDwqlyZmEwyAUktx3K+gSIAhqJbdfBAA+dd8Exd+v
         yURsRFkmhtvd0VQ9Zo0eqTeDO653ZANgtwdR0ZAu9p3TSLOYsLtveC5DYWqDxy9n56EF
         HT79jVppuxhYFnA09ujce4AxIp0pKCHRWRYToxRWccimjjSYh9YUfp7z9FHvACBdvDE0
         Bw8ziBaxPtqPu9J7w0+SeBrCdl27mYIL2CxU8Kkf/aszbk3a+Ov0aJIFzRUn1LDKLVQp
         baIA==
X-Gm-Message-State: AOPr4FV7RVS+E25xVb0VLSD3IL9u49Mms1NxVn1jJNQ07pvLheYfmkX4adCBG1ihdMMOBteojUycytULaz5YiQ==
X-Received: by 10.140.218.82 with SMTP id o79mr11586817qhb.33.1462398912322;
 Wed, 04 May 2016 14:55:12 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Wed, 4 May 2016 14:54:52 -0700 (PDT)
In-Reply-To: <20160504200635.GA22787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293604>

On Wed, May 4, 2016 at 10:06 PM, Jeff King <peff@peff.net> wrote:
> Would:
>
>   open(my $files, '-|', qw(git ls-files));
>   while (<$files>) {
>     chomp;
>     ...
>   }
>
> make sense? Or a simpler but non-streaming spelling:
>
>   my @files = map { chomp; $_ } `git ls-files`;

As a minor sidenote you can equivalently write that as:

    chomp(my @files = `git ls-files`);

I.e. chomp itself when given a list will chomp each item of the list.
So no need for a map.
