From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 16:51:49 -0500
Message-ID: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com>
References: <200802210429.58353.lenb@kernel.org>
	 <200802210721.29188.lenb@kernel.org>
	 <20080221205104.GA14247@informatik.uni-freiburg.de>
	 <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
	 <76718490802211341o1ddc36bbne4e6d551712e7cd0@mail.gmail.com>
	 <20080221214959.GA4338@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>,
	"Len Brown" <lenb@kernel.org>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJLF-0003tn-NV
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbYBUVvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbYBUVvz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:51:55 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:54840 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765805AbYBUVvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:51:53 -0500
Received: by el-out-1112.google.com with SMTP id v27so183400ele.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Zro1+xXo9z4mqPF27KdS1SdiUsNOwiVaAhkx9gkmpVc=;
        b=WC4eJhlfGFbJ9VrUh4AX2pfh4M2EtS1AZLQfi7DolWJxDoMYFtB8XrEKNMCLCC25XmFhf21thTd+9pV+Z/YJIB3R4rblU+1OTWvkN1rod9L0n8SAVsBWjGKB0j/PzYdT1Bg0Xe0r1PZY9F2KieiweC2N20EKBum0QSjRw64Omro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QX0cCrzFfOYTj7heS07ZbKM5+xQWlsG0TrSbOSwL8m8dwczk6MNM8eq4KozQqhOB/ek/EwKmF+g9J5f15n0xHoaqJ/zUYFDbOG0EsE/IFhv3hDFe8xshGLrl+a3ZQWvNlfWr21NvEEKecy9X5fQ8CXUL1vAnv21OUuS+dcKY+hA=
Received: by 10.114.170.1 with SMTP id s1mr7605773wae.54.1203630709307;
        Thu, 21 Feb 2008 13:51:49 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Thu, 21 Feb 2008 13:51:49 -0800 (PST)
In-Reply-To: <20080221214959.GA4338@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74667>

On Thu, Feb 21, 2008 at 4:49 PM, Mike Hommey <mh@glandium.org> wrote:
>  And reminds me something ;)
>  http://kerneltrap.org/mailarchive/git/2007/12/11/488177

Okay, I'll contribute a patch with a test case since I broke it (this time...).

j.
