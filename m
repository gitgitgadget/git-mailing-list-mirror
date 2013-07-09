From: John Szakmeister <john@szakmeister.net>
Subject: Re: Git in nutshell Inbox
Date: Tue, 9 Jul 2013 14:37:56 -0400
Message-ID: <CAEBDL5ViJqSOQB3ydK7jqmbeeQSBBJrFE09A+sB2h12Y2_D3CQ@mail.gmail.com>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
	<vpq4nc3g5l5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 09 20:38:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwcna-0003cS-9h
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3GISh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:37:58 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41993 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3GISh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:37:57 -0400
Received: by mail-wg0-f42.google.com with SMTP id z11so10186201wgg.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Qi4Z4i+Wu14XlcFj7GZulVsKNj7/CUp59TEWycF7w98=;
        b=ReDS4Tx6WLhdUL+IruGuSxt20ncIpKT4IwFDnCUzcKmIy11y05nLr1po0nsGAtc6xQ
         5wEWf6KlsySUt70Zo0G+94xWTwv5LXkQ+i7To2ltncPIYAdqlXWLloQmEejO6FIDxP1q
         un0gxN+ap3UjWxPN0e0W/oCt4KEHRNFzohwB+PBP+fivmF60tG2166C5Z612pnlPYdq5
         5LTZB81ik/+JfHcDL1Bb9zNcLHcATxhz/IbwcLxjUwCYpwtiatY62Gar4Sav3SSaFWpS
         ak1cPGal3G6pkjrkcTw9EqkT0V4vk/NgN026CMP2E1qvpf8Dbl8Zs1JKZ7qnv0Aibqsj
         XxLg==
X-Received: by 10.194.19.130 with SMTP id f2mr15606531wje.22.1373395076605;
 Tue, 09 Jul 2013 11:37:56 -0700 (PDT)
Received: by 10.180.160.200 with HTTP; Tue, 9 Jul 2013 11:37:56 -0700 (PDT)
In-Reply-To: <vpq4nc3g5l5.fsf@anie.imag.fr>
X-Google-Sender-Auth: 20meFUh4UuYc0N0lMuQwltWGRPs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229976>

On Tue, Jul 9, 2013 at 10:39 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Muhammad Bashir Al-Noimi <mbnoimi@gmail.com> writes:
>
>> I'm bzr user and I want to migrate to git. Generally I use bzr through
>> Bazaar Explorer which is very easy & neat GUI utility for managing bzr
>> repositories. May you please guide me to most easy way to migrate to
>> Git?
>
> (I think it's a mistake to stick to GUI: the concepts are easier to
> understand with Git commands IMHO")

Ditto.  I think learning the command line makes the process much
easier in the end.

> But there are nice GUIs for Git too. The "official" one is git gui,
> distributed with Git. I do not like the visual aspect a lot, but it has
> a very good coverage of Git's functionalities. Otherwise, have a look at
>
>   https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Graphical_Interfaces
>
> git-cola is a good one.

You might want to consider giggle.  I've not used it, but it's more
BzrExplorer-like, IIRC.

-John
