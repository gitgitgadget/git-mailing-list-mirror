From: Christian Couder <christian.couder@gmail.com>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 16:48:41 +0200
Message-ID: <CAP8UFD0PiiA9SxvOuuh4t8P96v+iaJ0TfcBr1-xjMh4TXBEONQ@mail.gmail.com>
References: <4E8066AB.7000208@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8CUB-0005gN-MW
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab1IZOsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 10:48:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57224 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab1IZOsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 10:48:42 -0400
Received: by wwf22 with SMTP id 22so6883654wwf.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/REMbthA6w14d7ZGFHpBaQ8Vnq+ziFfKZoepYd6Qqc4=;
        b=XyhEmt97nsZ+atdNVEVRpqOYFktvpwE8njZaeVSp19TTAS3Adco1SwgpbkbaZe9qgl
         cpY2djd/9NzOkJZ1YUCzYBYH1cnQsCTORPFrTYSMj9Sf5iIBbvgFRNgg0OYXhXeUI+Xw
         WxZoOh3+KBgR+8fr1py6yRXphJDQARpxapmJY=
Received: by 10.216.88.70 with SMTP id z48mr8957545wee.46.1317048521130; Mon,
 26 Sep 2011 07:48:41 -0700 (PDT)
Received: by 10.180.83.168 with HTTP; Mon, 26 Sep 2011 07:48:41 -0700 (PDT)
In-Reply-To: <4E8066AB.7000208@gjlay.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182116>

Hi,

On Mon, Sep 26, 2011 at 1:48 PM, Georg-Johann Lay <avr@gjlay.de> wrote:
>
> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
> that in subversion.tigris.org, so that I am stuck and need some hints on how to
> proceed.

Perhaps you can try to install this module from CPAN:

http://search.cpan.org/~mschwern/Alien-SVN-v1.6.12.1/

or from it's github repo:

https://github.com/schwern/alien-svn

Regards,
Christian.
