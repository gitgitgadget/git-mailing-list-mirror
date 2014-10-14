From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 14 Oct 2014 07:29:11 +0200 (CEST)
Message-ID: <20141014.072911.995931063273261216.chriscool@tuxfamily.org>
References: <CAP8UFD1ATE-CtqXJyd7qDw-34RJ3ZQibHo6BSi+42hkaPNzz5w@mail.gmail.com>
	<CAP8UFD0Fx455GiM8EphkG=-vswR-GOD169EOgf2gJsGzTHS=SA@mail.gmail.com>
	<xmqqlhoj1v82.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, mst@redhat.com, git@vger.kernel.org,
	peff@peff.net, mhagger@alum.mit.edu
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 14 07:29:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdufy-0007xz-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 07:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbaJNF3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 01:29:34 -0400
Received: from [194.158.98.14] ([194.158.98.14]:41855 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752444AbaJNF3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 01:29:34 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 53A6269;
	Tue, 14 Oct 2014 07:29:12 +0200 (CEST)
In-Reply-To: <xmqqlhoj1v82.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> On Sun, Oct 12, 2014 at 11:36 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> With v16 you can easily choose if you want to have the S-o-b in the
>>> output or not, when there is already one, ...
>>
>> By the way, I sent v16 just before the above email, but the series
>> still hasn't hit the mailing list.
>> Did some of you guys in cc receive something?
> 
> I see them and picked them up to replace.

Thanks!
 
> Are these now ready for 'next'?

Yeah, I think so.

Thanks,
Christian.
