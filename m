From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Absolute Beginner
Date: Tue, 23 Nov 2010 16:03:07 +0000
Message-ID: <AANLkTim8G+Gi5ibhLnpE0XjgsNJPP_+eR0awrOpwF2D4@mail.gmail.com>
References: <1290516065002-5766449.post@n2.nabble.com>
	<AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
	<1290525868767-5766781.post@n2.nabble.com>
	<20101123155436.GA10420@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marcos <marcos@arena.com.br>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Nov 23 17:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvKu-0006bi-OS
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 17:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab0KWQDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 11:03:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51177 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab0KWQDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 11:03:08 -0500
Received: by yxs7 with SMTP id 7so1802yxs.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=IY68eVm61K0iw3PSSjk/zU9vrOS3KKGMa1shKhVqLVQ=;
        b=bE+BGp7SysrTtqMVnIkzozvps5D6bWRjk6hlKbzQ245SvKUVr32gFUoqxuE+pR61ih
         oqyNO811h5Qmc2Yyal5Yph5WPSCo8cI222ZT8DXxZ8u8gpMLVRPwgCB6XPofiXNLSppK
         VK7V8iv56hBZuGv4s4nut7WM4+r3N6uAZGK00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=xbrlT2iwHxIlLsx+xRhAw4IZkhMDMtKvQd3oZWcNoRwVo87HGZlqAeSZTA+qr1iOY2
         7S7tUsXoCPGj9WOGoyW0j9NW68oFJjyd9Pap3Cpi51zKwPHNnnHJ/L6yIgUGfXVYnySx
         OeMBiUMJR+ElaUYUgpCSj9NYT1iTTrdsAUUKw=
Received: by 10.151.49.1 with SMTP id b1mr11756729ybk.418.1290528187142; Tue,
 23 Nov 2010 08:03:07 -0800 (PST)
Received: by 10.150.202.3 with HTTP; Tue, 23 Nov 2010 08:03:07 -0800 (PST)
In-Reply-To: <20101123155436.GA10420@LK-Perkele-V2.elisa-laajakaista.fi>
X-Google-Sender-Auth: l8OsGMmbotcjqsE3ZUuTmH59KHI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161977>

On 23 November 2010 15:54, Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Nov 23, 2010 at 07:24:28AM -0800, marcos wrote:
>>
>> Then I received a reply from Howard Miller:
>>
>> (...)
>> You are trying to push to a repo that isn't bare. Not impossible but
>> problematic and you can't do it at all by default (as you have found).
>>
>> Personally I would look at a central shared repo. You could just get an
>> account on (something like) GitHub or setup your own (something like
>> Gitosis).
>> (...)
>
> Don't use Gitosis, it is obsolete. Use Gitolite instead.
>
> -Ilari

Another job on the TODO list: "migrate Gitosis to Gitolite". Sigh!! :)
