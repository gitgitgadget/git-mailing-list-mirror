From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Sat, 19 Jul 2008 07:35:42 +0200
Message-ID: <48817D2E.9080909@gmail.com>
References: <4876B223.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 07:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK57e-00055W-JO
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 07:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYGSFfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYGSFfs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 01:35:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:53683 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYGSFfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 01:35:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so270924fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=DPiO00QG4VDb4Ys+/7q6Kd4d+wdRDssDKEjLsiOegs0=;
        b=KZgdKnqpEQftSYrc4FvczizsR/4CF6nEa0YCoFezxtF6nndbNZblsyWUHE+XYSR0ld
         JDGKYsiCqnc9Vh43E3u2KNQOqU2dnFhnmjfzy8GstY2n4zUcV3VET1kjpD06Puj7DBSW
         h8y/vXnLjyujjR84TRAyiD2Hn5LARdAnqegYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=Hv26KOq7tpze+jLDYnzhJHe8k0Ps0hq21WqaECUdLeGYHMNTi74ZIY9bebwnntCKt8
         em4zwfnV0DcUb1AN8wxkM3xTjCSq1Tm1nPx1FYjrAJBEvazHCC1ufTzxhEoCthpXp7/C
         r5+BQGC5GgziL0IPcozBmUiDinOLOye77qeZ0=
Received: by 10.86.33.10 with SMTP id g10mr1501866fgg.29.1216445745400;
        Fri, 18 Jul 2008 22:35:45 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.253.216])
        by mx.google.com with ESMTPS id l12sm1200470fgb.6.2008.07.18.22.35.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 22:35:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <4876B223.4070707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89101>

Lea Wiemann wrote:
> 1) adding the Mechanize tests,
> 2) adding the Git::Repo API, and (the important part:)
> 3) making gitweb use the Git::Repo API, and adding caching to gitweb.

I unfortunately didn't have enough time to finish the update to the
patch series before my vacation; I'll therefore be posting the next
series only around Aug 12th-13th.  I suggest you wait with any reviewing
till I've posted the next version, since there'll be quite a few
changes; also I'll post patch 3 (the gitweb patch) as (at least) two
separate patches, which will hopefully help with reviewability.

Alright, off to my vacation now -- I'll be completely offline till Aug 10th.

See you then!

-- Lea
