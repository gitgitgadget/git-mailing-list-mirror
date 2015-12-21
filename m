From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Someplace to contribute: documentation
Date: Mon, 21 Dec 2015 14:58:53 -0500
Message-ID: <CAPig+cTv0MeXs-DnDrZFudg+Y63rQecM+VNBcutxujrjabdzBw@mail.gmail.com>
References: <4119107.NH3lngImDr@thunderbird>
	<2455418.zs2uug0Fjd@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Stephen & Linda Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 20:59:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB6bj-0006Ei-DV
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 20:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbbLUT6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 14:58:55 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35381 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbLUT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 14:58:54 -0500
Received: by mail-vk0-f43.google.com with SMTP id a189so106668057vkh.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vX0Zn1iTM68jlUxMg0B3WjR68iuuQ5UNOytPHSE9Tqs=;
        b=DUotwqYdhuWSFGGuPbtntaVmf+jpnLV2RZ/HdgrzxeEWj4/PXj9uJVvSO1qRPT7q0P
         hsX0SKsNrEhDP14xIlxPo7vcTYJ+yxEDVldeNCL7C2n2Vf+CHyRNY2z+l97hWrKaHR0l
         3EOp2DuY38oF3xpjSp4KfKxYQgNLkSGMp85OArq/XNj1wT7NbLE8CEMG33fcp6q1ifew
         vh16CIr5kWlN3RTr+nEKv4BmaYIGT90124pKUMPbccCXIK+cQs7JjWLf7MZUTQsHoVB0
         yQ4uoyhymQdMrOVbyHRFcXKV2bMfF906HgRwLF062f2D1tyIJaxUdrXzgA5Kdx0fVcLA
         dp3w==
X-Received: by 10.31.58.142 with SMTP id h136mr13446521vka.115.1450727933478;
 Mon, 21 Dec 2015 11:58:53 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 21 Dec 2015 11:58:53 -0800 (PST)
In-Reply-To: <2455418.zs2uug0Fjd@thunderbird>
X-Google-Sender-Auth: 8BPBM5MfcYsC3_a5JdOYPB07_zs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282813>

On Mon, Dec 21, 2015 at 2:55 PM, Stephen & Linda Smith <ischis2@cox.net> wrote:
> On Sunday, December 20, 2015 06:27:56 PM Stephen & Linda Smith wrote:
>> I've been looking over the git source tree to see if there is some place where I can
>> contribute.   It appears that there are some suggestions at the bottom of
>> the userguide.  Does anyone have other places that they would like
>> worked on first?  If not I will start with one of the suggestions.

The two commonly cited sources of small project ideas are:

http://git-blame.blogspot.de/p/leftover-bits.html

https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
