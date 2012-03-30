From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 15:54:52 +0530
Message-ID: <CAH-tXsBM1Nh5ZXGs=jp8oCERKQEuAkfMG_=afLw77ACTDmnSbg@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
 <20120330052631.GB11648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 12:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDZ1b-0002zO-8g
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 12:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933809Ab2C3KZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 06:25:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60369 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760157Ab2C3KZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 06:25:35 -0400
Received: by wgbdr13 with SMTP id dr13so457589wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yfJfH75Hd2Lq5N/xUbR1Hyf/c5xh5RFJLIKDRzkudXc=;
        b=sn+P4tWUdPkMmyc/D/Ny+gghyrB94I5gcU5eAykPHJsqKDg4MJLFPF7HrRQE4idAD2
         iuTcWaXBOqbd23G/NYG7ftEUS5jgZYCVg1nlitRHOAuz6dmc5tH1VGFFebjW+i0XCfHY
         n7CPk8IagDZp0Cf+WErsqo3BgYYhJqRzTKYUfFJbdPm6Vng0t3MgYKEyvitQ3lPisFVE
         xg6Hr2aIPjiZ8RrxbOYhwJzjq2cYq5FH6m8SbiJIynuCpdwtAAa/77hRDEdGruoTJulH
         GqNX98rxSdYgVV/cnKUrTXIHjWeKtqV/SZlwuLzDRQHQyuzXcoczv40Y6CruUHv0t6F/
         LNLQ==
Received: by 10.180.102.100 with SMTP id fn4mr5122276wib.1.1333103132709; Fri,
 30 Mar 2012 03:25:32 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Fri, 30 Mar 2012 03:24:52 -0700 (PDT)
In-Reply-To: <20120330052631.GB11648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194344>

>> Is JavaScript code unit tested? I cant find much docs regarding
>> this anywhere.
>
> Jakub can answer this much better than I can, but I suspect the answer
> is "no". We hardly have any javascript at all, and I doubt the gitweb
> tests cover the javascript bits.
>
> If there is going to be a javascript-heavy SoC project, I think part of
> that should probably be adding some automated testing infrastructure.

AFAIK now, the gsoc project will be almost JavaScript only and some
Perl. Since this is the main thing I am planning do, I would love to
do it in a good manner.

The current contributors are mainly,
    John 'Warthog9' Hawley <warthog9@**.net>
    Jakub Narebski <jnareb@**.com>
    Petr Baudis <pasky@**.cz>

I would love to get some advice regarding this from them.

-- 
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
