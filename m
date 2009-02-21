From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Sat, 21 Feb 2009 15:53:07 +0100
Message-ID: <49A01553.9020608@storm-olsen.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Feb 21 15:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LatFa-0003MB-EP
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 15:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbZBUOxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 09:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbZBUOxK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 09:53:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:41462 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbZBUOxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 09:53:08 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1156511fkf.5
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 06:53:06 -0800 (PST)
Received: by 10.223.126.66 with SMTP id b2mr3083332fas.18.1235227986347;
        Sat, 21 Feb 2009 06:53:06 -0800 (PST)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id f3sm3519910nfh.5.2009.02.21.06.53.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 06:53:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110958>

Marius Storm-Olsen said the following on 21.02.2009 15:48:
> Prefixes the branch name with "BARE:" if you're in a
> bare repository.
> 
> Signed-off-by: Marius Storm-Olsen <git@storm-olsen.com>
> ---
>  Ok, had some free cycles, so here's fixed up version.
>  Based on next this time

*grmbl* This is v2 of the patch, of course.

--
.marius
