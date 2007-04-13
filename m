From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Ignore BASE extension
Date: Fri, 13 Apr 2007 20:57:13 +0100
Message-ID: <200704132057.15013.andyparkins@gmail.com>
References: <200704131233.13979.andyparkins@gmail.com> <7vslb4awmf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 21:57:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcRtj-0006GT-5H
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 21:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbXDMT52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbXDMT52
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 15:57:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:37273 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbXDMT51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 15:57:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so611827uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 12:57:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HOYhqv9CNoCFQi3IJsu3Q1dJG7Q+TKZaArkI+31BqQTbUsu3a5Dx6hWuStlBaocXcwltApiDtgdX7ox56+grcy5995KZxFODEvfgwB25LKW+9PY8rKzB/4tXtraVVRtTqqtI+Qc5AQnz5AJM73b+WSqLCvNJWwCG7CktB4WEmjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rENqJbdGBge8Agmt+7pdMD13nYrhoBzeaZEOlB12ZMsLM7Ol1DTLxJo6oaAWViTqid370PCU3L/jUvjWTFJPNgOOT3Sykeot2JcgGs3obR5L3F8lLKCta6l1WuRU5LnpYDXFQdqkrrbQlmJ2eaLSGl3T81586ZwA0Swj3SilwMM=
Received: by 10.67.24.18 with SMTP id b18mr2218498ugj.1176494245447;
        Fri, 13 Apr 2007 12:57:25 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm5627666ugd.2007.04.13.12.57.23;
        Fri, 13 Apr 2007 12:57:23 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vslb4awmf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44426>

On Friday 2007, April 13, Junio C Hamano wrote:

> The message would have said "ignoring BASE extension", but this
> means you used git from 'next' to update your index and HEAD and
> then are now running 'git add' from 'master' or older that does
> not have the support for BASE extension.

I can't quite remember what I did, but I could easily have been 
running 'next' from last week and then today's 'master'.  Regardless, 
everything seems fine and the message has now vanished.  Thanks for the 
reassurance that no data was in danger.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
