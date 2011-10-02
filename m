From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Sun, 2 Oct 2011 15:29:48 -0700
Message-ID: <CAE1pOi1XmLzvuNtv1-cKETDK0UJdirK4ts-7L59dKqGWGxJ98Q@mail.gmail.com>
References: <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<20110822210141.GA3880@elie.gateway.2wire.net>
	<CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
	<CAFzf2Xw6=BFsKauYTG-4cw0D_LzLSNb_wqz8dQJ83wJHNQXbdg@mail.gmail.com>
	<CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
	<20111002150601.GB15083@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 00:29:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAUXi-000495-3g
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 00:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab1JBW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 18:29:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58234 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1JBW3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 18:29:49 -0400
Received: by qadb15 with SMTP id b15so1153125qad.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=/rtEsoqnU7bhFsIFcj8FqLwNzbF5WiNDutTvf57owKw=;
        b=EiZ6Tht83pPAA0xbm6SRVkrXLH8oBp/6fcmNJntnH7HMXjN5e6sSHT0tPGVkKLICHi
         ncdoTJBjfkj07A4dIqFrXpyuVHRwbkze0e0XKi0m8yee9xKi7Wj30ZZW7OuYee7fMOgH
         aCpJQ9euJhzXhnnHArTheV30vdI+7vnqinnBE=
Received: by 10.229.64.163 with SMTP id e35mr10486702qci.239.1317594588629;
 Sun, 02 Oct 2011 15:29:48 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Sun, 2 Oct 2011 15:29:48 -0700 (PDT)
In-Reply-To: <20111002150601.GB15083@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182612>

On 2 October 2011 08:06, Enrico Weigelt <weigelt@metux.de> wrote:
> * Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>
>> Eclipse is a wonderful IDE except for how it makes sharing workspaces
>> practically impossible (where "share" means "put in SCM", not "used by
>> several developers at the same time").
>
> This is one the major points which render it rather useless for me ;-o

As long as Eclipse is the only IDE (AFAIK, of course) that has
workspaces (allowing you to easily group projects) and "Clean Up"
(which helps clean up Java code), I'll stick with it despite its
deficiencies.
