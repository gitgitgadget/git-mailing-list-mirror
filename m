From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Thu, 30 Sep 2010 07:38:09 -0500
Message-ID: <20100930123809.GD4850@burratino>
References: <4CA3EFE6.2010306@brainstorm-digital.com>
 <20100930024059.GA2373@burratino>
 <4CA41FCC.8050704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Huynh <dennis@brainstorm-digital.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 14:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1IRu-000468-I1
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 14:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0I3MlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 08:41:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53258 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0I3MlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 08:41:13 -0400
Received: by iwn5 with SMTP id 5so2398500iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YeMYhLlbQ8ZFxJLYxHeQ5vkqxU67Fk9Yrbx6NOckJcg=;
        b=afUhEAVgri0vZMRD8DzkoAJTXoEUsAo+atl+noZUK3d1lIdcDpIK/aA9NyWCbtSyPK
         cisOaE13pt/1uAqstn7bm9TkV06c0k16OQ03GB+gtw5UMyj7LBGz7biTaqEtv1ZAldz0
         9Sk82JTez/9BuG0ZAsVZM9Vp1Xa/6zB4ckhvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JQarbBLTve85euVQ0Ter6b9YrpIvTeoNN/tnaxARxTf2JMJiuQufo0JqtcfKo51LqT
         1xowAWkjUKeiu7SysL8gQ/JaU1guQDB+1lbiJ7FIb5/ORwG5oyFYy4HAclTMnN4FpHIS
         2potibJa9cbuRvdS6JajeXjTNWyCChWa10HOw=
Received: by 10.231.172.70 with SMTP id k6mr3657288ibz.125.1285850472586;
        Thu, 30 Sep 2010 05:41:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm10201236ibh.10.2010.09.30.05.41.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 05:41:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA41FCC.8050704@kernel.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157648>

J.H. wrote:

> For the love of monkeys do *NOT* point people at specific git machines
> like that.  Use git://git.kernel.org/pub/scm/git/git.git

Thanks for the correction.  I had some odd memory that git.kernel.org
was a specific machine once, but probably I made it up.  (I have
generally been using git.kernel.org for ease-of-typing reasons.)

> As an overall note, git and gitweb, including my caching version of
> gitweb are available in Fedora EPEL as rpm packages.

Thanks, that is indeed worth mentioning.
