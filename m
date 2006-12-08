X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 16:38:59 +0100
Message-ID: <2c6b72b30612080738wbad5938r3dae807729e484c0@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <200612081438.25493.jnareb@gmail.com> <4579775C.2010608@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 15:39:11 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGzO9lOr1VD3/Ho2twtUyiPX2X63CasD+sn/00Kb3OoUuKv7vk3VEwhUVdUXLZ9NwC1JxVAH2KPid3xP2qk4A6Tqe+v9aqr+BGY9Xg6mrXvuoiCqzGNBedwMjmNeB2ajdx7cWs53Hkd5/S/h8pOahzKv5gl/2yKfAFYUnFa69sw=
In-Reply-To: <4579775C.2010608@dawes.za.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33700>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GshoV-0007Nh-Vu for gcvg-git@gmane.org; Fri, 08 Dec
 2006 16:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425560AbWLHPjB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 10:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425573AbWLHPjB
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 10:39:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:2768 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425560AbWLHPjA (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 10:39:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so850111wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 07:38:59 -0800 (PST)
Received: by 10.90.113.18 with SMTP id l18mr4218361agc.1165592339367; Fri, 08
 Dec 2006 07:38:59 -0800 (PST)
Received: by 10.90.68.4 with HTTP; Fri, 8 Dec 2006 07:38:59 -0800 (PST)
To: "Rogan Dawes" <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org

On 12/8/06, Rogan Dawes <discard@dawes.za.net> wrote:
> NOTE: This caching could be problematic for the "changed 2 hours ago"
> notation for various branches/files, etc. But however we implement the
> caching, we'd have this problem.

It could be solved using ECMAScript (if that is an option): Include an exact
time stamp or something that browsers not supporting ECMAScript can
show and others browsers can change the time stamp to make it relative
and do the coloring/highlighting of recent activity. This could also slightly
speed up the script and it might be better to provide an exact time stamp
by default if aggressive caching is applied.

-- 
