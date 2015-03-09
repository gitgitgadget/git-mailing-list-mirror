From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 14:07:07 -0700
Message-ID: <20150309210707.GC5535@google.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
 <87y4n6kvdu.fsf@fencepost.gnu.org>
 <CAJo=hJt_PHMEdpfRA0EKQyoH4XhYh89tvajewM28pgxzZ9ONMg@mail.gmail.com>
 <87twxuktzc.fsf@fencepost.gnu.org>
 <CAP8UFD1y86wqg5fpRn1wsMnn8JT9KXuDMgzcseH=sv8NBWO6wA@mail.gmail.com>
 <CAP2yMaJWLppUw2QY3rL7dZPaqVUf6G-UYVrvi35A_t03ow6E_w@mail.gmail.com>
 <20150309192409.GA4733@peff.net>
 <878uf5lyad.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV4tQ-0001Gh-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 22:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbbCIVHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 17:07:12 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32869 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbbCIVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 17:07:10 -0400
Received: by igbhl2 with SMTP id hl2so23224794igb.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6OVFYO3pmeaV7PwEzEyQ+z6moI/igcaYniTJMc4Heww=;
        b=jwu41Ht8sjAHU+1B2Bisrl9Yd0jLi/KbsqL2lnoRI0umLP8Zb8Disuaa1FX4AfW5tG
         xrAtyz0tu5ctcfCB2rIyDeMI85XwVNhFAAVzAoOjZs1hfTdZk908/k/GOtv02r0WXvw+
         otG4/wlLqvWtJEjsRbcFuyi6kWOSxR/jh8hAdvNVnPWiK11NZXjrZeGXQFsr+iV2Aqwu
         Xd5CUSo3QGyUslaUb02VE6aGDkTIeKNGaWE21JS68NXhDafAJ36u6pY+aENSiSgfoMvT
         eO+V1UjpdirWnBxpMlKI54UzopqROhRyRMV+LWjZnKjYDtX50bmvuXjzClKdrKNQDPw1
         8DXQ==
X-Received: by 10.50.114.4 with SMTP id jc4mr77278740igb.14.1425935230089;
        Mon, 09 Mar 2015 14:07:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a03b:4903:b331:df75])
        by mx.google.com with ESMTPSA id s17sm6791838igr.2.2015.03.09.14.07.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Mar 2015 14:07:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878uf5lyad.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265197>

Hi,

David Kastrup wrote:
> Jeff King <peff@peff.net> writes:

>> If people don't like git-scm.com and want to have an alternate site,
>
> I think that's the basic problem here.

With all due respect:

I don't actually see a major problem here.  Any serious problems with
the site can be fixed by people submitting patches, either using
Github's UI or to the mailing list if Github's UI doesn't work for
them.  People can also try mocking up an alternative site if they have
a radical change they'd like to try, and the centrally managed DNS
entry points to whichever site is appropriate.

The old git website was git.or.cz.  That redirects to git-scm.com now.
You can see the old front page at git.or.cz/index.html (and there is a
link to the corresponding git repository near the bottom).  People
with spare time who find content on that site to migrate over are
welcome to try doing so (hint, hint).

Thanks,
Jonathan
