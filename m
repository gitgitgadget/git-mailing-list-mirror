From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 19:37:31 +0000
Message-ID: <200703021937.33648.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <es9aal$5gf$1@sea.gmane.org> <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 20:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDcF-0006Fz-5V
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbXCBTk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbXCBTk2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:40:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:52145 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039AbXCBTk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:40:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so795832uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 11:40:26 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dkGD6sR+Owb64iirF75mBTf3D4JydHJVN+J2kLf6KVKrdJizQ/7X/LxqHuYPvm/TTjVAvyZEgVKENaX8JneV+z97laVBPLWmHld4q/N8nb/WGw/Sfg57PdN10QirF0Vm22tDg5P12CX1PAjTsaSeStVzcGacnDzMOYmOKXK5bik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KwxKAZxGwUhDy3tI4CItpqaqxBeTCOuKcW9cjviDuQa3wiXPCMHIdiEeMMxj+y2teRAMEARS2u4W1rHGO+11gj2GBeOuznb0v+61UsKODpU3lio0PClyjLffBLBEzfsOcwLDWaGb5u3A4Tdtrmx4LZfGy0gn3uBT9ilGhy2MWMI=
Received: by 10.67.117.2 with SMTP id u2mr3765634ugm.1172864426719;
        Fri, 02 Mar 2007 11:40:26 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 29sm2822277uga.2007.03.02.11.40.24;
        Fri, 02 Mar 2007 11:40:24 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41241>

On Friday 2007, March 02, Linus Torvalds wrote:

> Yes. How about just having the built-in git pager do the right thing?

Perfect.  This is absolutely the right thing to do I think.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
