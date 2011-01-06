From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: patch for git-p4
Date: Wed, 5 Jan 2011 16:46:49 -0800
Message-ID: <AANLkTikK+q=0STdWOS8W0HKkMniZVg3ey-S5ThEyh50j@mail.gmail.com>
References: <AANLkTi=sNsDy9oo0iBE-qJwvFSDMFYma3oYhbP1J-th=@mail.gmail.com>
 <AANLkTimdMH_HcF-Qk3SSmqT24OgxynYnXpSLiDtU7Y6c@mail.gmail.com> <7vfwt7c56w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 01:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pae15-0001TR-MN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 01:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab1AFArN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 19:47:13 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41798 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab1AFArM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 19:47:12 -0500
Received: by ewy5 with SMTP id 5so7149333ewy.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 16:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=BzOqi+N/vo3Tm7lW99VLxE/yt+apwC2B1k1xNoiF2iw=;
        b=v2IS6m2BbiO8ye/yd3Yng2Q0heqKv995tgXf5q7VFTP0jVmma1QGBhn2Gi7TKsbxwW
         +C8t0MvVJw7YSmCtkYr6YytcKJcGPM/ku5ZhlLLqSS5lYy7epuDbM5GjWhoy8E5WauON
         Ebm72SHoZI82bOv/1/JWClbMKcXaEUCNvAIFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=aX5oCJvAXIvOHLrvwg4l+y8K7YoCtMMUHgGjXC50M36aWnU6Gj2xIKIo6Bgk9uVTXe
         BMNpJX2J8IA/7BSQuLnW6RDLc43Y4azjZ8/vM33PVT3tlcsaa2mXidxM95iTNs7RKfcT
         zIhSWKbB1yyIKT44XI6Xp/PaJBZANngX6kq/4=
Received: by 10.213.20.4 with SMTP id d4mr88599ebb.55.1294274830031; Wed, 05
 Jan 2011 16:47:10 -0800 (PST)
Received: by 10.213.98.83 with HTTP; Wed, 5 Jan 2011 16:46:49 -0800 (PST)
In-Reply-To: <7vfwt7c56w.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: OJSN0DdXp9Iodh9DRb1gP1zhouc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164615>

I'll fix up the patch and resubmit it properly this weekend. Thanks!
