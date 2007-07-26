From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 09:14:46 +0100
Message-ID: <200707260914.48042.andyparkins@gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <Pine.LNX.4.64.0707260629260.14781@racer.site> <87eacd830707252308t32c98108w39b52cdb9c61cd1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Henning Rogge" <hrogge@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 10:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDyUt-0005Yo-SO
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbXGZIO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 04:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXGZIOz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 04:14:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:1113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbXGZIOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 04:14:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so493918ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 01:14:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dAjTVp8WdMUoxozXU7E53/OwjqEiDPbM17gaNLtQAkfUethPxhtivkvZ1Pr82nTSoyt183CB+RrkRJPWDFott7kMye3dxq1DZS7yZO/x3ivu7W80rQKbwnRiPlcuRhLjYtTHZVxt8poXO2SIoN1OsUplIkhOUU9MBzS8a1lstqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sWiUQeujA1NWRjW5YSssiS/8tjV28m5lqgvuE/ltKUyO1SCWs9nMGZTpAYGJm9nCI+ojkNurXAmVAUUbR1vFNRlCl3IaRv3TeTRVVBvBW+UXWHUpxd/DcUCre2i29pO1h8WSKbuf3lU8ueck7SO2rprZrKfPA0qLm3Knj8ig/XE=
Received: by 10.67.10.12 with SMTP id n12mr1993299ugi.1185437692135;
        Thu, 26 Jul 2007 01:14:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b36sm3151372ika.2007.07.26.01.14.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2007 01:14:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <87eacd830707252308t32c98108w39b52cdb9c61cd1e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53805>

On Thursday 2007 July 26, Henning Rogge wrote:

> QGit might be a good alternative too, especially because QT4 is
> available for Windows.

I have a colleague using qgit4 on Windows with git on cygwin.  Works very 
well; and qgit being native rather than tcl/tk+cygwin makes it a lot faster.

I've also seen him using gitweb for browsing around my repository.

We've never lost data, and have had significantly more success using git 
itself rather than git-cvsserver, which was a constant struggle.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
