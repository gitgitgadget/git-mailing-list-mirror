From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git version
Date: Thu, 15 Sep 2005 10:31:03 -0400
Message-ID: <432985A7.5070900@gmail.com>
References: <u5tzmqeqw6z.fsf@lysator.liu.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 16:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFule-00071k-DX
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 16:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbVIOObM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbVIOObM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 10:31:12 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:7373 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965263AbVIOObK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 10:31:10 -0400
Received: by xproxy.gmail.com with SMTP id i27so30059wxd
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 07:31:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s/hfx6NaEpJS5XGmsPid3eMTAaDzEx1plQgcZvdXWQpCAZAShaOUBvVaMIxokuWMbykpt4Ny+AKQYfP4gNkDxn/bsrfYLIoLJumNkcaBeAylZlUZoyBLZjpp2Th4+SzvOy6g9GO2IRXCqjTZ2HOpg7iSR4SPNMPJ+k1GVDHbPJs=
Received: by 10.70.50.6 with SMTP id x6mr325798wxx;
        Thu, 15 Sep 2005 07:31:06 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id i13sm66762wxd.2005.09.15.07.31.05;
        Thu, 15 Sep 2005 07:31:06 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5tzmqeqw6z.fsf@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8606>

David K=E5gedal wrote:
> Why is "git --version" called so, and not "git version"?  It works
> just like any other command, except that it is implemented internally
> in the git script.
>=20
> The "git" command takes a subcommand that does some action or simply
> prints some informational output.  The "version" subcommand fits
> nicely into that, and I don't see any need to prepend "--" to it.
>=20

Consistency with other (non Git) commands was why I suggested the=20
"--version" form when the discussion happened.
