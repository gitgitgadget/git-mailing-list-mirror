From: Santi Bejar <sbejar@gmail.com>
Subject: Re: Pure renames/copies
Date: Tue, 22 Nov 2005 10:03:03 +0100
Message-ID: <8aa486160511220103t7caf5ad2n@mail.gmail.com>
References: <87hda61a80.fsf@gmail.com>
	 <Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
	 <7vacfxrdao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 10:04:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeU3T-0002qY-1q
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 10:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVKVJDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 04:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVKVJDG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 04:03:06 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:62220 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751279AbVKVJDF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 04:03:05 -0500
Received: by zproxy.gmail.com with SMTP id 40so899567nzk
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 01:03:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBkQFZMk60coUv3809uXA06NeVw8f5R6bYOpDNjGDctOgTMUJkJLtXVg8MkbwCl7YItVm3Vr9Zv3I1uK4pQb6k4S1W+Rxetk0OHeSod10oYkKEFFbCAtDdUq5jO3j0u99GJ2u8qQUXDkch2Y9tb5ScN4kwKUs9A9X/kHln3fz2I=
Received: by 10.65.234.16 with SMTP id l16mr4153227qbr;
        Tue, 22 Nov 2005 01:03:03 -0800 (PST)
Received: by 10.64.178.1 with HTTP; Tue, 22 Nov 2005 01:03:03 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacfxrdao.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12538>

>
> Probably something like this would suffice.
>

Ok, thanks. Now the only issue with my broken repository (it does not
have all the blobs) is that it outputs:

error: unable to find abcde....

for all the src paths, but the result is ok.

But I can live with it.

Thanks
