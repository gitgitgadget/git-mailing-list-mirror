From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit4 segfault
Date: Fri, 16 Feb 2007 19:32:36 +0100
Message-ID: <e5bfff550702161032iedc6474t7afbbe9089cbbcaf@mail.gmail.com>
References: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 19:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI7sx-0006g8-Ax
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 19:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946201AbXBPSck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 13:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946204AbXBPSck
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 13:32:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:31665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946201AbXBPScj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 13:32:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so233291uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 10:32:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UrgHtravqJxrDifX+auLAHjhpb0aoyhRL0WfOLOz52ByuccbA5Iff2td1zO7/UC1wnTRMuBn7g/Sh7x38pSMukPYlfZlLEyQLV5C6C4FJ0vmefSLrdF3peaSYi1ortoeERORnkes7UYuw0x6f9lfaIqtfa6xeTMhdCzRsdHEL1M=
Received: by 10.114.126.1 with SMTP id y1mr2058029wac.1171650756647;
        Fri, 16 Feb 2007 10:32:36 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 16 Feb 2007 10:32:36 -0800 (PST)
In-Reply-To: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39937>

On 2/15/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> on a linux-2.6 repo it fails during exit
>
> Done.
> QProcess: Destroyed while process is still running.
> Segmentation fault (core dumped)

I had a similar problem with qhit4 under Windows (where it should be
fixed now), never under Linux.

Do you have the same problem also with stable qgit 1.5.4
(git://git.kernel.org/pub/scm/qgit/qgit.git) or only with new qgit4
(git://repo.or.cz/qgit4.git) ?

Marco
