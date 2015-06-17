From: "Andres G. Aragoneses" <knocte@gmail.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 13:56:43 +0200
Message-ID: <mlrn9r$9ho$1@ger.gmane.org>
References: <558127CB.70603@web.de>	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org> <vpqoaketusa.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 13:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ByT-0000EV-VS
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 13:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbFQL5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 07:57:42 -0400
Received: from plane.gmane.org ([80.91.229.3]:33136 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbbFQL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 07:57:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z5Bxt-00086j-MB
	for git@vger.kernel.org; Wed, 17 Jun 2015 13:57:09 +0200
Received: from 46.24.152.62 ([46.24.152.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:57:04 +0200
Received: from knocte by 46.24.152.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:57:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.24.152.62
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqoaketusa.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271835>

On 17/06/15 13:54, Matthieu Moy wrote:
> "Andres G. Aragoneses" <knocte@gmail.com> writes:
>
>> On 17/06/15 12:54, Matthieu Moy wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> On Wed, Jun 17, 2015 at 2:54 PM, Torsten B=F6gershausen <tboegi@we=
b.de> wrote:
>>>>> -git-checkout - Checkout a branch or paths to the working tree
>>>>> +git-checkout - Switch branches or restore changes
>>>>
>>>> I didn't follow closely the previous discussion.
>>>
>>> (Neither did I)
>>>
>>>> Forgive me if this is already discussed, but I would keep the "in =
the
>>>> working tree". "Restore changes" alone seems vague.
>>>
>>> "Restore previous version" would be better than "Restore changes" t=
o me.
>>
>> "previous version" sounds ambiguous.
>
> Yes, but "git checkout" can do many things. It can restore an old
> commited state, restore from the index, ... so we need to either be
> vague, or use a long enumeration.
>
>> How about "discard local changes"?
>
> To me this describes "git checkout HEAD", but neither "git checkout -=
-
> file" nor "git checkout HEAD^^^".
>

I didn't mean to use just "discard local changes". I was proposing that=
=20
as a replacement to the "restore changes" substring.
