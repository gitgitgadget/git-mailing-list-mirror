From: Kevin <ikke@ikke.info>
Subject: Re: rebase -i does not use a commit it should
Date: Tue, 3 Jan 2012 15:04:48 +0100
Message-ID: <CAO54GHAwgbdpdqZw5Pc+jvEyq12DAq4Bio_MbTnmXHsvm-5p8Q@mail.gmail.com>
References: <CAO54GHB1uwJdjj0=dCVp_M4sAFtqooM9hnBSNurje2n+-dGDEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 15:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri4zP-0000cu-5p
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 15:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab2ACOFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 09:05:12 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57879 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2ACOFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 09:05:10 -0500
Received: by werm1 with SMTP id m1so7878603wer.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=+guEh/FO3UQsD4Wq1R4dOjL7QT5DC7+wpQy33qh5ZxM=;
        b=SLjXCZWWrZSB7G54eQuhr4YoNth/0cW7W+77uDGpZyZg2bCmSy9SNgOxWclSD292WK
         MvPxwmh+RPO4WM3U4IZYqgHsvSyGQoVMvAWljXfPt5BRl6eUqOFBNTLfG6RMXINHRwEY
         lX2noexs+qtEAUUrHr3gi91SwLf91xPWwTJQo=
Received: by 10.216.132.231 with SMTP id o81mr35006102wei.3.1325599509260;
 Tue, 03 Jan 2012 06:05:09 -0800 (PST)
Received: by 10.227.57.84 with HTTP; Tue, 3 Jan 2012 06:04:48 -0800 (PST)
In-Reply-To: <CAO54GHB1uwJdjj0=dCVp_M4sAFtqooM9hnBSNurje2n+-dGDEA@mail.gmail.com>
X-Google-Sender-Auth: 4vgY-WlGVJw3lqEKcll8BnV-QvM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187864>

Using git version 1.7.8
