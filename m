From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] mergetools/diffmerge: support DiffMerge as a git
 mergetool
Date: Sun, 13 Oct 2013 16:01:48 -0700
Message-ID: <20131013230148.GC13033@google.com>
References: <1381616975-13582-1-git-send-email-ssaasen@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 01:02:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVUfr-00045f-Aq
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab3JMXBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 19:01:52 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63103 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3JMXBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 19:01:52 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so6638077pdj.34
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bdgdjKC3liR97uxk1TFWuxgljWD9N7xSnZq1Mtm+zQw=;
        b=E73PHK5V9o7U3x3pJpOdFV6zGCGsR2VqxDHZX/7HjdWJNK2/DUlAsVKwkNlEQZELBV
         9eB3VOjJP+clvO7ElQBaajtC6ndYJkEYNvHndQSLB9PlZFEFHSUL9+8Xdoylxx2A17R9
         h1yUA2aitztOcc4VnzbkP8wo6LVE5OPopqyIemnk3/08zJEumXsudqUtmU6c5rSoHbfC
         jt6oUCZh0NAVfRkkvR31vi3SyMhASPoLQlTK0rx4VO5vpDcQdY7W5LHxZ6dt/BgxUvYf
         xvwFp/V/h1k+7Vw8auy/IVut1o8a7swy8w32z8wND1sQn9iVsj9oIN8djKVTsOTiefVF
         evNQ==
X-Received: by 10.66.161.138 with SMTP id xs10mr34899472pab.56.1381705311677;
        Sun, 13 Oct 2013 16:01:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ta10sm86800428pab.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 16:01:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381616975-13582-1-git-send-email-ssaasen@atlassian.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236084>

Stefan Saasen wrote:

> Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
> Acked-by: David Aguilar <davvid@gmail.com>

Thanks.
