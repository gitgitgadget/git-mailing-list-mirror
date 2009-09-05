From: Gabe McArthur <gabriel.mcarthur@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 18:29:54 -0700
Message-ID: <63CD88F1-B28B-42B8-A78B-485DB61487D7@gmail.com>
References: <585278.66341.qm@web27802.mail.ukl.yahoo.com> <658028.86274.qm@web27804.mail.ukl.yahoo.com> <524457d10909041647u562601d5q69142eefe894ac5b@mail.gmail.com> <ed88cb980909041706n26e50107m2343d4d922788459@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7A400)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Mark Struberg <struberg@yahoo.de>,
	Jonas Fonseca <jonas.fonseca@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjkDi-00086V-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 03:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934228AbZIEBh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934149AbZIEBh2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 21:37:28 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:40418 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146AbZIEBh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 21:37:28 -0400
Received: by pzk42 with SMTP id 42so1215692pzk.19
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=bFn5AeEo454mXCGbSg0aWJyn1C0H0J/esyqcfS8spnk=;
        b=dGRD3qX2EhIClCX/0LMG0+nOzI89uCS3tR07X9UcDwNlQytqPcJqU9Th55NqSOtdnj
         6UClBz8jgju437uMfKW+W9s57I7C70PnP/StzTAltmtosWlE5bUb1Q7s0svVM4wOQFPt
         g66/EJIkLqgV8bgburvYGsMMUFR/IgKvc+1lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=ALoKnsKxPhJBD6vGARFeCEEQrYttWVMHAdXoYIubLMvySjN3k/DhezTJBTyMEJOkgS
         Az3enHQtXCCq741P3n7gUAv0ljVtfufEMJT1bnP67R4GYX3RyxmwaDD4Rs7UbuvUT3aR
         oCdPGQW8WzLrdJS7JKeA6ZIkfkwuujYlAbrOU=
Received: by 10.114.55.31 with SMTP id d31mr10948644waa.98.1252114203278;
        Fri, 04 Sep 2009 18:30:03 -0700 (PDT)
Received: from ?10.25.189.190? ([166.205.135.166])
        by mx.google.com with ESMTPS id 22sm834799pxi.10.2009.09.04.18.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 18:30:02 -0700 (PDT)
In-Reply-To: <ed88cb980909041706n26e50107m2343d4d922788459@mail.gmail.com>
X-Mailer: iPhone Mail (7A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127775>

I'll post the pull request to github within  3-4 hours. Is that what  
you mean by invest?  My patch will contain everything I submitted  
before plus a bit more.  That patch set should contain everything  
necessary to build, plus any refinements to whatever is already in the  
'mavenize' branch.
-Gabe


On Sep 4, 2009, at 5:06 PM, Douglas Campos <douglas@theros.info> wrote:

>> Ok, I'll fork and send a patch request shortly.  I was thinking about
>> it earlier, and I may add a couple of features that all OS projects
>> should follow (e.g. License in the jar, etc.).
>
> Gabe, is there some task that you want to share with me? I have a
> short timeframe of 4hours to invest on mavenization.
>
> Cheers
> Douglas Campos (qmx)
