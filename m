From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Synchronize git-credential-wincred from msysgit
Date: Sun, 12 Jan 2014 14:23:05 +0100
Message-ID: <CABPQNSb0aq74Wg5Pf++Y8HusmuW8MGBYe90dEwLxAXcHbkjEhg@mail.gmail.com>
References: <CAHtLG6RzQEazvvGhzo6B+v15ROdcs42W6-aReTqMsOH8UO4V7g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, kuba@berezanscy.pl
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 12 14:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2L14-0002TV-5b
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 14:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbaALNXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 08:23:47 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46452 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaALNXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jan 2014 08:23:45 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so7092631iec.13
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=+ArfmgPSVvd8zn09UbjFLgrFCnFeqg6TkIoT20GD6TU=;
        b=gk1g4303GKZWv3hdPrrvwfK1Vzk0eUyHCuUmMmVx2XmMSracWr1kNsPc9P+zAHtqD4
         WmWnMPuVor7b3Xi47Uteet6Kl0hP3T4USHAAGZIhpZ+okGUaTjVqh6MS2jLj+uGFqrW3
         vJmfbpFc+YhxfSTFdpkNjoueF+pNELvUjm9SNudW7P8cRzopley1wtl0WdgU4r0wBiU5
         qLCA1aDswqQwpCRdehLh02qQYNwPdl7orzyoHm52NnS2EswhiqoUpgu3lJAXOkofjqN5
         O5WJ8l/lJVra0j67IZJVt0bgnDkLv8dEubE8I6v/fXnFVDx0YO9ZsWgGxMXtZ96l/HXy
         ds9A==
X-Received: by 10.43.49.132 with SMTP id va4mr430927icb.79.1389533025141; Sun,
 12 Jan 2014 05:23:45 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Sun, 12 Jan 2014 05:23:05 -0800 (PST)
In-Reply-To: <CAHtLG6RzQEazvvGhzo6B+v15ROdcs42W6-aReTqMsOH8UO4V7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240348>

On Sun, Jan 12, 2014 at 12:59 PM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli=
@gmail.com> wrote:
> Hi,
>
> Please cherry pick from msysgit/git
> commit 3c8cbb4edc8f577940c52115c992d17575587f99
>
> to synchronize git-credential-wincred
>
> This was the change they made half year ago.

It's actually a two-patch series.

Cover-letter:
http://permalink.gmane.org/gmane.comp.version-control.msysgit/18626

Patches:
http://article.gmane.org/gmane.comp.version-control.msysgit/18627
http://article.gmane.org/gmane.comp.version-control.msysgit/18628
