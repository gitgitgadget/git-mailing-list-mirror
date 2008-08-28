From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 3/3] Show ErrorDialog fot fatal connection errors
 in ConfirmationPage
Date: Thu, 28 Aug 2008 04:30:10 +0200
Message-ID: <48B60DB2.3050409@gmail.com>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com> <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com> <1219887370-17265-3-git-send-email-marek.zawirski@gmail.com> <20080828022149.GB8624@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXIC-0006bd-3F
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbYH1CaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYH1CaT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:30:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:27536 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbYH1CaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:30:17 -0400
Received: by ey-out-2122.google.com with SMTP id 6so48148eyi.37
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2r15GoSMdpC6XelHr96Sh4SsaJ/rtmACpC1mJroykmw=;
        b=CIEsuMYtNvyEsKpIh7FtZhg2GjauMJlq/kg/vyhBLUUWp4kDhhcvrAQvqC2UVfDBU/
         9QAeGKhAtcES5Bwdk9zkpsM8G/ZYOy16tugjHWhRwqRaOHfg8M3BIpTqj8vyGizdqJ7x
         kIeZ99N4v6Ng9JlWnGCErKD+ACt6dKd5uOUhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WG1lL9vdpvupxQ+scmp1ltpaDZa1HqSRMh9GDhuVMlfV8zhlzHV8KZREcV4+ooFFLO
         izaDDv0NmtW/LT4VUB5Xwh1A1ejGpd2ruaNejCnzMu0dlexcfgAqhbC4mo1z4jpdaccU
         ahuNJFpXLyKqacjIWCNL/39SGEmIrgyAOqXNM=
Received: by 10.103.225.11 with SMTP id c11mr469672mur.32.1219890615939;
        Wed, 27 Aug 2008 19:30:15 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id e10sm476240muf.14.2008.08.27.19.30.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:30:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <20080828022149.GB8624@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94019>

Shawn O. Pearce wrote:
>> Subject: Re: [EGIT PATCH 3/3] Show ErrorDialog fot fatal connection errors
> 
> typo ----------------------------------------------*
> 

Ah, right - thanks. I believe that I don't need to resend that? Will 
edit/rebase on my repo.


-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
