From: Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 23:11:20 +1300
Message-ID: <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 11:11:31 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evtzn-0006hm-Hy
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 11:11:24 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932071AbWAIKLW (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Mon, 9 Jan 2006 05:11:22 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1751238AbWAIKLW
	(ORCPT <rfc822;linux-acpi-outgoing>); Mon, 9 Jan 2006 05:11:22 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:44429 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751231AbWAIKLV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Mon, 9 Jan 2006 05:11:21 -0500
Received: by wproxy.gmail.com with SMTP id 69so3133622wra
        for <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Mon, 09 Jan 2006 02:11:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UuF6pYCZyAxTf8CccMeZ3HD9T/jXu3gCxMcA6BiEoKpr8EjOJDiGckC0EUCQkEWdoTuJ3enk6vKCUNjcPCcMuDEYxwnA+RoTRll+L15Ooyypm0kQQoqSz7kfG5DyAGe5tbQ/dHbfLBS6kOtMYz39pzaeKy/QjIoe1eHdKidwvn4=
Received: by 10.54.120.2 with SMTP id s2mr5013816wrc;
        Mon, 09 Jan 2006 02:11:20 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 9 Jan 2006 02:11:20 -0800 (PST)
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> I appologize for using the phrase "completely insane".
> The rebase proposal caught me somewhat off-guard and
> I was expressing surprise -- hopefully not taken as insult.
>
> Further, I thank you for your thoughful follow-up.

No worries... and no offence taken! In a sense we are still exploring
possible/desirable workflows and what the missing pieces are. And yes,
some thing don't quite make sense from the outside, perhaps because
they just don't or because we arent' explaining them very well.

In a sense, we do have a bit of a challenge explaining what how all
the parts fit together, even to bk old timers it seems.

> While I don't expect it to become a routine occurnece for me,
> I do see that rebase has utility in some situations.

As long as you've got enough tools to use a workflow that fits you,
it's all good.

cheers,


martin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
