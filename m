From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Branding Overview, Re: Git.or.cz Experimental Design
Date: Sun, 20 Jul 2008 14:44:54 -0700 (PDT)
Message-ID: <m3od4sw7qj.fsf@localhost.localdomain>
References: <5fb1d2400807022011w7f8d79dbk68a64dc1b8b01d98@mail.gmail.com>
	<20080718103918.GO10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Baldwin <baldwindavid@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgjC-0003Oe-Cs
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbYGTVo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYGTVo7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:44:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:54603 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYGTVo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:44:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so375485nfc.21
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=NNWvENkAn4J/AI4Hrp6fheN3rxoPTBejxKK4ZtPoYCM=;
        b=wh46NWLkGR9HjGNg7NiR/tRznxOiFIw9B9Jll3F8Eeu4RGzalO4lpAoq6TWyCDQxEi
         JJPyyzSUnxRv9xg5/fc8wN/4Vt1hRbe+j3SaC/NnEUpySFouVpYB1PPvZ318HlEdoJtk
         YVVUFDAVMmXJ+E4yP8aS1fUE5qtqnNR3ePWps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KWJufCimO/xFy9UurspGOc2KX5ed1bhd2cuV1lm8PxcFqG3DQ1+1mB4L12a7jZ906j
         KIzeUsRV2M2wUTlU5BuXilScBgvEiGEAkJsJjJkCmlsKZc/3GtbFWygT5WHTgwUjJu+G
         7pKIW9ZWmguryhlYqZaFa1/VNb7O+fcv528WI=
Received: by 10.210.118.7 with SMTP id q7mr2536895ebc.198.1216590295165;
        Sun, 20 Jul 2008 14:44:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.215.213])
        by mx.google.com with ESMTPS id b33sm6312615ika.2.2008.07.20.14.44.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jul 2008 14:44:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6KLirGI009632;
	Sun, 20 Jul 2008 23:44:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6KLiq6U009629;
	Sun, 20 Jul 2008 23:44:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080718103918.GO10151@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89240>

Petr Baudis <pasky@suse.cz> writes:

>   If you or anyone is shooting for a re-design, I would suggest to
> somehow relate to the current "Git brandings" in use:
> 
> 	http://git.or.cz/git-logo.png
> 	http://henrik.nyh.se/uploads/git-logo.png
> 
>   If you think you have a cooler logo, that's fine too, but then it's
> again better to present it explicitly, I believe. The latter is used
> especially within mSysGit, the former is used more widely - at the
> current homepage, as Gitweb logo, and in various modifications like
> 
> 	http://git.nyh.se/git-favicon.png
> 	http://members.cox.net/junkio/git.png
> 	http://unfuddle.com/images/screens/source.big.jpg
> 		(top left ;)

By the way, if you find some git logo, please add it to git wiki:

  http://git.or.cz/gitwiki/GitRelatedLogos

I think beside the one from Unfuddle all of them are present on
this page.


P.S. Do anybody remember how we came about current (old) git logo?

P.P.S. Petr, do you know what's the matter with Git Wiki? It looks
like moin4wiki (Wikipeda-like syntax) parser is installed halfway in.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
