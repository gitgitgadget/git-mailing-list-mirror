From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Mon, 8 Feb 2010 16:20:53 +0100
Message-ID: <40aa078e1002080720y4fe67d1eue2860dff9e12e0bf@mail.gmail.com>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
	 <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
	 <20100207002413.GA14744@gmail.com>
	 <76718491002061650ge299426s22de5e00b26af108@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeVQ7-0007BT-6Z
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 16:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0BHPU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 10:20:58 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:34518 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab0BHPU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 10:20:58 -0500
Received: by fxm3 with SMTP id 3so7776217fxm.39
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 07:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XyRyAGhveZvz1NNh6QMkt0AYjTNmZJZF0dNcJRVIdbI=;
        b=u9J0K/xgqIyVt5NEwczxiciGF6oWP6APEnQDlCoeudGL1pkK/NMh2OX7pzTATZ/jwV
         KT037qnTxv1KrsbtZxwAV6u56ETzAOw7KDwGwISpCo+stTgj5ChNYWQAU6v6OP2aOIN/
         d+Ly5WYNE8kNPATEexolJt+lU3XzhoOH+72nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=sR/jbygIKB68FrHn0rZv3owa/zU3y97w22SgEH8gXnGsirqTEz7VPjrleroUDGsvwm
         smzNGjW7cF6CH+X9u+sgp5s2wFb0IUY+64Fj5jAHZhiDp96/dS6+J7yaApka8jWm6Ovx
         L1kh52FG1vBvflmIfDcP8rqOwSAXaG/j3KMOA=
Received: by 10.216.171.138 with SMTP id r10mr2724308wel.153.1265642454597; 
	Mon, 08 Feb 2010 07:20:54 -0800 (PST)
In-Reply-To: <76718491002061650ge299426s22de5e00b26af108@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139292>

On Sun, Feb 7, 2010 at 1:50 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> I've added it to the Git Wiki:
>> http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your_patches
>
> If you're on MacOS X and have MacPorts installed, then install both
> the curl and msmtp packages, then use an .msmtprc as follows:
>

There's also an article on the msysGit-wiki about using msmtp to send patches:
http://code.google.com/p/msysgit/wiki/UsingSendEmail

-- 
Erik "kusma" Faye-Lund
