From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 11:08:32 +0400
Message-ID: <20080415070832.GC10300@dpotapov.dyndns.org>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com> <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com> <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com> <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com> <pan.2008.04.14.20.39.10@progsoc.org> <20080414213339.GB10300@dpotapov.dyndns.org> <pan.2008.04.15.03.25.00@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 09:09:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlfIG-0002Qa-T4
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 09:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763AbYDOHIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 03:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbYDOHIj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 03:08:39 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:58681 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbYDOHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 03:08:38 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1120950mue.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=CUJWjeOS/OHAATD2DbcZ/6bPMfttpWEd8YkJWexvtbI=;
        b=C6zwPF5VlZMEUfasyl1H4CxSEGC2c9NX2fAiqI7JVAsytBgQ//MDDBiUaWbFlfOB4xOAjQuwj34Jh+OaR+MYRzxjjVrU54xzfIK2bskX4wq8OQ1Yu0wJ7Pnj9qp59AuJxOIlvSxR6haXD98xI1Uq1hmWWWXwtbdTsonPApcQmw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LBx+6yLwzVqXEYVqDfFPZOh7trvuq/e8/oaHY30CEjWby2QjbNyqCb2l2Qt+VOe3bvOicju1v1eujURTVdOuvio5uQyv4Ns9LOokYC+o62bS9fWLRvf0tM8RZ0UO7w/rik45AN9CsU3CF2cDdkhH4UTsdv+GICVNer8SWbZpk1Y=
Received: by 10.78.29.6 with SMTP id c6mr5201792huc.48.1208243316642;
        Tue, 15 Apr 2008 00:08:36 -0700 (PDT)
Received: from localhost ( [83.237.185.245])
        by mx.google.com with ESMTPS id k10sm10841131nfh.17.2008.04.15.00.08.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 00:08:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <pan.2008.04.15.03.25.00@progsoc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79573>

On Tue, Apr 15, 2008 at 03:24:50AM +0000, Anand Kumria wrote:
> On Tue, 15 Apr 2008 01:33:39 +0400, Dmitry Potapov wrote:
> 
> > On Mon, Apr 14, 2008 at 08:39:00PM +0000, Anand Kumria wrote:
> >> 
> >> That is basically the current "Web 2.0 style".
> >> 
> >> <http://www.webdesignfromscratch.com/current-style.cfm>
> >> 
> >> One of the "hotties" is a software project, and Free Software at that.
> >> 
> >> I think the designs are a good first starting point.
> > 
> > And here is what validator.w3.org says about this page:
> 
> I'm sure you had some useful information to add, but it hasn't come 
> across. 

I would never call a page with more than 83 problems as a good starting
point, but I am sure for someone who alleges to make the best web
design, it should not be too difficult to correct that.

BTW, "Web 2.0" does not refer to any specific visual design but implies
semantically valid XHTML and HTML markup among other things.  So, I am
not quite sure what you meant by saying "Web 2.0 style".


Dmitry
