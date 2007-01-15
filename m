From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:50:26 +0000
Message-ID: <200701151150.28082.andyparkins@gmail.com>
References: <200701151000.58609.andyparkins@gmail.com> <20070115105616.GE12257@spearce.org> <Pine.LNX.4.63.0701151201100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:00:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi6-0006e5-Aa
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:30 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9q-0003eK-At
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXAOLue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 06:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAOLue
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 06:50:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:20560 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXAOLue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 06:50:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1327921uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 03:50:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r3B5mL0x08W+pvpBoaofO6cjLEWP87u4re/ymDeCsMvRqzDScpNvKC6M51z+n8mbExJBmP6kG0W2go/kMQmt+alPCVV0M67WFynmA4ZR+aEhRbkXU7QSSiKTwuzMd3mQ6uP+84gmYpaiKr3FMNi30iWS/wsQi4S2RhGyGxDuT9Y=
Received: by 10.66.248.5 with SMTP id v5mr5276084ugh.1168861832021;
        Mon, 15 Jan 2007 03:50:32 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k2sm5476899ugf.2007.01.15.03.50.31;
        Mon, 15 Jan 2007 03:50:31 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701151201100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36808>

On Monday 2007 January 15 11:08, Johannes Schindelin wrote:

> It is not only paranoid. It is bad practice.

True.  However, I don't see that it is Git's place to dictate policy.  If a 
company wants to use Git and wants to use it in an oppressive and inefficient 
manner, while alienating their developers, who are we to stand in their way?

> Please have a look at the Linux kernel development, or for that matter,
> git development itself. Here, people care, people trust, people respect
> each other (sometimes YELLING, to keep discussions exciting). And the
> result is: nice code.

Again true.  What has that to do with Git though?  Why shouldn't Git have 
features that let people with different methods of development from you use 
it?  It is certainly true that signed commits /is/ a feature.  And it's a 
feature that some people might want.  If there isn't a technical argument 
against it, what does it matter?

(Note: it doesn't matter enough to me that I would put the time in, I'm 
arguing in the abstract really - should features be kept out because they 
allow a development method we would find distasteful?)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
