From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Operations on unborn branch
Date: Tue, 27 Nov 2012 12:39:44 -0800
Message-ID: <CANiSa6g2UQyvOWS+nuc6y=wzfFTVJ6G8OK14KOs5DJ3f-n5vOw@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<7vd2yyn685.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:40:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRwn-0003hH-DM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2K0Ujq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:39:46 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40153 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab2K0Ujq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:39:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so8936432iea.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y2ttG2HwUmmETk3fjE352q2y5HJOX9JEPUAOtmJaMeo=;
        b=SNNPEgjM7gzXf16Ifd8l6ZYw5P0zA0kfIS9wCBiDDfzAsBLRWX3RdW1TMFMFQa6zi5
         A91H2Q92H4sLScisDUXUndGFSk1V72Dl37TEZ0EIEdhLbXpluwHJS6UkMfnqHZ8ufx5M
         wPS6GpNzEUcT3P8f0Vv26DB3TPh131EUrhd2daoLqwj8YKWzgtjMCoBZkmKtSaEYkw7I
         i8Rh38mkKddHBUb/Iptfv2FIgW96wWP3I+PNIbs187TSyJofOwYr0kxxnjITaCSmmo7T
         g9lfky7nvcXtE+nnh8G1SGWklFJK2s/tjnDT9P94x1OBW6L69I/MPzBwxsJjYLaGju4X
         xv+g==
Received: by 10.43.14.135 with SMTP id pq7mr14825024icb.8.1354048784739; Tue,
 27 Nov 2012 12:39:44 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Tue, 27 Nov 2012 12:39:44 -0800 (PST)
In-Reply-To: <7vd2yyn685.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210593>

On Tue, Nov 27, 2012 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> simplify a lot of things (maybe I'm biased because of the things I
>> have happened to work on?)
>
> Yes.  Do not waste time on it.

Yes, no way I would waste time on that; I was mostly just curious.

What I might spend time on is to fix cherry-pick.
