From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-show ignores --pretty
Date: Tue, 16 Jan 2007 11:14:05 +0000
Message-ID: <200701161114.07073.andyparkins@gmail.com>
References: <200701161058.15725.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 12:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mGe-0005uv-8K
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbXAPLON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXAPLON
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:14:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:17246 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXAPLOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:14:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1639091uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 03:14:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZBvuYnwwbR81OLNtUQWIzoHq+/wPPMnrhaFgfsM0arscSbH6DTs+LBgEYwyfXJDai/5RIjkQspALCciyGGFf/3ZqZM8ZSsypHnRuQ4Bk3jdiupY88I96v8S9IoOWrL5rWAIgnYMQ6j2M1yRPK9v+cLyugL+UuzZ5osLCi5TdISI=
Received: by 10.66.255.7 with SMTP id c7mr7211188ugi.1168946051005;
        Tue, 16 Jan 2007 03:14:11 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 20sm6862010uga.2007.01.16.03.14.10;
        Tue, 16 Jan 2007 03:14:10 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200701161058.15725.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36928>

On Tuesday 2007 January 16 10:58, Andy Parkins wrote:

> $ git --version
> git version 1.5.0.rc1.gf4b6c
>
> Running git-show with a --pretty format is no different from without
> a --pretty.
>
> Doesn't seem to matter what format you pick, you always get medium/full.

Correction: I think I'm going blind.

You always get the diff, which could well be intended.  Is that the case?  If 
it is, is there a way to surpress the diff?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
