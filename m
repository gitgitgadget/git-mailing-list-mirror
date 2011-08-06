From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] gettext: add gettextln, eval_gettextln to encode common idiom
Date: Sat, 6 Aug 2011 13:53:12 +0200
Message-ID: <CACBZZX4c-F3PZfHWH=4OBVDgtouU3kfJ_0WZ-JzG=0uJhpgRfQ@mail.gmail.com>
References: <1312604164-19980-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 13:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpfTh-0004wq-Fw
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 13:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab1HFLxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 07:53:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54942 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1HFLxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 07:53:13 -0400
Received: by fxh19 with SMTP id 19so3668740fxh.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DJYffQHciz2UlA5Pejmq+BNZLkzzQ0kbhMsT6z8XtmY=;
        b=iDOV07BtgDkPuYxczFYFik27pSnqH7TdbObDMM9UXsC1bqnrkLR+5Omg/zQUUJq+rg
         oqJZhDcwFEpLHljDG0IEZ9+0wlHm2ghBJl03+h7jOPTGMHZzbG2ysWjeuh0SK0/xBqbn
         xsKqDvrpMOdfSfP1jmF2Guesg+nJ7Pj0p3c4w=
Received: by 10.223.15.13 with SMTP id i13mr4497541faa.51.1312631592530; Sat,
 06 Aug 2011 04:53:12 -0700 (PDT)
Received: by 10.223.119.1 with HTTP; Sat, 6 Aug 2011 04:53:12 -0700 (PDT)
In-Reply-To: <1312604164-19980-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178880>

On Sat, Aug 6, 2011 at 06:16, Jon Seymour <jon.seymour@gmail.com> wrote:

> This patch introduces two new helper functions, gettextln and eval_gettextln
> which append a trailing newline to the gettext output.

I like this, I would have done this myself but didn't have time.

Acked-by me
