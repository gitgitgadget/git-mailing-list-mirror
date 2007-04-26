From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 13:56:52 +0200
Message-ID: <e5bfff550704260456r36bd7e0p8c4b18b1050ceb86@mail.gmail.com>
References: <200704261238.51234.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 13:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh2an-0005vM-FY
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 13:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031176AbXDZL4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 07:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031181AbXDZL4y
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 07:56:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:42792 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031176AbXDZL4x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 07:56:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so691797nzf
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 04:56:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S7hlH3oZUGT1X5nl5iw+IuOieVKe6DcE4997ugk3exuFhwy65h8Vt2m9ucTqNQMCHgzGj3MpB8JABo2RDIGqe4ZHzTgtjGV6Zmeb1HS//+5M/OXDdhShQs7FkVSdygtJM+iI02RyJmOHmXncuSNzFAm/dAuvzGrRdNLj9L/Y9rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cRu0yc58Mggzlg+ljCSpCaD9V7nGe+W30Ylp7KEjpLQIfHs9V576o9Xw8jFSXHmjCEU0NC4s81HOzSKCiQY7/NGP3A3yeSvg31Rv+5rxK3bUlBb94M6WStBF1n4+myOaiWdcdGsKWlaVA412fVIAkYucxMbvvZ1zWwgQRT6AbaY=
Received: by 10.114.199.1 with SMTP id w1mr542914waf.1177588612953;
        Thu, 26 Apr 2007 04:56:52 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Thu, 26 Apr 2007 04:56:52 -0700 (PDT)
In-Reply-To: <200704261238.51234.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45630>

On 4/26/07, Andy Parkins <andyparkins@gmail.com> wrote:
> Hello,
>
>
> I'll report further as I come across any stumbling blocks; but here is one to
> get you going: (It's not a problem with git really, and the workaround is
> simple, I'm reporting it for your information rather than to get it fixed).
>

Hi Andy,

because submodules are a new feature I would not be surprised if some
small correction is needed in qgit code to correctly handle that.

  In case you use qgit I would appreciate very much any bug report
regarding this new submodules thing.

I still didn't test submodules compatibility myself, but in case of a
bug report against qgit probably I will be forced to do ;-)

Thanks
Marco
