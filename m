From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 16:13:48 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806061613300.886@sf.creativecommons.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org> <alpine.DEB.1.00.0806061911300.1783@racer> <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
 <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com> <alpine.DEB.1.00.0806070006150.1783@racer> <7v4p86rwfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Cedric Vivier <cedricv@neonux.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l8w-0007nD-HS
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYFFXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYFFXNx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:13:53 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:56736 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751654AbYFFXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:13:53 -0400
Received: from sf.creativecommons.org (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id F3B3FA010B;
	Fri,  6 Jun 2008 19:19:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTPS id 094DB144C40B;
	Fri,  6 Jun 2008 16:13:49 -0700 (PDT)
X-X-Sender: paulproteus@sf.creativecommons.org
In-Reply-To: <7v4p86rwfi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84136>

On Fri, 6 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Fri, 6 Jun 2008, Cedric Vivier wrote:
>>
>>> On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>>> But can't that be just as easily done by piping through sort? (I
>>>> understand there is a platform which lacks the sort utility, boohoo)
>>>
>>> Yes, but sort does not have a natural sort option afaik.
>>
>> sort -n
>
> That's Numeric sort, isn't it?
>
> I sometimes dreamed of having "sort --random" for testing purposes ;-)

I use "bogosort -n" for that.

-- Asheesh.

-- 
We are the people our parents warned us about.
