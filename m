From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 08:59:46 +0100
Message-ID: <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
	 <20070129223513.GA31372@spearce.org>
	 <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
	 <20070129232425.GB31372@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 08:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnuB-0001ES-Ji
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbXA3H7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965443AbXA3H7s
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:59:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:31000 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441AbXA3H7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:59:47 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1150790wra
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:59:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Il2PZtGQWXrMra2Y8kJLTjDnPczXvXmQHKmygwvmExx/KTMx5D+yA9C3PVCMRLVmoX7Dkr2xaD7tAttGMRqxEV4CZN+nVtIP2MO5quWMqSVPEEGjjvtd4l8Yw1Y4zV33jurRzTF9wCUypNwDfHh++k6phCmkJNOmuPkQoqw6YRM=
Received: by 10.114.185.8 with SMTP id i8mr15280waf.1170143986480;
        Mon, 29 Jan 2007 23:59:46 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Mon, 29 Jan 2007 23:59:46 -0800 (PST)
In-Reply-To: <20070129232425.GB31372@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38133>

On 1/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Try creating a desktop icon (Repository->Create Desktop Icon) and
> start git-gui from the resulting .bat file.  It *should* come up
> right on MinGW, but I'm only guessing here.

ok, yes it's working. :)
but call gitk from inside it fail :(

"error in startup script"
( git-peek-remote is not working from git-gui, could be path related.
It's hard to tell why yet)

-- 
Christian
