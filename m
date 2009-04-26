From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: cygwin - clone on repo fails
Date: Sun, 26 Apr 2009 06:24:01 -0400
Message-ID: <81bfc67a0904260324x2e156097w9239349dda45062@mail.gmail.com>
References: <81bfc67a0904231636l53d3970cycd1ff1dc70c8568c@mail.gmail.com>
	 <be6fef0d0904250418h43749727t8979e9298187b47d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 12:29:36 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly1YI-0003Lh-L2
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZDZKYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZDZKYE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:24:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:30142 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZDZKYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:24:02 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1105587ywb.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xgogJzGxLu0NZQsQNLPUfLEDaAcF4u5XHRziM8I3KaU=;
        b=dQsMCUrod2oA/0XoEuy67m+pIBLRff61+FKRbbf5qzqP9cWF7DPriBAd60F9m1nS7z
         TU3gRpiVIwY2JiGdccM5CrKEix3KAZYafMtM+UyCYl8uPFt4P49HB1bglIXZ7ssYEfsT
         I9Ct/748qSN4Q+zehDNmSuRUOCWz91JAS3ob4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rHJa3zZHp07hWsybH6s9DNmYbjV62562igGpZnmr95+UhEECuh5pTZld2HRKFTm97j
         zSIsQ0rMqqnUVsMwwZZQQF9k57sw1V9RQMxfmMWExKqgAq8It4pSkN9fD8RIYR21QI3c
         BRoH+UpWSeIO/u8NmuB01aYDgarDlnp9T/1kE=
Received: by 10.100.133.2 with SMTP id g2mr6631229and.23.1240741441329; Sun, 
	26 Apr 2009 03:24:01 -0700 (PDT)
In-Reply-To: <be6fef0d0904250418h43749727t8979e9298187b47d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117584>

On Sat, Apr 25, 2009 at 7:18 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Could you check what version of git you have on cygwin (git --version)?
>
> You could also try cloning the repo over http:// instead of git://.

I think it's 1.6.1.2 .. using cygwin 1.7.0 beta  I'd have to double
check though... I'll try the other later, the unfortunate thing here
is that I really only use windows like once a week while I'm in
school. I suppose I can boot my windows part on my laptop later and
try to get it working.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
