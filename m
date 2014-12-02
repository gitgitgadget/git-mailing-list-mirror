From: Kevin <ikke@ikke.info>
Subject: Re: Git Bash for Mac
Date: Tue, 2 Dec 2014 19:08:25 +0100
Message-ID: <CAO54GHD-hSS5mSbNwz7BGLY3zxpJa6Ljay1jy4u5nXcg-8Do5g@mail.gmail.com>
References: <F6CF2816-4FB8-4B6D-B00F-FECB67D43409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nizamuddin Chowdhury <mchowdhury57@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 19:08:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrsZ-0004jT-OF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 19:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbaLBSIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 13:08:47 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49783 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbaLBSIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 13:08:46 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so17744504wgh.3
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 10:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=n80KfV1Mb7PFQ+06UJ3bgD8HTrBdSf+25xa3XmDUm0A=;
        b=Jxqv69Hz7XcmuhfCOaQ2gT/b06aMbUgtSoP6i127ySkjZu69QBrN78QIpy3DWTDqXb
         +tgJHhTTMuL/iDkooqej7KzkIcZIvM2CMawzvfL97Uy/UkkpdzduKqJ3H0z9/A1wXIXj
         7j8zoZ2OtQOio9KxDR9nqkVVXPx0zGt44jrJGOIF+a89/fiVvQ3QZkhhIMC6F+JyHT1o
         FRo1EyBP2jgbxAmHfO9ylcQk7SwNRUNN7ddih6KtoDHWWW5S74JRithWKr/Ed65HXauR
         aRftLUW7SVd3DU+KEqDOLuZx0lA2tBeyLsvXaJ9IfF/9860xrD+kyP4KE051cVyvV6zA
         50RA==
X-Received: by 10.180.81.7 with SMTP id v7mr7197935wix.74.1417543725760; Tue,
 02 Dec 2014 10:08:45 -0800 (PST)
Received: by 10.194.37.132 with HTTP; Tue, 2 Dec 2014 10:08:25 -0800 (PST)
In-Reply-To: <F6CF2816-4FB8-4B6D-B00F-FECB67D43409@gmail.com>
X-Google-Sender-Auth: _aPDnsOrcqEzToCVRQmlZmdVm7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260588>

On Tue, Dec 2, 2014 at 1:21 PM, Nizamuddin Chowdhury
<mchowdhury57@gmail.com> wrote:
> Good Morning,
>
> My name is Sefath, and I was wondering when i could start using Git f=
or Mac. I=E2=80=99m completely new to coding, and I wanted to start wit=
h HTML. However, when I tried installing git bash on my mac, it doesn=E2=
=80=99t work. Maybe it isn=E2=80=99t compatible with OS X Yosmite? I wo=
uld really love to start learning code, and it sucks that I can=E2=80=99=
t because of a reason like this.
>

git bash is a windows port for git, so that's not suitable for OSX.

You'll need to have a Mac build of git, which you can find here:
http://git-scm.com/download/mac
