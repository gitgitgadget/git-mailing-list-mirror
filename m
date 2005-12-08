From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [PATCH] Make sure we use compat/subprocess.py with Python 2.3 while running tests.
Date: Thu, 8 Dec 2005 09:04:45 -0800 (PST)
Message-ID: <20051208170445.38067.qmail@web34302.mail.mud.yahoo.com>
References: <7vr78oktp0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 18:08:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkPCK-0000fV-UB
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 18:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVLHREq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVLHREq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 12:04:46 -0500
Received: from web34302.mail.mud.yahoo.com ([66.163.178.134]:26764 "HELO
	web34302.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932215AbVLHREp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 12:04:45 -0500
Received: (qmail 38069 invoked by uid 60001); 8 Dec 2005 17:04:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EXsMlJKaEReR76M/nymN8kGJVszQg7+OCht3IhKIP3+Qt0yzVgvHG35+ALTGRSHVpzON21gW8a5adkft1dyTzMaIdG7KMuf3Cs4qVfJfEvL6qAkSC+T7Ee0NHMzHj41ggXZJW+5Qoty+l3AHlyhaI3PZVR8T6bRW+UejoGeF1v8=  ;
Received: from [65.173.207.2] by web34302.mail.mud.yahoo.com via HTTP; Thu, 08 Dec 2005 09:04:45 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr78oktp0.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13366>

--- Junio C Hamano <junkio@cox.net> wrote:
>   This seems to fix it for me.

Works on my build here. Thanks!

--Mark
