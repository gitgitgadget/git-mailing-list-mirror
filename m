From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Sun, 21 Feb 2010 23:53:11 -0500
Message-ID: <4B820DB7.20406@gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> 	<4B7E3856.3080609@gmail.com> <fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjQQQ-000332-8R
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820Ab0BVFBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:01:37 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:14453 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab0BVFBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:01:36 -0500
Received: by qw-out-2122.google.com with SMTP id 8so408192qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 21:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GhARmpgcZBtL2Y1uam3Y0/PM3L7DXoKqWEKLHSQM50Q=;
        b=RAN7+XaRNHnmAz3BXIHsTjcm2jjRzsicHK6Ic/X3C3VNUegB2cbo50nwKMGpONsI71
         RtobWbmy0RKtnbvZ5GiCWi7C+6iu048LynXc8jpBRQpIM8vzj1dMRfxbbkBgxnJVcWPZ
         nL45nNMq0vwzsBwYP/ALF5ma9OR/mSh18j4T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VZUql5EvBuky1i0rEQfUewoW/o0p3d+OVwr7qyAv3P40kEa/Tkf/6usjlXxXu1jm3j
         ivaBDN8U+CSiaDrCdawTq1nOQy3xOnhSjaFYNaskHJSG82g/BtoJxywrrMRSMs9SWzt4
         K1nTxa0UOQmnOk+jUR7bP2nmnY1IRRSP1cdZo=
Received: by 10.224.95.162 with SMTP id d34mr5614428qan.196.1266814394957;
        Sun, 21 Feb 2010 20:53:14 -0800 (PST)
Received: from ?192.168.2.202? (dsl-152-38.aei.ca [66.36.152.38])
        by mx.google.com with ESMTPS id 23sm2323820qyk.3.2010.02.21.20.53.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 20:53:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140606>

On 2010-02-19 02:49, Sverre Rabbelier wrote:
> Heya,
> 
> [please do not cull the cc list, it is considered rude on this list]
> 
Oh .. sorry for that. I will keep this in mind from now on.

> Perhaps you could benefit from looking at my git-remote-hg code so
> far, I'll put it up on github [0] today as 'remote-hg'.
> [...]
> Yup, that would make sense, you could put your code in
> /git_remote_helpers/bzr/, alongside with the to-be-added
> /git_remote_helpers/hg and /git_remote_helpers/cvs.
> 
> [0] http://github.com/SRabbelier/git
> 
Thanks. I'm sure it'll be helpful.

I'm probably not going to push anything in the short future, cause I'd
like to experiment a bit and think things through before starting to
code. But the bzr remote helper code should be in my git clone on
github. This way interested people can follow along and comment on the
progress (more discussions will come on this list)

http://github.com/lelutin/git

-- 
Gabriel Filion
