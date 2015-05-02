From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [Patch] Nice help Output - SmallProjectIdea[1]
Date: Sat, 02 May 2015 11:51:58 +0200
Message-ID: <87twvvwblt.fsf@hank.tgummerer.com>
References: <CAKB+oNvZxueR9PqysPn3khQZL+8tt3NNrgFzNjHnVuBVtyeZ4w@mail.gmail.com> <87wq0sw1tb.fsf@hank.tgummerer.com> <CAKB+oNtwJtW3h22W_8hEhhYnxAiynM1B839_WO7Yp=eJF_7PpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 11:52:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoU5e-00042b-RH
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 11:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbEBJwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 05:52:01 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35480 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbEBJwA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2015 05:52:00 -0400
Received: by wgyo15 with SMTP id o15so109360286wgy.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=BO5H1tUAv65TNVwvN8U480eM51HjY3xps/g7WzRt6Qg=;
        b=GIgCR/k+x64pio9Nb2pe6VDMbyV77gQEX2NNYT2rmp0R0aW8WGeq6CjUteuhVp7Oru
         AThJrmhLRDMjSygnetRll/5Zop0TRH5wW2bHAYeRyBlBsKTeDbM+Bu65qtEHcq8b1WPZ
         aPnq2nwd5YIKWrSs2cbagee+wWQOBqsZqQS6ZX8vGwkLR/pav9i2aCMneAH9WAwXKbdu
         g7K9EMwMXuyCxNJgWXzIeL0lYII/eSdngEihdG4kpci0wDdg19FNZn6V2ZE1bv9v4zHX
         wSpEgAB8qeN1XyE9X6Uvv1tbaJ9QRZPjB1/i89URLfPIy/3TDulzVKG829NA2NhHfmsf
         p2Dg==
X-Received: by 10.194.90.15 with SMTP id bs15mr24962861wjb.22.1430560319163;
        Sat, 02 May 2015 02:51:59 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id gy8sm1688888wib.13.2015.05.02.02.51.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 02:51:57 -0700 (PDT)
In-Reply-To: <CAKB+oNtwJtW3h22W_8hEhhYnxAiynM1B839_WO7Yp=eJF_7PpQ@mail.gmail.com>
User-Agent: Notmuch/0.19~rc1+3~g0d8251d (http://notmuchmail.org) Emacs/24.5.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268224>

Hi,

On 05/02, Alangi Derick wrote:
> Thanks for the correction. I will work on that and see if i can solve
> the problem.

I've noticed there was another patch series, which attempts at solving
the same problem at
http://thread.gmane.org/gmane.comp.version-control.git/268198.  So
maybe you could coordinate with S=C3=A9bastien, or work on another proj=
ect,
to avoid duplicating the work.

> With respect to my git send-email, it is not working so i
> don't know whether i have a problem with my smtp. I don't know how to
> configure it.

Maybe you can send us the configuration here, so someone might be able
to help.  Though it might be faster to get help on IRC, on the #git
channel on freenode.
