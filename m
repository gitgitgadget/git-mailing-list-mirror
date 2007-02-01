From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 16:28:09 +0100
Message-ID: <46d6db660702010728x68457809o37967f322d49933b@mail.gmail.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
	 <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <45C14563.8060707@verizon.net>
	 <Pine.LNX.4.63.0702011016430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <epsrj3$gh8$1@sea.gmane.org>
	 <Pine.LNX.4.63.0702011503230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <epsviu$j4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Levedahl" <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 16:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdrE-0005vR-JP
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 16:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXBAP2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 10:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbXBAP2N
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 10:28:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:48299 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXBAP2K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 10:28:10 -0500
Received: by nz-out-0506.google.com with SMTP id s1so545298nze
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 07:28:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f8NxcyKDuTpHNpeLOlelPyOsTtPB7TblVvFsYJmnwGI2bcpWYzOu79NxR8GbP+rQiN9I4q2a/Qrs4+avHR7aPaUax7ax9Db1Q1OiMgnoULneioTz7zF9IXdfwhj/LsuYqaC+YWeMNlkJd796uAo5QBYIgFpF1Fe1cR67M5AR/5k=
Received: by 10.114.133.1 with SMTP id g1mr137899wad.1170343689685;
        Thu, 01 Feb 2007 07:28:09 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Thu, 1 Feb 2007 07:28:09 -0800 (PST)
In-Reply-To: <epsviu$j4$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38363>

On 2/1/07, Mark Levedahl <mdl123@verizon.net> wrote:
> Maybe this works better?
>

yes. thanks: it helps on msys/mingw.

-- 
Christian
