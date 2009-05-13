From: John Tapsell <johnflux@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 16:57:00 +0300
Message-ID: <43d8ce650905130657q2de9686q683fea84345a6651@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <4A09E719.4090205@gmail.com>
	 <alpine.DEB.1.00.0905130222460.27348@pacific.mpi-cbg.de>
	 <4A0A5BDB.9030602@gmail.com>
	 <alpine.DEB.1.00.0905131215010.5046@intel-tinevez-2-302>
	 <43d8ce650905130340q596043d5g45b342b62fe20e8d@mail.gmail.com>
	 <43d8ce650905130341g516c899fsdc6b50a45381d4c6@mail.gmail.com>
	 <76718490905130642h792e9701sf2ec7fbf2e7de96a@mail.gmail.com>
	 <81b0412b0905130644u7e22bde4ta97616a4ed8be1e0@mail.gmail.com>
	 <76718490905130650u4d047e13pa73e0a96289c452a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 15:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ExM-00086t-HW
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 15:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbZEMN5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbZEMN5A
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 09:57:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:57134 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZEMN5A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 09:57:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so351081ywb.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T6uc+mrxfiYFf7cxstRS1w6fV0vBxxW2XHRdci4oEmI=;
        b=XamSctbla4SzhvNITroLt/aFbEA8Y9+s4HhPCtgLN4meEsxD0TaksmGGQvMFsiYg32
         /06N+yzVoTD6htXqtij+HG4lWkK/PtomzPf62mOMXFgVicEAIyKLA3Menbve/+NOFgOh
         PvKgXTtCQOYQwYUdkt/o3S9tPU0NegjB5ZPEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D15+lN7wBmBsZG6jdyA0TPYohU0Bi77UZhe2XA/aIiqueMV080jXo642yFK5WfV1ww
         5OC6QLP3GgC6HR1YeQqOUxfvw/pb4O6FYvJDGamqdmPWJsCW6Uv8BurQMtHI+ESsrmvb
         r/2X/y6WSHzX/2yIroVdjq7DfugyLTkcYVqns=
Received: by 10.151.73.9 with SMTP id a9mr1211267ybl.134.1242223020698; Wed, 
	13 May 2009 06:57:00 -0700 (PDT)
In-Reply-To: <76718490905130650u4d047e13pa73e0a96289c452a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119050>

2009/5/13 Jay Soffian <jaysoffian@gmail.com>:
> On Wed, May 13, 2009 at 9:44 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> 2009/5/13 Jay Soffian <jaysoffian@gmail.com>:
>>> On Wed, May 13, 2009 at 6:41 AM, John Tapsell <johnflux@gmail.com> wrote:
>>>> I don't know why the git developers are being so hostile/dismisisve,
>>>
>>> Are you serious?
>>>
>>
>> ...because we'll kill you if aren't >:-E
>
> I'm just flabbergasted by some people's expectations. Perhaps John
> doesn't realize the git developers are all volunteers, and that it is
> never appropriate to criticize a volunteer. A "thank you for all your
> hard work on git" would have done nicely.

I'm as much of an open source developer as anyone else here.  I spend
a huge amount of my time programming for KDE.  But I've never told a
user "well that settles it" because they won't code it themselves :-/
I certaintly get a huge number of bug/wishes that I can't/won't code
myself, but I try to be a bit more diplomatic about it.
But then the kernel mailing lists tend to be a lot more.. direct..
than the kde mailing lists, so I guess it comes from that.  Requiring
people to have a thick skin and all that.


John
