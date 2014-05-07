From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: material for git training sessions/presentations
Date: Wed, 07 May 2014 20:32:13 +0530
Message-ID: <536A4AF5.7050907@gmail.com>
References: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 17:02:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3MV-00044O-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 17:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbaEGPCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 11:02:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:65053 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbaEGPCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 11:02:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so1282573pad.20
        for <git@vger.kernel.org>; Wed, 07 May 2014 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Fw/1xq7Sfb+Ak4U0kTQvIOvgqQjsIEKm2iSzPJR+0UM=;
        b=NJVKgm7Vr1QLYJpGFljuIgxV43p7KdnFXxBzT3SODfjjgksVXs4kUXn6nBnet75acs
         WGACfnvaypWgJ1I+OzhufL61NfPifE71OSiJqyS2h6MqxhtJbjcuWYCy/J0rc6wIuEmD
         +HerZZ80qE3c49sguqrD8MaFupGk7ot/QJXBN+O/d4zwob2HGpkrRFRupcg+m/fuJ4AV
         b7YLrozPxKQUylLkKQqhOIY67lyxgU87WhLVARmHMbrT8icJjePX98JNNqORh7O+JXSU
         Gu/bfENbroDIXkj9RJKCOKklv/aqdFkbpyuauFw/Ym2yxwqcmRLcm/W30HIJJ5ubFL2M
         hX8w==
X-Received: by 10.66.122.101 with SMTP id lr5mr20015346pab.130.1399474938190;
        Wed, 07 May 2014 08:02:18 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.211.204])
        by mx.google.com with ESMTPSA id su8sm3671839pbc.72.2014.05.07.08.02.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 08:02:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248327>

On 05/05/2014 09:48 AM, Chris Packham wrote:
> Hi,
>
> I know there are a few people on this list that do git training in
> various forms. At $dayjob I've been asked to run a few training
> sessions in house. The initial audience is SW developers so they are
> fairly clued up on VCS concepts and most have some experience
> (although some not positive) with git. Eventually this may also
> include some QA folks who are writing/maintaining test suites who
> might be less clued up on VCSes in general.
>
> I know if I googled for git tutorials I'll find a bunch and I can
> probably write a few myself but does anyone have any advice from
> training sessions they've run about how best to present the subject
> matter. Particularly to a fairly savy audience who may have developed
> some bad habits. My plan was to try and have a few PCs/laptops handy
> and try to make it a little interactive.
>
> Also if anyone has any presentations I could use under a CC-BY-SA (or
> other liberal license) as a basis for any material I produce that
> would save me starting from scratch.

I've written and used the following; the first one is a bit more popular
(or at least has been mentioned several times on #git)

1. git concepts simplified: http://gitolite.com/gcs.html
2. a presentation on git: http://gitolite.com/git.html

You can use them straight off the web.
