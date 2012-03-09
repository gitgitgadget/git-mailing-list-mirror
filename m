From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how to patch git documentation
Date: Thu, 08 Mar 2012 23:15:04 -0600
Message-ID: <4F5991D8.60207@gmail.com>
References: <jjbqe9$8l3$1@dough.gmane.org> <7v1up2bikm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 06:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5sBB-0000eS-17
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 06:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850Ab2CIFPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 00:15:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37565 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2CIFPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 00:15:06 -0500
Received: by ghrr11 with SMTP id r11so694917ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 21:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XsTTNX1Alv7OWhwwZh1J51eu/gIAtj/cGP+GE+5dCIM=;
        b=PGDGvU4cevOccUODL/1L9+uao0EblIorzDem1d85DC9g0W2R9NvgGqZpIMx6ifHbIG
         dUeHIo0A2JfTgOscFg5T+uwWGZlrX3GszBD+hWKzjkxh+v2KjI5MZMgfjg/yY+E0pmpv
         6DqysJatDm62jSFaq0qcLGjDJ0Qua2les4qZllejROriBVwrLjCJgsOudLIntmRLzwGU
         dTGsfYmqgSFSj4ZFCwWuKsuIRqKBfCl1YSoVcZ9CuQ8ZCcplZTrCYR9ADJ0XyagmwwUd
         Kz2H6Ld1wl0NIvSl7oCea2ztT2tVBoLIloZXCxEwgKy1voF83y2GH2Xe4Ez+lDo9f+oe
         eYIw==
Received: by 10.101.180.1 with SMTP id h1mr249099anp.71.1331270106169;
        Thu, 08 Mar 2012 21:15:06 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id e8sm11004995yhk.0.2012.03.08.21.15.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 21:15:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7v1up2bikm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192676>

On 3/8/2012 8:43 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> What language are the git documentation *.txt files written in?
>
> Mixture of Pidgin English and a bit of AsciiDoc ;-).
>
Is it ok to submit patches to git.git using msysgit, and also from 
git-osx?  I'm not sure how fast I can get past our security people on 
the linux servers, if at all.

v/r,
neal
