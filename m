From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 14:12:28 +0700
Message-ID: <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Christian MICHON" <christian.michon@gmail.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 08:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9cJ7-00064S-WC
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 08:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbXAXHMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 02:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965480AbXAXHMb
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 02:12:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:32164 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965461AbXAXHMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 02:12:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so89316uga
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 23:12:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r+jC4PG+VYSRLBRO+vh4Da//AsMCm/w6w9qbO6lzVHmj42Qhqgl7qbYipWrHPRZOVPKNsYGyJK6NyMnKPXfOEk/wIr7RweeKsQNNw21G+JV40jDnrWVKGVX09bBqKNJBd51JivkyGfHy6eb3CRiwy+y5wRZ2MP7qDMJ8zjP0rY4=
Received: by 10.78.200.3 with SMTP id x3mr303185huf.1169622748838;
        Tue, 23 Jan 2007 23:12:28 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 23 Jan 2007 23:12:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37611>

On 1/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Actually, I have been seriously wondering if there is some setup under
> Wine that I could run, just so that I'd see the Windows development
> environment for git.
>
> Has anybody tried anything like that?

At least I can say that wine 0.9.27 can run git.exe, git-log.exe,
git-diff.exe. I have not tested others yet. git binaries were cross
compiled from Linux.
-- 
Duy
