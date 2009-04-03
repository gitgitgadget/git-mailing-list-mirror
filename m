From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Whitespace options
Date: Thu, 2 Apr 2009 19:15:54 -0700
Message-ID: <612E4BF7-3230-462A-8A82-1E268F9A7632@gmail.com>
References: <3C72F4A7-9B7A-44D0-B13D-FD534EB02C27@bitart.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 04:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpYyK-0000XQ-Az
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 04:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZDCCQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 22:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZDCCQA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 22:16:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:30101 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbZDCCP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 22:15:59 -0400
Received: by rv-out-0506.google.com with SMTP id f9so930390rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 19:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:content-transfer-encoding:from
         :subject:date:to:x-mailer;
        bh=0M6DkrS4oayg7ywQQUvHjZ6fohkIIKPJ/R/ycR1skEA=;
        b=ivJzFxmZGVBtCEVZz+7gmZSxSvvudsYv6IfdJc7pd/tnMGM+cTYWHBOjtFR1kB5RvF
         Qyg9vZC0Y2Br+NlQMRbZicGggqdi4sE4zm5gsoKAJIjMsovPQv7KJOcyL/DiE06lFqQe
         oj58OVhk3x1/DnXHueCmHGJTGqKDSKAJJ1xnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=ZCrl8LDPPBr12vOnOkSQoNe2h+D+wludnUgXCHmJRjxKBA6JVg6TUL360XVGv5jkYd
         78pix1hAYRPcyhnaL9frdQXa2NmZgAj3QHtGkAEi+1vC3AXXwY0FDHJs/VTgfJcrQXqK
         3b+SAHjGXvIkPO6LjFnQaUSpy0yms4WK9QlPc=
Received: by 10.140.157.1 with SMTP id f1mr255972rve.299.1238724957695;
        Thu, 02 Apr 2009 19:15:57 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id f21sm1368100rvb.35.2009.04.02.19.15.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 19:15:56 -0700 (PDT)
In-Reply-To: <3C72F4A7-9B7A-44D0-B13D-FD534EB02C27@bitart.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115510>

On Apr 2, 2009, at 12:18 PM, Gerd Knops wrote:

> I think there should be a whitespace option that ignores lines that  
> consists completely of whitespace vs lines with actual trailing  
> whitespace preceded by non-whitespace.

+1

> The reason is that many editors (especially those supporting indent- 
> based code folding) keep 'empty' lines at the current indentation  
> level.

As do some users, out of personal preference.

Josh
