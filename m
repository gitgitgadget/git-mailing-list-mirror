From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 2/2] Remove dead code after direct graph drawing
Date: Fri, 20 Oct 2006 13:49:17 +0200
Message-ID: <e5bfff550610200449j245f9014r984b8372fcd602d0@mail.gmail.com>
References: <200610191613.19142.Josef.Weidendorfer@gmx.de>
	 <200610200111.26259.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 13:49:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GassM-0006vf-5U
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 13:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946374AbWJTLtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 07:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946376AbWJTLtS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 07:49:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:21406 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1946374AbWJTLtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 07:49:18 -0400
Received: by nz-out-0102.google.com with SMTP id z3so360065nzf
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 04:49:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPW/XhiRJqO8GkcpeTlPsXToNnrN+g3hGboXvy+RpkratwM8uJloePP0jcJvKV2i4WI02JtIeiw2fRfyQyO0mX/oi1ZCsbqSkK54GP29y1ggjZyFNqMYxQRgle7psL6hrzLSKmVe9OBk7uzvBn9EkBgfBaliISAbqKaqTLbfO1Y=
Received: by 10.35.102.18 with SMTP id e18mr443807pym;
        Fri, 20 Oct 2006 04:49:17 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Fri, 20 Oct 2006 04:49:17 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610200111.26259.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29452>

On 10/20/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Thursday 19 October 2006 16:13, Josef Weidendorfer wrote:
> > Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
>
> Hmmm...
>
> Is the git mailing list the right place for qgit patches?

Yes, I don't see other competitors ;-)

> Probably, I should have prefixed them with "qgit:" ...
>

No problem, I should found them anyway and I don't need to manually
remove "qgit" prefix before to apply to repository.
