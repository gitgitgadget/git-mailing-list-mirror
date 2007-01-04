From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 14:04:37 -0800
Message-ID: <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <20070104213142.GE11861@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 23:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ahW-00083l-9k
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 23:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbXADWEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbXADWEj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 17:04:39 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:5351 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030190AbXADWEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 17:04:38 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6880678wxd
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 14:04:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGF8hFJjpfiWkM+BIc0rh9j1+sdeC4C4WhgYJK9/R79nXu+vZCNstSnP4fS5Z/aWPOi4zu9RiT7tSOAUS4vDm2SEP6I2Aqgstb84C6Zc6P0f3NSqqLUdoQldcGiXLX2VekUzUX+pyJ1xCZUEWM0oCOBTiDCyNeQQDUuijzCLZsI=
Received: by 10.90.93.6 with SMTP id q6mr563310agb.1167948277708;
        Thu, 04 Jan 2007 14:04:37 -0800 (PST)
Received: by 10.90.83.17 with HTTP; Thu, 4 Jan 2007 14:04:37 -0800 (PST)
To: "Sasha Khapyorsky" <sashak@voltaire.com>
In-Reply-To: <20070104213142.GE11861@sashak.voltaire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35958>

> Chris, it works fine for me with small repository (~9000 revisions), but
> I don't have such huge one as yours. Could you try? Thanks.

Patch looks like it makes sense. I can definitely try it later.

Back to work for now...
