From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 12:21:04 +0000
Message-ID: <a5b261831003100421n7aadf6cfof24698d7ca1a3a48@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 13:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpKuW-0006yC-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 13:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab0CJMVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 07:21:08 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37393 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0CJMVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 07:21:06 -0500
Received: by wwb39 with SMTP id 39so967752wwb.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MDvwFuWcd1eS3nrksy60nkYuISeUkHz7vTxlTuHQQnk=;
        b=kkF+c7HCjl4ZqdyT7EqNEbWfPFPhruat/kEIX9fyUN4+p6OnQ21rYFz39QwqXak50Y
         q5+zK4XWD0fjvOrk64gtPaVx1Shm/9OEkytV45zjogwcOOcFR4JXQwnrpCSKb+/OSTkc
         yNWAAucGbLU2ZbBW1Q+9aGCYOIGzATr/zogCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=drpQznAvX58gcVXroKTbgRyUp0wOFmr4y3oUipC1MA+WRSoX5mMGzXeycS8Ka+zK7q
         TGkmaVINDSiYAgkWqDBJNDMBgCPRdDdhXkuYCC7hP7BHV3tcIOO5EAT4iFjLfMdA3uBe
         LGPsLyXkSAI7odRfEuNqtZR3Zeh06l8pcA9Y0=
Received: by 10.216.171.138 with SMTP id r10mr853160wel.153.1268223665054; 
	Wed, 10 Mar 2010 04:21:05 -0800 (PST)
In-Reply-To: <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141879>

On 10 March 2010 00:48, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>
>> - git gui now fully supports themed widgets (thanks Pat Thoyts and H=
eiko
>> =C2=A0Voigt).
>
> I remember from reading a thread about this (I think) a while ago tha=
t
> the default themed widget was the usual tcl/tk stuff, what do I have
> to do to get a different theme? Perhaps even, dare I say it, a native
> windows look?

That is just on unix where there is no 'native' look. On Windows it
can pick up your desktop settings be they XP, Vista or old-style
Windows95ish. If you are using XP style on your desktop, then
gitk/git-gui will also use that.
Pat Thoyts
