From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 01:35:05 +0530
Message-ID: <CALkWK0kQY_ZO7Q37Q0ihi+c6G70zRvOxFi-zkBPrTtUNOafedA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie> <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgMjV-00049u-9S
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 22:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab1GKUF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 16:05:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55063 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1GKUF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 16:05:27 -0400
Received: by wwe5 with SMTP id 5so4260366wwe.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MYiYXeU4OntMLq7OInDd1GPwEAcUqEHwLiprG7NNLWg=;
        b=YGH4nxxs+BWOCHbXD04E/wztinJgiPCdCGnKwZN4WDpKGw4hHTDsaASjVfCdo8gchv
         wmZtJjxjTv0nhWYn+uOLJAzl77zhUj5sGiRrlMzGSPZ8fe08TSDst+tsmIYgUUI+CZiS
         uwnrLzFqGFsllxQFTX/b4v9uYljmtkkveGW6M=
Received: by 10.216.62.3 with SMTP id x3mr3335512wec.77.1310414726133; Mon, 11
 Jul 2011 13:05:26 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 13:05:05 -0700 (PDT)
In-Reply-To: <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176887>

Hi again,

Ramkumar Ramachandra writes:
> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:
>>> I'm excited to announce the first iteration of a fresh series
>> =C2=A0- has the result of applying each patch in the new iteration b=
een
>> =C2=A0 tested (for example by rebasing interactively with "exec make=
 test"
>> =C2=A0 after each "pick" line)?
>
> Tests are still running. =C2=A0I'll let you know the results in the m=
orning.

Quick update: Yes! All of them pass all tests :)

-- Ram
