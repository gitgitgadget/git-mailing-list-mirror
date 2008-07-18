From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitdm v0.10 available
Date: Fri, 18 Jul 2008 15:11:27 -0700 (PDT)
Message-ID: <m31w1qyha8.fsf@localhost.localdomain>
References: <20080718154657.7ff0cf9e@bike.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJyC3-0002lc-Tu
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 00:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759959AbYGRWLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759926AbYGRWLe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 18:11:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:25461 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759874AbYGRWLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 18:11:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so188501nfc.21
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=eaACo//IDu7SejVk/+JW4qHCqYYBmhxjOzSaHrhwRsg=;
        b=yHqeZGwEms5MRR+djeDK5nxf158O5cHLiAqluUtMJPGlx4oMYvO8BH9EUsoyopnZAI
         KemEh00/QO2yK1u7/EEKhnYaKa9Xy8A2RAu6lhKYS+qHdRa/2kCIDuaCofGc0/1dFspg
         QAaPnToz44KHSm255td+qexBz2SgnCUnk5K+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=InDLGy1O3KbE/aziysR4GpHRtqdYUXChHrRKWfMI9RRwSWObfzsY6dYH/OgfowGtUD
         WhRLVXOpSYWD8ZSg+DJAgs1/DX9wH3pBt+9Di4N5yS7SDl0WIwmlNsm6q3rJDHynBxb1
         YFiPZYW4Quhf7YYTAySFuXy3yMY7s42jZNouw=
Received: by 10.210.22.16 with SMTP id 16mr563087ebv.86.1216419088889;
        Fri, 18 Jul 2008 15:11:28 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.24])
        by mx.google.com with ESMTPS id d2sm168129nfc.31.2008.07.18.15.11.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 15:11:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6IMBIlc009048;
	Sat, 19 Jul 2008 00:11:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6IMBC8Q009044;
	Sat, 19 Jul 2008 00:11:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080718154657.7ff0cf9e@bike.lwn.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89083>

Jonathan Corbet <corbet@lwn.net> writes:

> Gitdm (the "git data miner") is the tool that Greg KH and I have used
> to crank out statistics on where kernel patches come from.  For the
> curious, I have (finally) put up a public repository for gitdm at:
> 
> 	git://git.lwn.net/gitdm.git

I have added information about this tool to Git Wiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-fbb1cec362b54c74c5bbad3766f8a8f8f883af12

Please check if it is correct, and correct any mistakes (it is wiki!).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
