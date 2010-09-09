From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] po/hi.po: Add Hindi Translation
Date: Thu, 9 Sep 2010 20:36:26 +0530
Message-ID: <20100909150624.GA27725@kytes>
References: <1283971131-25106-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=geJoBzDw4z-pWytCi9XmzwXvzyzFHUpVYnmMJ@mail.gmail.com>
 <20100909140205.GA13472@kytes>
 <87aanr6kol.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antriksh Pany <antriksh.pany@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 17:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otijg-0001Os-UK
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 17:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab0IIPIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 11:08:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34826 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0IIPIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 11:08:18 -0400
Received: by ywh1 with SMTP id 1so642934ywh.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ze0Aojh9dhXBVtAiUSqaG1I7ylPq0He/UV9kb1ggKx8=;
        b=XQu5rPtg0W7BJvfMVQzw6hHL4d3akYDXVAEUUGdVXDF6njMyyH3xlnLlD/Oham0N58
         xpMBT3pX6KFqwjNNa1kgiJsWy6AzjJL8C/Brj1V31Y3JRIM26H6SPjfKhmMkF3iMjiYm
         Fv+BTb2wVY1vSfDVIro78RyinMFQYS0a7bfcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GxTz4sBtEF2ydzMPJeQ8q0YeERSsso2Cn4l2vULKdu7FXsCV0gZCP/1BE5qUMHKfm+
         QO0nZ4HmFG6MTmos2OJAT5CvNLqhy8M19uGh72R0UWe+XEiIfAG1TGepoaqapKPRPtgD
         QGt50/q5SWhQZWR5G5XgOXOe7G9+7fvoOcmng=
Received: by 10.100.14.8 with SMTP id 8mr185559ann.182.1284044897560;
        Thu, 09 Sep 2010 08:08:17 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id w6sm2083973anb.23.2010.09.09.08.08.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 08:08:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aanr6kol.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155862>

Hi Miles,

Miles Bader writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > Note that Devanagari rendering is broken on many applications by
> > default at this time- the latest Emacs, Vim and Chrome render it
> > incorrectly.
> 
> Is this still the case in emacs 23.2?  If so, can you send bug reports
> about it (I thought devanagari rendering was more or less supposed to
> have been all fixed up by now)?

I'm using the latest Bzr HEAD, and this doesn't seem to be fixed. If
you can email me off-list with some basic information on what to look
for, I can probably write a useful bug-report and probably even a
patch.

Thanks.

-- Ram
