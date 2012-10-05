From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Fri, 5 Oct 2012 15:46:33 +0200
Message-ID: <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 15:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK8FL-0007Il-7A
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 15:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab2JENrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 09:47:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60932 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2JENrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 09:47:06 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3787131iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=55f4SKVgXfXcsY4DeeDr5+rnlCiHQSx30RgXL7YR5GA=;
        b=y/rRxSTBYXTEU3Ll82d8q+LIX5Vw8r2GtVdGECIpIcGdw9XyP1nESOLdA7vA334pJX
         FuZlpO64UTomKtzWp+Bgr2FCF2ES/iElB62bNAAZXtsxxrMUsIRMbIw6bEvA0J3ohib6
         TfA3EJGgctRB+o8aPUHmAGuHI6rO88fiUKXoBYTGZhugFko1FC1CJV+HzBcm4epAf4hI
         6aVD/jd/TL8/X4p2oAb7IL9h79ylUP0EBdXQQF4M3TT+FOq9aMbAla1hnP2Wuvz2Hm7E
         J36G1J+06LeewzKdmoT7vkBWkzzFwxP73STxqCiAjtiTo9KM4qiWBAKnakRCzCzTTmuP
         R/mQ==
Received: by 10.42.61.196 with SMTP id v4mr7129835ich.24.1349444823927; Fri,
 05 Oct 2012 06:47:03 -0700 (PDT)
Received: by 10.50.46.198 with HTTP; Fri, 5 Oct 2012 06:46:33 -0700 (PDT)
In-Reply-To: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207106>

> On the git-users mailing list we're trying someone to help with
> running `git push` over FTP.  That person is runnig Git 1.7.9.5
> on Ubuntu 12.04.

I don't think vanilla git supports pushing over ftp.

There are plugins like https://github.com/resmo/git-ftp tho.

Philippe
