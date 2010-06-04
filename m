From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/6] Merge David's SVN exporter into git.git
Date: Fri, 4 Jun 2010 15:29:20 +0200
Message-ID: <AANLkTin0Wrursli8h-VOgQL7TPnmKr5HdYuRZJ1hVSun@mail.gmail.com>
References: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:29:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKWy2-0008LI-87
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab0FDN3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:29:41 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:41790 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab0FDN3l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:29:41 -0400
X-Greylist: delayed 71235 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 09:29:40 EDT
Received: by ywh17 with SMTP id 17so434841ywh.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=4dTMbC5s6glOCyNbhCfoOXI/I8B+Db3tZqjfJYmXOwg=;
        b=xYa6Cu+gCex/XxckuKo0vVJLYESKEanOo/M7/3s7nMhZTdCtVM4fTqkU+DutAWZfuZ
         nNC+ExtF4LO3cjxSYT9FPqTN54D9D3quDUcuRr8+P+JEFnEYbGP4ATaYjz+gliQnUMs3
         FYjj9YKOCq7SBSkHO2753NWqvG7HO15kfK0GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WxXsHfxUUW4sTouc2zPBL0e+jiFFCxmMk21Yu+MAKL79wULpku2BWtzMIfOu4VlDVi
         xHlMZdqH10pvGNdbHVjg7hPKfUq0nw5ml8Owpjm308uInrHxyocDTAFpeniahtkxn1HJ
         e//YAVogFG0Pkbs1GsWNFHoC8x9DwfOEQZDVg=
Received: by 10.150.170.11 with SMTP id s11mr10820739ybe.390.1275658180189; 
	Fri, 04 Jun 2010 06:29:40 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Fri, 4 Jun 2010 06:29:20 -0700 (PDT)
In-Reply-To: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148407>

Heya,

On Fri, Jun 4, 2010 at 15:26, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> in my opinion the author of all six
> patches should be hand-edited to:
> David Barr <david.barr@gmail.com>

If that is the case you should include a "From" line at the top of your patch.

-- 
Cheers,

Sverre Rabbelier
