From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation 
	section
Date: Thu, 8 Apr 2010 22:21:44 +0200
Message-ID: <r2ifabb9a1e1004081321ia91ad7f7r58f39b9173594af1@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org> 
	<h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com> 
	<7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 22:22:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzyFS-0006f3-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 22:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290Ab0DHUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 16:22:15 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:55482 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045Ab0DHUWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 16:22:13 -0400
X-Greylist: delayed 104181 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2010 16:22:13 EDT
Received: by yxe1 with SMTP id 1so1004692yxe.33
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=FxIKRooYqlU53vIcxhErTK8Q1Wd8xheZEccFIH0ReJE=;
        b=afUtqPfcJNO7XyG4i+lCW3tJc3uq4bgp3pHcmQ608DgkXPKGEFH+4Io16jFbWR6KEN
         it8w8JptzHEodlCPYsjocb3eeUOUm0Jav1WciDWwBc3epZI4EkNctmr0Wflo5/mOtdcI
         I89pfiuPJFzXdYXSPPprkW/W60Yds/7modm0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x4msTjjSM1PBPR6JZZ6VwsrQ7mk7eMYv1oP/ORKFLheBlVocYNPXKmjy2osKt/ix0u
         aWFNXnL43Kw+0UA7NGSIIksK16CUbmJynPCwZ98MjRKmWGxkxgq1LfYwQDEcFtpv1sX1
         ukl1903crdL/GKvAHwHCtkzPGIEs/atoKyR5g=
Received: by 10.100.206.13 with HTTP; Thu, 8 Apr 2010 13:21:44 -0700 (PDT)
In-Reply-To: <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Received: by 10.101.21.9 with SMTP id y9mr1111255ani.71.1270758130615; Thu, 08 
	Apr 2010 13:22:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144379>

Heya,

On Thu, Apr 8, 2010 at 22:01, Junio C Hamano <gitster@pobox.com> wrote:
> Ok, here is a rough draft.

I like it, but...

> -Note that your maintainer does not necessarily read everything
> -on the git mailing list.

> -Also note that your maintainer does not actively involve himself in
> -maintaining what are in contrib/ hierarchy.

... I'm curious as to why you removed these two statements.

-- 
Cheers,

Sverre Rabbelier
