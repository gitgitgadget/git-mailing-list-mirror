From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 00:59:27 +0200
Message-ID: <200610180059.27799.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:59:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxtk-0001Rb-3A
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWJQW65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWJQW65
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:58:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9527 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751004AbWJQW64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:58:56 -0400
Received: by ug-out-1314.google.com with SMTP id o38so65720ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 15:58:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ERUK4VgV0GdHxmw63cyD4b7XlfWHiIM3YLt/qrAu+4XwwofzchbHul6kR0cxJlZFEXcGWV5YEiTonMSLzB4xtUZIMEtJrcUrARakpkcZPhpI+7UPZimJztl7wd+4QfaV/rVsIoLEPZabHk+WD57Y+rBZo7QZw2wh43Xkhm6pEuA=
Received: by 10.66.221.19 with SMTP id t19mr10721335ugg;
        Tue, 17 Oct 2006 15:58:55 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id j33sm218837ugc.2006.10.17.15.58.54;
        Tue, 17 Oct 2006 15:58:54 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <200610180057.25411.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29131>

Jakub Narebski wrote:

> Git has read-only access over git:// protocol (served by git-daemon on
> port 9418), read-write access over git+ssh:// protocol (you can limit
> exposition using git-shell), read-only access via HTTP, HTTPS, FTP "dumb"
> protocols, read-write access via WebDAV "dumb" protocol.

And deprecated read-only (I think), deprecated, suggested to use only
for cloning, rsync:// "dumb" protocol.
-- 
Jakub Narebski
Poland
