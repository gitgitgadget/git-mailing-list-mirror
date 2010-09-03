From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: svn to git help wanted
Date: Fri, 3 Sep 2010 16:54:33 -0500
Message-ID: <20100903215433.GB26018@burratino>
References: <AANLkTikVpHBn2e-rAxbb0a9XEsNCD8MizGVZr8HX8duU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Vaughan <tom@creativedigitalsys.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 23:56:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OreFI-00053r-T0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 23:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571Ab0ICV4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 17:56:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62338 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab0ICV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 17:56:23 -0400
Received: by vws3 with SMTP id 3so1662492vws.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1WaBAIJJvoHBnT22P3KA5Hu61kwThUA2zTc1EhBOiHQ=;
        b=gsWUlXDNS27vqVisjEs1KHhK8YPgxx5R5TpKZloMfGpZ4K1PI8iHtauwf0yS3rTS9a
         04knGZEQ4HMOkxISzWyW+fez+Tg4d97hhhmS06DJGiIljFCVNp41wTly1Yk0f0dOUWhH
         0RItcz3sCbaYkJfEbjNzvdobfHOdVoDMKE9Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oNuc5jIbiUzQRWkzlc4ApR1MZfihov4rXO9TDhlsI9VyeLgYFZCMawvPuoFxu6vqR3
         mxDYyaYay1vPPrd5DifvSqfxnrUTIwsHsGzAgvaS1Q6BQgsbfq2KgziB4dcAt9qCv1jt
         /fXElmCLe6jANvpRsaWgZv4CZocxVIDHMdcJ4=
Received: by 10.220.59.202 with SMTP id m10mr916941vch.48.1283550982471;
        Fri, 03 Sep 2010 14:56:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id s18sm44494vck.20.2010.09.03.14.56.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 14:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikVpHBn2e-rAxbb0a9XEsNCD8MizGVZr8HX8duU@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155276>

Hi Tom,

Tom Vaughan wrote:

> I have a Subversion repository with a checkered past
> that needs to be converted to Git.

Have you looked into git-svn, svn-fe, and git-filter-branch?

Of course the ideal tools[1] are yet to be made.

But still, this does not sound too bad after all. :)

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/149594/focus=150007
