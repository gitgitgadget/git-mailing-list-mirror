From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GitJungle is out!
Date: Mon, 13 Dec 2010 05:12:39 -0800 (PST)
Message-ID: <m3d3p54y21.fsf@localhost.localdomain>
References: <4D05FF8D.7080306@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 14:12:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS8Cx-0005J2-Do
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 14:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab0LMNMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 08:12:45 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:52209 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588Ab0LMNMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 08:12:44 -0500
Received: by bwz16 with SMTP id 16so6566827bwz.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 05:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EVpw4Me91ESBiL8zNskuEkc6EqsPNY7yd+TzKgPHMKQ=;
        b=LSXJPsU6ZSWq0fJgAan2IhBs8YRmfEzkxVrU62gBztGAjTeKFUTQ3cbAbXQHwTSxGn
         gfGT3HFI4SsmsSsEGcvO2rjua2cZrYiVNqoX4PyXIeh+32L4wb+64NpzLluVpaBtwXFZ
         kqjzgEksc+kXkmrdv8o4rU6nU/dtMTx3MHKk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CB94CMAtwAEZkOZDevdjYXhZW6Sf3TlxbdCSF9YT8Tw+eEByyifz55zC02YdWcRtI5
         E1CrpxrNS04LrCLCAFkZ/b216NhrsV4z+BHICCeqPD1Y+jCG8Vo96Dty+mxqw54JCMp5
         cxkdFaESnHMcvpgKpbRpHZw9rb2l4g9t0k/Qg=
Received: by 10.204.61.74 with SMTP id s10mr3638238bkh.91.1292245961077;
        Mon, 13 Dec 2010 05:12:41 -0800 (PST)
Received: from localhost.localdomain (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id a4sm64046bka.7.2010.12.13.05.12.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 05:12:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBDDC75e018125;
	Mon, 13 Dec 2010 14:12:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBDDBoRF018119;
	Mon, 13 Dec 2010 14:11:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4D05FF8D.7080306@codicesoftware.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163555>

"psantosl@codicesoftware.com" <psantosl@codicesoftware.com> writes:

> We've just released GitJungle
> (http://www.plasticscm.com/labs/gitjungle.aspx), a git branch explorer
> based on the same codebase we use in our version control product,
> plastic scm.
> 
> We wanted to call it something like GitForest (you know, so many
> branches and trees :P) but the name was already reserved...
> 
> GitJungle is a beta and works on Linux, Mac and Windows and basically
> we'd love to get feedback. The drawing approach we use is a little bit
> different from what other git tools are using: we draw horizontally
> instead of vertically, we think it is a better way but, you know, it is
> probably a matter of preference.
> 
> I'd really like if you could give it a try and of course any feedback
> (including tough critics) will be more than welcome.

Could you add information about GitJungle in the correct place at
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
page on Git Wiki?

Thanks in advance
-- 
Jakub Narebski
Poland
ShadeHawk on #git
