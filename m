From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Compile warnings
Date: Mon, 14 Nov 2011 17:58:20 +0100
Message-ID: <CACBZZX6d_ykc9CbN7H-ACWNUxACb9+TH4ffJ-+9T=SEv6Ai0Ug@mail.gmail.com>
References: <op.v4xyekju0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPzrs-0002BH-2t
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 17:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab1KNQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 11:58:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44156 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab1KNQ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 11:58:42 -0500
Received: by bke11 with SMTP id 11so6094436bke.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zwh+wfltyUFLB9l6hgBzNMZa5xXwtx2UKZzFtZPFYek=;
        b=l46LbM3zZqKDb5wlqKBose/RplR4VM/AKO67Ob194JIdxkA2MZUIBdZ1APj6kp32dZ
         l7JVPPwEOgZILT+tdLVr9NqGKXeMnsVnUmz8Cu7RjIHtT3reKjCgZ6YTtOs58bJdIziJ
         fi0oJe+uUC3q23EV9994tiC0Z8xHEzc7+IgLY=
Received: by 10.205.120.20 with SMTP id fw20mr20548763bkc.39.1321289921186;
 Mon, 14 Nov 2011 08:58:41 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Mon, 14 Nov 2011 08:58:20 -0800 (PST)
In-Reply-To: <op.v4xyekju0aolir@keputer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185391>

On Mon, Nov 14, 2011 at 15:55, Frans Klaver <fransklaver@gmail.com> wrote:
> Every now and then I see an 'unused result' warning come by during building.
> What is the general attitude towards these warnings? Remove them (by
> properly checking)? Or leave them be as a kind of documentation -- we know
> we're ignoring the info, but it's good to be reminded?

Under what OS / version and compiler / version and what's the warning?
Paste the full warning(s) you get verbatim.
