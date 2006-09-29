From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 22:42:05 +0200
Message-ID: <200609292242.05347.jnareb@gmail.com>
References: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 22:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTPBH-0005t6-ES
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 22:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWI2Ul4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWI2Ul4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 16:41:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:8250 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422821AbWI2Ulz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 16:41:55 -0400
Received: by ug-out-1314.google.com with SMTP id o38so314386ugd
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 13:41:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ClBscDElhgynySDOLGCrQ04w/B711D3xgajGxpIi4nUixblDmtl7Ttp5q0hUe9Ntu1oTvK0/3RqXXXeRYJlrlNRyrsAfpO7wBGB1LAsbcOyKBKi3B3+xmCDHD9RjlkRTDTDYtWb4KrCKR2eYHbji/5kGX6xvu6WrBEBMZDwm/x0=
Received: by 10.67.101.8 with SMTP id d8mr2823682ugm;
        Fri, 29 Sep 2006 13:41:53 -0700 (PDT)
Received: from host-81-190-23-206.torun.mm.pl ( [81.190.23.206])
        by mx.gmail.com with ESMTP id 53sm2130650ugd.2006.09.29.13.41.52;
        Fri, 29 Sep 2006 13:41:53 -0700 (PDT)
To: Matthew L Foster <mfoster167@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28128>

Matthew L. Foster wrote:
> If the local merge time information is already available in the
> ref-log then gitweb.cgi might only need to be made aware of it. 

It is planned to add reflog support (view) to gitweb.

But of course the repository that is under gitweb has to have reflog 
_enabled_ to be able to view it.
-- 
Jakub Narebski
Poland
