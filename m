From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problems with git-svnimport
Date: Fri, 8 Jun 2007 22:56:21 +1200
Message-ID: <46a038f90706080356q65351fa7y5087cda9d0c71aa0@mail.gmail.com>
References: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: plexq@plexq.com
X-From: git-owner@vger.kernel.org Fri Jun 08 12:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwc8r-0005j2-R8
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937670AbXFHK4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937699AbXFHK4X
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:56:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:36844 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937670AbXFHK4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 06:56:22 -0400
Received: by wx-out-0506.google.com with SMTP id t15so691648wxc
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 03:56:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/RSXY1LJ9J5H2YHVOWT5lwCVxyXeZDxIxtSoHTO0GLtaR2Xgo1pBwpw6eGzHfx6/wqLGTKJoujS3ii/qRWTB4wEpFo2wD/vetDlAzU58KulosmgGAOB79dhrYqrX3WSGsE9TA5XEOvQHTdZbI/GrJJIk7486EAjQX07HelwMV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aiJsR4dKdXi2JtE81q2ADm+fzq5lkZxLFcQ3fYJZZIo/JYciCesl3/JvkgYvKiVlKB5ArHSxug/iq5OtKBDtrLKh904LUXEsPOW7abkMpuY3E7O4a/1h1Da1mo/4nzCEfKOkNh4ICydQzfLI7Kxy6QpRt1Eg+7xfXM33Er5wsQU=
Received: by 10.90.113.18 with SMTP id l18mr2700897agc.1181300181744;
        Fri, 08 Jun 2007 03:56:21 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Fri, 8 Jun 2007 03:56:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49460>

On 6/8/07, Alex R.M. Turner <aturner@plexq.com> wrote:
> Is this expected, or should I be worried?

It means that  you need to play a bit with your import settings. It
usually takes me a few tried to get the right trunk, tags and branches
parameter for each repo. SVN's layout is a bit too flexible and
doesn't make this easy to figure out.

cheers,


martin
