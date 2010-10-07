From: Eric Raible <raible@gmail.com>
Subject: Re: git push <branch-name>
Date: Thu, 7 Oct 2010 10:41:27 -0700
Message-ID: <AANLkTikwmF74453He4q49CmdxYSREUQanx6JSoW8xxSL@mail.gmail.com>
References: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>
	<AANLkTinjEoDWhq_EWPj+z++g-b7XMA9d2orXRGtuHyRB@mail.gmail.com>
	<AANLkTi=k9aEqpvoEvU5f-t-63==fouFmJ+OxO=6sQd89@mail.gmail.com>
	<4CADA5E3.5060405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ubH-0000bk-Md
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0JGRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:49:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34187 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab0JGRtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:49:43 -0400
Received: by vws3 with SMTP id 3so20740vws.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=OGwWAVaBU24amBW9luQ8iSVeKtt4X4v544MYxUSJQp4=;
        b=Z/FH8ISpKQrCDQ8u0S+3u+1EfqU9m7Bq+6QYgXuQyI/etmlyxee2iz6Iprxxpxb6Sx
         P5O+BjFiEsuYoquQZx5d+VhIiqCTdivGScxJjgFXbj5Q9aIgnOexSiCb6XPhCMXOUsUx
         dEq2b1FpTTFZl8cF/uFUiyalh4sZyGy5i/94I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SWIzEaeZyH5qqqulQIlUGVKQW1Chc6fyPjQJJYDGnyer8C/J2vHz5l0k/tzWzHQfeE
         5B2F5cMUwPRJU2+zwJRH4Byxq9gWbar0Xq9MrLsn7wa2tTUTMikxxrR1TPWQ2bFYYQPi
         o1msEUdLB4+E6Lj3t0Y8MKRCvPXI60X9LM75E=
Received: by 10.220.165.70 with SMTP id h6mr342706vcy.244.1286473287787; Thu,
 07 Oct 2010 10:41:27 -0700 (PDT)
Received: by 10.220.163.85 with HTTP; Thu, 7 Oct 2010 10:41:27 -0700 (PDT)
In-Reply-To: <4CADA5E3.5060405@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158415>

On Thu, Oct 7, 2010 at 3:50 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Now, if I have a remote foo and a branch foo, what is
>
> git push foo
>
> supposed to do?

http://thread.gmane.org/gmane.comp.version-control.git/158235/focus=158254
