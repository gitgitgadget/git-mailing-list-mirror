From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sat, 4 Feb 2012 15:15:44 -0600
Message-ID: <20120204211544.GC3278@burratino>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
 <20120204201218.GF22928@burratino>
 <CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtmy6-0001vp-2N
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab2BDVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 16:16:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42642 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2BDVQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 16:16:17 -0500
Received: by iacb35 with SMTP id b35so6498412iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=weMAswUBgv7UtJXDMahGB+Ls82biPIJW4yfeLAr0ohM=;
        b=Pq1/3Sjw/YKh+QhMgdOGVv2TKdYAn9zSzLdi+SnHi0y4Ht6/ZuXZ+xrYe1/A0gIEsn
         r+uZex9O0+J7XGAv6L+ndpSMUe3xOh76U+dqkmBDm8FnRHBK5v2BtlZYb3GQ+oHcTT63
         zs3ufbvdpuXTH469mMGuKeDYxcj3QOCX6NKJo=
Received: by 10.43.47.135 with SMTP id us7mr11663451icb.31.1328390176828;
        Sat, 04 Feb 2012 13:16:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d15sm18137994ibf.7.2012.02.04.13.16.16
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 13:16:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189911>

Felipe Contreras wrote:

> Title: mailmap: add simple name translation test

Thanks.  I guess you think I'm stupid.  I have no idea how I can
correct that assumption and help you to actually work with me to make
the code better. :/
