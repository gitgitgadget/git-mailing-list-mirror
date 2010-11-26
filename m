From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: using git with Google Code
Date: Fri, 26 Nov 2010 23:12:38 +0800
Message-ID: <AANLkTi=0Hg=Ohd6SE5OX_OmAqyKDMP+iamSq94n_3R7a@mail.gmail.com>
References: <AANLkTiksVbmUX9QE6B385UjboqcvgAo+mwKP_X--P+83@mail.gmail.com>
	<20101125150357.GB16049@burratino>
	<AANLkTi=7_U3yTYHNFZD6Lfwxe77xyD1kS29egLEwAEeB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Bond <jamesbond.2k.g@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLzyh-0004k9-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab0KZPMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:12:40 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47144 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0KZPMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 10:12:39 -0500
Received: by eye27 with SMTP id 27so995621eye.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5ULyreoZh8Zbq5EnVa1cHSuhGWINbLLAHsVfubnzA9U=;
        b=AD5hpGw34AX3dF9GxkT/vuWdbTwByhHhSkoO4lz/gP478Yuv1rdimahz/aUqy3dnze
         GVq+JrxmprviWr0SdXUEj5mWJ910ehmf1wpTrEWhAwhgG0hVAjw9VARNhsg8BKUkKtgX
         Dt0sI4YcehcIrI9qr37oGiY7s4Nya92jyRdIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TJorr7+IAg9XXYAgJOfDXYu2op2uDvWkRcFDVjoq98yGohbUH5127DtgAOqgWdiUq5
         u8bLK/4uobtq9KHXmOU5CHDzAvgi34opT7gQUn2bdcguQ9kC0hmA+TpKx9cFRuW2EFtf
         PPHpeTh+jCJmBWpH+vn0taDEkVVs6DYIBsDXE=
Received: by 10.213.105.76 with SMTP id s12mr4023167ebo.2.1290784358493; Fri,
 26 Nov 2010 07:12:38 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Fri, 26 Nov 2010 07:12:38 -0800 (PST)
In-Reply-To: <AANLkTi=7_U3yTYHNFZD6Lfwxe77xyD1kS29egLEwAEeB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162213>

On Fri, Nov 26, 2010 at 6:55 PM, Bond <jamesbond.2k.g@gmail.com> wrote:
> I do not remember if it was installed or not.After reading your
> message I did an apt-get to git-svn I am using Ubuntu 10.04 =A064 bit=
=2E
> On my project there is no single file right now.

So you've installed git-svn already? Try

  git svn -h

Anything?

--=20
Cheers,
Ray Chuan
