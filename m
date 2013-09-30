From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/4] git-svn.txt: miscellaneous changes
Date: Mon, 30 Sep 2013 12:24:46 -0700
Message-ID: <20130930192446.GV9464@google.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 21:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQj5T-0002sO-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 21:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab3I3TYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 15:24:51 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61892 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab3I3TYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 15:24:50 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so5960438pbb.24
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Coa1/f4ZNICcBzirvTEANO5JfX0yshz4O8doMx/Dsyw=;
        b=u3TFKwOjP1CP9uuuvUoOVCgJvhKZjpvRwmict2lt0ih74OW1BFc3AXqC5yuBCLTa8Y
         sUq/RRHgyCJOEm88wDNMWWUGI4FHPc6t5UdkpQHCGNjlqEpv81GPNBmB5P5ZJ6s7nF+S
         MWs++d/1LFiCw+5q4Pb9i01LyGnDQVtrDI3otxYGpzgweR/BsMjikTf3dWTzajXkR2TF
         dwzb5UszMBVVjEk23WwBLkjGa1BZRATJNxDoIZHVaB+geHOpU5SP/CNgkVrzQO4JFw2z
         heIHhX9A29Pkcb54iK3HKC6tkxfSVNostC3uis8W7RnL5wNxXhwGvu0tEWqRrcR7PVT+
         sSAg==
X-Received: by 10.68.195.36 with SMTP id ib4mr25522151pbc.56.1380569090103;
        Mon, 30 Sep 2013 12:24:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tz3sm2306340pbc.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 12:24:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235622>

Keshav Kini wrote:

> Keshav Kini (4):
>   git-svn.txt: fix AsciiDoc formatting error
>   git-svn.txt: reword description of gc command
>   git-svn.txt: replace .git with $GIT_DIR
>   git-svn.txt: elaborate on rev_map files

Thanks.
