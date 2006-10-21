From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:41:07 +0200
Message-ID: <200610211941.07635.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <845b6e870610210931r19aaaac3y3dfd0d9c4af8ed40@mail.gmail.com> <200610211859.03420.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, "Carl Worth" <cworth@cworth.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 19:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKqE-00057v-Cc
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423368AbWJURk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423369AbWJURk7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:40:59 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:18253 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423368AbWJURk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:40:58 -0400
Received: by qb-out-0506.google.com with SMTP id p36so282066qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:40:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XwdDcqPmprqCqXyxtP4nER2+FS5i+KvqDmd03ht3vlJoqb6A6tnm4Ua+flBrqYOMKm6oykyhoUv6TFUJdog6V8Mp9lwuCxDu5taI1ggX5Wby5UUhssCnsOYrzkJ7BKzGC76U6fywEazr3mKOROwKwziq6aahq1HbQXtk/qyk3AA=
Received: by 10.67.93.6 with SMTP id v6mr4122538ugl;
        Sat, 21 Oct 2006 10:40:56 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 50sm21974ugb.2006.10.21.10.40.56;
        Sat, 21 Oct 2006 10:40:56 -0700 (PDT)
To: "Erik =?iso-8859-1?q?B=E5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <200610211859.03420.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29644>

Note: instead of symlinking .git/objects/ objects database,
you can simply set and export GIT_OBJECT_DIRECTORY environment
variable.

-- 
Jakub Narebski
Poland
