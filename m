From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Off-topic Thunderbird wrapping (was Re: GIT cloning(or pull/push)
 doesn't work properly if you have a sub-folder as its own GIT repo)
Date: Sun, 24 Apr 2011 13:54:33 +0200
Message-ID: <BANLkTim0TDf0+evU+zBf8fe0at7QQb5W0A@mail.gmail.com>
References: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com>
	<4DB3D863.4080500@gmail.com>
	<4DB408C6.3080400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 13:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDxtg-0004uM-UE
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 13:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab1DXLyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 07:54:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50824 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab1DXLye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 07:54:34 -0400
Received: by qwk3 with SMTP id 3so701034qwk.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=EmTz5oWump3BWEpQiDdpwXR9pOVgR9vuKS61u0bq8wk=;
        b=if9sTalvk1Prw1TzF5OJoy4RBwFka/bdY+7Unkk2siAIQB1aTxRVbHYh8WiinlSWOm
         5dljqWsaQqXwy8PsZTamCc7zCDjl6Xun51J/Q1cUhhLOvae5/RH3+6wp14XsLnDrE1Yb
         YUTBy7XuGPMsarA6v/QrXEkJLK/iKpEOb2/eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=acNeqSfAyOSzgkVsGhecmdsoLKLWpiRRU1G/5mzZhb/lDnjyHl7Vv9r1dr8Jrv3LlT
         O+PHE/4UjXuTtFDg36wP0EVDs790THLSAHVPDMq9A1Cfgzn+ZKorUILZKBUzlhgmbIOP
         rBpmBgfbb66N7bWwZ/FEhMQlPhpTCzYhuh/Hg=
Received: by 10.229.253.8 with SMTP id my8mr2056456qcb.236.1303646073713; Sun,
 24 Apr 2011 04:54:33 -0700 (PDT)
Received: by 10.229.81.71 with HTTP; Sun, 24 Apr 2011 04:54:33 -0700 (PDT)
In-Reply-To: <4DB408C6.3080400@gmail.com>
X-Google-Sender-Auth: S0X8Has7YnwOJXdQeea0RqcdWy8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171993>

On Sun, Apr 24, 2011 at 13:25, Chris Packham <judge.packham@gmail.com> wrote:

> So this is the 2nd response I've sent recently that Thunderbird didn't wrap
> correctly (yet it looks fine in the composer). Can anybody tell me (or point
> me at a webpage) how to set it up to post to mailing lists nicely?

See SubmittingPatches in the Git Documentation/ subdirectory (comes
with the distro).
I used that to fix my own Thunderbird setup.

-Tor
