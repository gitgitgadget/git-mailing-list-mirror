From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Tue, 18 Aug 2015 17:44:31 +0200
Organization: gmx
Message-ID: <053a445c5b44e4c92dccba4dd5de26b9@www.dscho.org>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
 <55C66AF2.3060706@gmail.com>
 <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
 <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
 <058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
 <55C7883C.7040504@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 17:44:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRj4D-0004Sv-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 17:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbbHRPop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 11:44:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:64765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbbHRPop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 11:44:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MKYLf-1ZS0JS1TVP-0020RD; Tue, 18 Aug 2015 17:44:33
 +0200
In-Reply-To: <55C7883C.7040504@dinwoodie.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:t126cTT0eAk/vyxG7AHTrNvQ4Wi/qWq6bnoxNh6pcKpyUalvGUq
 PjEIUJTW2do3nsJU6kAWZhigSC8WyqQBT3a5cNiUfUPGV3ZndDX2scHLGi4FPp0DF46c4kd
 PTFBj2BnYT7EfwWOFoO9XoHSjc1S6QV8gzX9zlAuxlqkYCD1sv9QAX9dO26vU5iQOXxG+Z8
 oDdZAZw0nmzZtd1i1P+lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZytJr+EA85I=:bL/Jb7dqN1VS3Hi7lZSa6Q
 c7WIIZWHAgpKHMpTTBqup/y992R6DN+0bYY5+crLBjmGQnpdDxSmg6oQZZNru0SCVKAJW8k7C
 SKQKe/zCB9U7UVtITEIrLpu0xVcSZEYuc7HyOb1+1Yszw6TDGrccIODET8Ex7gTvkHGuI0+Q7
 TPrL2mnTjY2EcKjW7ixJozv/3jb3ZYrjIqC9TVQPNl2hpjD4/N8qpbSYHTljjXiEbkzgKlMVs
 uzfSEbDnx7w72yLqP6rTN66nqwNSEK7YrtniZQbJLhRDl2CZ9/WM+kpdiAy8yKc9ZVrPCypAn
 W9vHeeq3F40l/4q4Ab9to7GEQZ6F8afaFX28+d6oWTJOtm7MBhyiTpjIvEkBqo7CU1esPvbeV
 gWHPIbxV2jIZr6nbm5p7oRWHUI69AL7vWTt1wsSP5nG3T2fvj2+TtTmjQtswK6+BVBa7Q5RiL
 nk/0v81a2+9hUf7F8Pjt3pzQE+1MsPjsP0/dAg0djKo86RlCQSCkkGba7KUG+d1hdr29LY1VO
 ccnvENNVhPme38G8v6uJDuDVUXM5qX2e3UMzIqZsamynGts+piFU6AnlapdPo/P3XO/kZrarR
 ofNPt3JM7ghlPsrpRonBXYCPciAqEGgv6RrW3Pw3Gp4ah9Gi05dO5OzQL1eIimaOjMBldmuq5
 t6bXrZ38h2+1wDATeIY1SFA9U+o/HwLluegiMxKXJCUQ3W+R6OR6AzrDvV7VKv4zQpBs0EkXQ
 8aHzFwAtvW6FheOzKTrMRAwJqJTS4ZFuEfEuzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276127>

Hi Adam,

On 2015-08-09 19:05, Adam Dinwoodie wrote:
> On 09/08/2015 10:01, Johannes Schindelin wrote:
>> On 2015-08-09 04:01, Adam Dinwoodie wrote:
>>> 
>>>> We've gotten a lot of users on the list who ask why their Git
>>>> directories on shared drives aren't working (or are broken in some way).
>>>> Since I don't use Windows, let me ask: does the Cygwin DLL handle
>>>> link(2) properly on shared drives, and if not, would this patch help it
>>>> do so?  I can imagine that perhaps SMB doesn't support the necessary
>>>> operations to make a POSIX link(2) work properly.
>>>
>>> I'd need to go back to the Cygwin list to get a definite answer, but as
>>> I understand it, yes, this is is exactly the problem -- quoting Corinna,
>>> one of the Cygwin project leads, "The MS NFS is not very reliable in
>>> keeping up with changes to metadata."
>>>
>>> We have verified that setting `core.createobject rename` resolves the
>>> problem for people who are seeing it, which very strongly implies that
>>> this build option would solve the problem similarly, but would fix it
>>> for all users, not just those who spend enough time investigating the
>>> problem to find that setting.
>>
>>  From my experience, it appears that providing Corinna Vinschen (or better put: the Cygwin developers in general) with a sound patch gets things fixed pretty timely.
>>
>> And since `core.createObject = rename` seems to work around the problem, it should be possible to patch the Cygwin runtime accordingly. Sure, it will take a little investigation *what* code should be changed, and how, but the obvious benefit to *all* Cygwin applications should make that effort worth your while.
> 
> Hmm. I'm not sure what a Cygwin fix would look like here. As I
> understand it, using link(2) will fail if the target exists, while
> using rename(2) will just clobber a target file.

Thanks to you and Junio for explaining why my idea was bad. Sorry!

Ciao,
Johannes
