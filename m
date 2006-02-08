From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 17:35:35 +0100
Message-ID: <cda58cb80602080835s38713193t@mail.gmail.com>
References: <11394103753694-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 17:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6sIA-0005t2-IG
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 17:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWBHQfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 11:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWBHQfh
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 11:35:37 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:36034 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030584AbWBHQfg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 11:35:36 -0500
Received: by zproxy.gmail.com with SMTP id 14so1717546nzn
        for <git@vger.kernel.org>; Wed, 08 Feb 2006 08:35:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3MspWDLs/nL8Cpc+3snnWW7fPBvUHjiv7FmkQXmbSKDXe3JZD7Xav1LbgIE3Md81QY6XEL1CnPsUF+AfuUes3OM3SJ1qF6s72VESXq8/KRoJEyehszZWlEEnYLD2Htg00M5xepjo0VWxgcIFn0guB/y4cYBgZk2ls8jn02gJw0=
Received: by 10.36.160.12 with SMTP id i12mr621681nze;
        Wed, 08 Feb 2006 08:35:35 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Wed, 8 Feb 2006 08:35:35 -0800 (PST)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11394103753694-git-send-email-ryan@michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15740>

2006/2/8, Ryan Anderson <ryan@michonline.com>:
> Signed-off-by: Ryan Anderson <ryan@michonline.com>
>
> ---
>
> I think this version is mostly ready to go.
>

another perl script :(

Are there any rules on the choice of the script language ?

> Junio, the post you pointed me at was very helpful (once I got around to
> listening to it), but the code it links to is missing - if that's a
> better partial implementation than this, can you ressurrect it
> somewhere?  I'd be happy to reintegrate it together.
>

Thanks
--
               Franck
