From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT4 PATCH 0/6] Some UI Improvements
Date: Tue, 24 Jul 2007 00:13:04 +0200
Message-ID: <e5bfff550707231513u8568e48hb280151b8f40681c@mail.gmail.com>
References: <200707232232.39546.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Oberndorfer" <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID69S-0002C3-6A
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbXGWWNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXGWWNH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:13:07 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:55760 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXGWWNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:13:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1225193nze
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 15:13:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=togEifA1KSD78kR24d2q/2pMBfBToDjyV8I5EyLuYvclZyu/4jxZHz95CkDG1lgNPnrHyq/SDihwp2DJIzHVg/orANNC1jqiw8LxkGBnfvkkqzEckgt+AOCh2bVgOE8yBgKZ1pfQVPqiaYLBLIEOdOtKmJLdTSdNhy6AX9UQNnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r5kCsxaNdGwiJYOFRwcDQNYcu5R10g6ShbMt26Se3/wyQKw5/naOgdPmIn1QemquZlfj4s4jfCYXfILJSlvfUYRXnz/ni3vZ6chbiYKCMbgO+heHKB7oVgt/fNWxRDHglaKTv1QH3p8p8WXA4iW69RuylNPo/lZXLy/r4YF5HcQ=
Received: by 10.115.76.1 with SMTP id d1mr3407574wal.1185228784645;
        Mon, 23 Jul 2007 15:13:04 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 23 Jul 2007 15:13:04 -0700 (PDT)
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53491>

On 7/23/07, Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> Hi,
> the initial reason for this patches is that here on my system qgit4 looks like this
> http://img77.imageshack.us/my.php?image=qgit4strangewindowgi0.png

Hi Peter,

OMG that's horrific! I can't understand how it is possible, on my box
(Mandriva with QT4.3) everything is fine.

Anyway thanks a lot for the patches. Already applied and pushed.

 > If anyone wants me to remove that too, i would be happy to send more patches

Please feel free to send me any patch that could improve the GUI,
unfortunately on my box I'm unable to see all these defects, so any
patch from you is more then welcome.

>
> If you want i can provide more screenshots of how patches change appearance.
>

Patchview has not changed for me with your patches, fileview yes, I
can see the difference and also customaction. I would say nice job!
thanks.

 Marco
