From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 12:43:09 -0700
Message-ID: <m2k6829e0i.fsf@ziti.fhcrc.org>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
	<93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
	<20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
	<7vejyayq46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 31 21:43:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWb4-0003zK-SY
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWEaTnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWEaTnL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:43:11 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:10933 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965127AbWEaTnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:43:10 -0400
Received: by wx-out-0102.google.com with SMTP id i29so74659wxd
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:43:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=gr57kr7yNfIjRBu03N0yKizjdijLisqKGBMSixp5j/iziJDU2Sxl2BvltZgZHXA6fZnVDhWl2ltAevnE2gbilDKptEaCacjg8P5XjRcvSwrs2lXMo8auzi5KMnzYx6F6jxPzJLmiglvHHjvXYonIkuoeYKPEM1TUCR7KzuKxRnU=
Received: by 10.70.6.19 with SMTP id 19mr631508wxf;
        Wed, 31 May 2006 12:43:10 -0700 (PDT)
Received: from ziti.fhcrc.org ( [140.107.156.111])
        by mx.gmail.com with ESMTP id h9sm424028wxd.2006.05.31.12.43.09;
        Wed, 31 May 2006 12:43:10 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <7vejyayq46.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 31 May 2006 12:02:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21086>

Junio C Hamano <junkio@cox.net> writes:

> Seth Falcon <sethfalcon@gmail.com> writes:
>> When should one commit _without_ signoff?  
>
> Please, calm down and read Documentation/SubmittingPatches,
> item (6), to understand what sign-off means.  It does not have
> anything to do with the result of the commit "working".  I do
> not use -s when making commits during my day-job, for example.

Doh!  In glancing through the Documentation dir I missed the
SubmittingPatches file. [weak excuse: there are many doc files in that
dir and most are for the commands themselves.  I expected this to be
in howto/.]

Anyhow, much calmer now (apologies if I sounded un-calm, that wasn't
my intention).  The SubmittingPatches doc was _exactly_ what I was
looking for when I posted my original question [*].  My bad for not
finding it when it was staring me in the face.  Thanks for bearing
with me and pointing me to the fine manual :-)



[*] http://marc.theaimsgroup.com/?l=git&m=114884854119660&w=2
