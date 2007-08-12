From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sat, 11 Aug 2007 20:16:20 -0400
Message-ID: <fcaeb9bf0708111716y29d6a719r995304b96c1b3eb2@mail.gmail.com>
References: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de>
	 <fcaeb9bf0708111710m1eca7a82t71d471e40e84ef93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 02:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK18H-0005t3-LJ
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 02:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbXHLAQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 20:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbXHLAQW
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 20:16:22 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:34975 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHLAQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 20:16:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so221913and
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 17:16:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSV04MlsIUH/Blvy0R8FyaM5cfsETfMUyW4L6GfySjctEHuott5bx/xoeFfBBpuja6DkOxqIqI1bFZsXq4ImfFaE4vffDEJGuzmqu45EIqNLNDTGfgNpHQhQLnaE6IV8kViJ6tlR3DBzFrTV6PqUjI5vlyRngwibVw6Tg7TikJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V3xE6PD3WsQqluTtxaroIlYebp+ojOCEepN1SWAgLFDpZDRrns4eAT2Dnwdq/zmfBq0S3SdFS8ASCK2Z32687dUTXReLUBqWS3k786+lgtP7u/G6j7/cs4dbOH9ZjqrvyhtmPuLay/zrnLbsb2hmBPotVrEnzt1eOiX3Pi8JJfA=
Received: by 10.100.126.2 with SMTP id y2mr664207anc.1186877780364;
        Sat, 11 Aug 2007 17:16:20 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Sat, 11 Aug 2007 17:16:20 -0700 (PDT)
In-Reply-To: <fcaeb9bf0708111710m1eca7a82t71d471e40e84ef93@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55653>

On 8/11/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> This reminds me a patch I made before:
>
> http://thread.gmane.org/gmane.comp.version-control.git/49217/focus=49575

And the second patch:

http://article.gmane.org/gmane.comp.version-control.git/49216

> With a little modification you can use ShellExecute to open html if
> there is no suitable program to open it. The last commit on
> mingw.git's mob branch does that (not based on my mentioned patch
> though).
-- 
Duy
