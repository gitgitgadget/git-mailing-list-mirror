From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Tue, 3 Feb 2009 21:57:50 +0100
Message-ID: <200902032157.51839.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com> <20090202202424.GG14762@mit.edu> <20090202203514.GA26691@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUSMg-0004j1-B8
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 21:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZBCU6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 15:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZBCU6A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 15:58:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:17811 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZBCU57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 15:57:59 -0500
Received: by ug-out-1314.google.com with SMTP id 39so51151ugf.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=spjTxQTQTv09SlQOVOlcGogf4s5vJU/u342KyQo5rxg=;
        b=QzgVcHu2t4fHeeUxUOCQXufoohGJnC/4AcVNSMi+SQhZ5V935WMI9jHmoMAr4g+qu+
         ytZ6QZFpeqasDigpmMH42F2IyiuWCzS+VivJGFWYzHjJ0CVCimRjQsq1aNwfOLM1HZ2Y
         +K7NV7k8QZNaeUQcCoqr5QeuLsfGNLOTKfu2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZdWNEKk59FpU9naYwB32q2v7vDsyUN/ymk05yvQzBkVpeGxjm+5DObfp1KUtl+BnWP
         P3jtvwKyrcQXSQk9i7CJ2Vo/mJmL201Cvu+h95EiZT6GsxgoryspKFOk+Qqi7oFTp7XK
         VGxl10fiWX+PZtYnKjWs93itZrmxZHiYsb6qw=
Received: by 10.86.93.19 with SMTP id q19mr1919608fgb.62.1233694676249;
        Tue, 03 Feb 2009 12:57:56 -0800 (PST)
Received: from ?192.168.1.13? (abvf78.neoplus.adsl.tpnet.pl [83.8.203.78])
        by mx.google.com with ESMTPS id l19sm5569011fgb.47.2009.02.03.12.57.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 12:57:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090202203514.GA26691@thyrsus.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108251>

On Mon, 2 Jan 2009, Eric S. Raymond <esr@thyrsus.com> wrote:
> Theodore Tso <tytso@MIT.EDU>:

> > Unfortunately, it looks like Eric has taken down his mailman instance
> > on thyrsus.com.  I have personal archives of the list, and the list
> > used to be have public archives, so I don't feel any hesitation
> > sharing it with interested parties.
> 
> Oops!  I think it got lost during a system upgrade.  I should be able 
> to restore it and the archives, now you've reminded me.

By the way, Mercurial repository of "Understanding Version Control"
sources doesn't work either: http://thyrsus.com/hg/uvc returns
404 Not Found error.

What is strange is that http://thyrsus.com works...

-- 
Jakub Narebski
Poland
