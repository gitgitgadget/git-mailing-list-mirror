From: "Andres G. Aragoneses" <knocte@gmail.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 13:47:09 +0200
Message-ID: <mlrmnt$te5$1@ger.gmane.org>
References: <558127CB.70603@web.de>	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com> <vpq8ubiwqo9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 13:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Bop-00088e-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 13:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbbFQLri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 07:47:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:60456 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbbFQLrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 07:47:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z5BoV-0007vO-LG
	for git@vger.kernel.org; Wed, 17 Jun 2015 13:47:28 +0200
Received: from 46.24.152.62 ([46.24.152.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:47:27 +0200
Received: from knocte by 46.24.152.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:47:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.24.152.62
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq8ubiwqo9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271832>

On 17/06/15 12:54, Matthieu Moy wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jun 17, 2015 at 2:54 PM, Torsten B=F6gershausen <tboegi@web.=
de> wrote:
>>> -git-checkout - Checkout a branch or paths to the working tree
>>> +git-checkout - Switch branches or restore changes
>>
>> I didn't follow closely the previous discussion.
>
> (Neither did I)
>
>> Forgive me if this is already discussed, but I would keep the "in th=
e
>> working tree". "Restore changes" alone seems vague.
>
> "Restore previous version" would be better than "Restore changes" to =
me.

"previous version" sounds ambiguous. How about "discard local changes"?
