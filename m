From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: is gitosis secure?
Date: Sat, 13 Dec 2008 19:07:07 +0100
Message-ID: <bd6139dc0812131007va4f07f2k54289163932f0c2b@mail.gmail.com>
References: <200812090956.48613.thomas@koch.ro>
	 <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
	 <87hc58hwmi.fsf@hades.wkstn.nix>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Koch" <thomas@koch.ro>,
	"Git Mailing List" <git@vger.kernel.org>, dabe@ymc.ch
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Sat Dec 13 19:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBYui-0005im-6h
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 19:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYLMSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbYLMSHK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 13:07:10 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:15357 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYLMSHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 13:07:08 -0500
Received: by yw-out-2324.google.com with SMTP id 9so879029ywe.1
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gKxRGquy37t+0sUDBTzDXEwvsC099THvfu/qI916CcM=;
        b=FsGxpSgrt8/DNFlZNtyGcLU3YBhPzqPsgXknQhpUIN1qKZ+HauGdNXRhPIn8k2kc3j
         8QaK+8+x6/kF2WrZpboTKp3TKZP54kZhzuTvbKQMZr2FJ3jxTU3cP7+A//a8jy6QEK3I
         c2LtBtRAxFct0Yrzx2YVm/0SgJb2WdRD6+kI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=FJAxz5aLxGkoUnfE5cIQ1XcMCy8CjLS3HeaXtXsgqO25HGt5teKlG4Cw8IHUqADtjS
         wT29MYCzgu54OUShQ92NDVgHaasYCwHMPt0UuiHUjmn2gClkw1HB1ssJYF8eNZaCFUif
         w3mVLdBrX25muZOEWwA2o+4diyEIWMmOnLvV0=
Received: by 10.150.225.14 with SMTP id x14mr8873230ybg.173.1229191627175;
        Sat, 13 Dec 2008 10:07:07 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Sat, 13 Dec 2008 10:07:07 -0800 (PST)
In-Reply-To: <87hc58hwmi.fsf@hades.wkstn.nix>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103007>

On Sat, Dec 13, 2008 at 17:23, Nix <nix@esperi.org.uk> wrote:
> telnet. I do not jest, this is our sysadmins' stated reasons for not
> opening the git port and for tweaking their (mandatory) HTTP proxy to
> block HTTP traffic from git.

I don't know what to say to this :P.

> (Telnet over some horrible impossibly slow buggy proprietary VPN.
> It takes >5min to bring up a single connection.)

I feel for you man, try and get that guy fired and have them hire some
_real_ sysadmins!

> Do not underestimate the stupidity and hideboundedness of undertrained
> system administrators, for it is vast.

This is beyond doubt.

-- 
Cheers,

Sverre Rabbelier
