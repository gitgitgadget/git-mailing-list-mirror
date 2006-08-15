From: "David Rientjes" <rientjes@google.com>
Subject: Re: [PATCH (revised)] gitweb: Show project's git URL on summary page
Date: Tue, 15 Aug 2006 14:36:33 -0700
Message-ID: <9ec263480608151436l4a31359erd9acb095247d9095@mail.google.com>
References: <200608152003.05693.jnareb@gmail.com>
	 <200608152303.17994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 23:38:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD6aa-00015A-TH
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 23:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHOVgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWHOVgl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 17:36:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50811 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWHOVgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 17:36:40 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7FLaZVt030848
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 14:36:35 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=U998SuebwqtrGJiulrsAW+WodjLGyW7zC6085on9c0JmqRdIDZtWdlQDR8bTwD7PU
	aNHBBIe8T5Yeid3KVQImw==
Received: from smtp-out2.google.com (fpe16.prod.google.com [10.253.5.16])
	by zps76.corp.google.com with ESMTP id k7FHVPg7010665
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 14:36:34 -0700
Received: by smtp-out2.google.com with SMTP id 16so175216fpe
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 14:36:34 -0700 (PDT)
Received: by 10.253.29.11 with SMTP id c11mr649043fpc;
        Tue, 15 Aug 2006 14:36:33 -0700 (PDT)
Received: by 10.253.15.12 with HTTP; Tue, 15 Aug 2006 14:36:33 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200608152303.17994.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25485>

On 8/15/06, Jakub Narebski <jnareb@gmail.com> wrote:
> From 31e4de9f22a3b17d4ad0ac800132e4e1a0a15006 Mon Sep 17 00:00:00 2001
> From: David Rientjes <rientjes@google.com>
> Date: Tue, 15 Aug 2006 11:43:04 -0700
> Subject: [PATCH] gitweb: Show project's git URL on summary page
>
> Add support for showing multiple clone/fetch git URLs for project on
> a summary page. URL for project is created from base URL and project
> name.
>
> For example for XMMS2 project (xmms.se) the git base URL would be
> git://git.xmms.se/xmms2.
>
> With corrections from David Rientjes <rientjes@google.com>
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Signed-off-by: David Rientjes <rientjes@google.com>
