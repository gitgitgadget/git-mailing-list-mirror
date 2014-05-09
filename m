From: David Lang <david@lang.hm>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Thu, 8 May 2014 17:40:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405081739310.17457@nftneq.ynat.uz>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com> <20140505184546.GB23935@serenity.lan> <xmqqoazb944d.fsf@gitster.dls.corp.google.com> <536B3259.1050602@gmail.com> <536b38b55b7fc_4fa68b32eca@nysa.notmuch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 02:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiYrt-0007H3-QE
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 02:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbaEIAkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 20:40:41 -0400
Received: from mail.lang.hm ([64.81.33.126]:60151 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623AbaEIAkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 20:40:40 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s490eRLq007659;
	Thu, 8 May 2014 17:40:27 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <536b38b55b7fc_4fa68b32eca@nysa.notmuch>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248466>

On Thu, 8 May 2014, Felipe Contreras wrote:

> Chris Packham wrote:
>> On 06/05/14 11:50, Junio C Hamano wrote:
>>> The same argument would apply to git-svn, git-p4, and git-cvsimport,
>>> I would think.
>>
>> A bit of a crazy suggestion and a little off-topic. Assuming maintainers
>> can be found what about having these foreign vcs interfaces as
>> submodules. That way they can be in Junio's tree as well as having their
>> own release cycles. The same could apply to git-gui, gitk and gitweb. It
>> would also be a chance to eat-our-own-dogfood with submodules.
>
> If submodules were an integral part of Git that would be a possibility,
> but they are more like a hack.

Well, if git.git can't use them, then how can anyone else be expected to.

I haven't been paying close attention for a while, what would have to be done to 
make submodules "an integral part of Git"?

David Lang
