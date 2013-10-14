From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] miscellaneous patches
Date: Mon, 14 Oct 2013 16:25:10 -0700
Message-ID: <20131014232510.GZ9464@google.com>
References: <5251CC66.30004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrVq-0002qt-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab3JNXZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:25:15 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40595 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab3JNXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:25:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so8022403pdj.35
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pKkWk3hGutJAWgG0tLuS/SQ1WjfwqcWNYDZlNZPJdlY=;
        b=AeIJqh4U3Jxldl2e6mDCR5jNkMYkUiPmTmj6rrx3tSHZ1Q2pJx05MTBEvwJKk/s7xT
         x0K4R3gk509yvytK09KmIhoRj2HQqLXOJkKQzzUtZNf5YSI6876RTM/f7vz5XNDLuUwa
         rgB225tGQXyQPVv8ORLRk5udrToJ8yJzOPCuKGhkdI3ZaeHfpMtEgqClgj1DO7j2GbCm
         gKxzB26wbELuqan2SRXHkMd9WxBS3HEZfilZJa5r998n8W8WYmyQ/AvrXrxmZAmYifSh
         Gzup8Zwuf9kcXezBTk4EiDRiKYFM7L3dbJcshsetL5TTKYNtFbsr9L1zf0FdPpB4LlFE
         hdqQ==
X-Received: by 10.66.250.138 with SMTP id zc10mr40731389pac.72.1381793113380;
        Mon, 14 Oct 2013 16:25:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id va8sm80386560pbc.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 16:25:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5251CC66.30004@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236148>

Ramsay Jones wrote:

> These patches don't have too much in common, hence the subject
> line, except perhaps that 4 of them fix sparse warnings.

Thanks.  These look good.

I tweaked the descriptions a bit to focus on what sparse was warning
about instead of our having quieted sparse. :)
