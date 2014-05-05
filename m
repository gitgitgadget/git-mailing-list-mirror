From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [msysGit] Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Mon, 05 May 2014 17:03:27 +0200
Message-ID: <5367A83F.5010606@virtuell-zuhause.de>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com> <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com> <CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com> <alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info> <CAHGBnuPrQzSAVRZCneHdodAAQjA4dkGk0AguNm3xhW+cQ4XESQ@mail.gmail.com> <CABPQNSb83H7EEeAfaxC7KVpZmv-KEqE1wavTf53kA=aoDQz4Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	tuomas.silvola@knowit.fi, msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com, Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:49:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi3B-0006KZ-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933107AbaEEPDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 11:03:35 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:48901 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933028AbaEEPDe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 11:03:34 -0400
Received: from p5ddc0621.dip0.t-ipconnect.de ([93.220.6.33] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WhKQU-0005hR-2L; Mon, 05 May 2014 17:03:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CABPQNSb83H7EEeAfaxC7KVpZmv-KEqE1wavTf53kA=aoDQz4Tw@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1399302213;a9d8539b;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248153>

Am 05.05.2014 12:53, schrieb Erik Faye-Lund:
> On Wed, Apr 30, 2014 at 9:46 PM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> On Wed, Apr 30, 2014 at 6:52 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>>>> We can keep this patch in the msysGit repo for the 2.0 release.
>>>
>>> FWIW the plan is to switch to mingwGitDevEnv for the 2.0 release. It is
>>> not quite clear as of yet how patches will be managed with said
>>> environment.
>>
>> The environment is just that: The environment to build Git for
>> Windows. This means that patches on top of Git for Windows could still
>> be maintained in msysgit/git (or a fork thereof) on GitHub.
> 
> Thanks for the heads up. Even so, are you guys OK with me pushing this
> patch to our downstream repo?

Yes!
