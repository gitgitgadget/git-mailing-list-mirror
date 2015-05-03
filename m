From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [Patch] Added http-protocol for git in the Documentation folder
Date: Sun, 3 May 2015 13:15:31 -0400
Message-ID: <CAPig+cTVMhSwQ_z15GLCn6AmAsm6Pv0RJuGxpVg2CnX8whp8Yw@mail.gmail.com>
References: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
	<CAPig+cSJWdrS-bBXcHE5ZmpZ3Aj8tKehXgFan6=4qxzrNKG8zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:15:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxUR-0000wb-I5
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbbECRPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:15:33 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32803 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbECRPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:15:32 -0400
Received: by igbpi8 with SMTP id pi8so53983802igb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I6XdaKPHCttyBqlNXE6rI6MhHPxO43l3M1cI3hVlGXU=;
        b=DsRS8e7yLy8XoeHerqBD0Nsg4kXa6j7maAoklBWFQ1k35LRIXOWvNng7hPayVCwyht
         dbgmVTjJ8jnQhN69eqQQoVRVSd57aNtSmFiwJ2Q13A8uBGb7ptG3Bgwg4lIxPpHXQ/Ax
         vKGL203kV1lNdxgc0oalSwJPw90MmYKnxjTZyIJ39kZAZMBe3omdFJehFrlF/giK1nSX
         yr8RRsxMjkkXtG5Ife1NEAGNf2u4FlMXmtOb0u8gTwJwc2QIlaZISkKQ5EFujdASS659
         NB0EnP2ApRrxS7c/c7NQGpsXh3mEBOLrJnMEM34wtLbXLYu0KlrIo+o4mWTcEtbhjgQF
         VLNg==
X-Received: by 10.50.66.230 with SMTP id i6mr8947746igt.22.1430673331241; Sun,
 03 May 2015 10:15:31 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 10:15:31 -0700 (PDT)
In-Reply-To: <CAPig+cSJWdrS-bBXcHE5ZmpZ3Aj8tKehXgFan6=4qxzrNKG8zA@mail.gmail.com>
X-Google-Sender-Auth: pbfALuBlqvynK-e1NNtViHa6Apc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268273>

On Sun, May 3, 2015 at 1:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 3, 2015 at 12:18 PM, Alangi Derick <alangiderick@gmail.com> wrote:
>> This patch is to include the http-protocol in the documentations
>> folder as stated by the left over projects here:
>> http://git-blame.blogspot.de/p/leftover-bits.html.
>> I got the documentation uploaded by Scott in his drop box some years ago.
>> https://www.dropbox.com/s/pwawp8kmwgyc3w2/http-protocol.txt
>
> This document was imported into the project by 4c6fffe (Document the
> HTTP transport protocols, 2013-08-21) at
> Documentation/technical/http-protocol.txt and has already seen several
> changes since then.

By the way, the entry in Junio's "Leftover Bits" isn't about importing
http-protocol.txt, but rather about fleshing out all the TODO items
which are still present in the document.
