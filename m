From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deleting of the specified ref during the post-receive hook
Date: Tue, 21 Sep 2010 09:00:24 -0700
Message-ID: <20100921160024.GI32601@spearce.org>
References: <4C98C3F2.9050006@workspacewhiz.com> <20100921145014.GH32601@spearce.org> <4C98D558.9090900@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 18:00:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy5Gn-0005jj-KO
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 18:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665Ab0IUQA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 12:00:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65530 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562Ab0IUQA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 12:00:27 -0400
Received: by gwj17 with SMTP id 17so1679224gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 09:00:26 -0700 (PDT)
Received: by 10.100.211.20 with SMTP id j20mr11322400ang.239.1285084826664;
        Tue, 21 Sep 2010 09:00:26 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id r3sm9271010ibk.7.2010.09.21.09.00.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 09:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C98D558.9090900@workspacewhiz.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156731>

Joshua Jensen <jjensen@workspacewhiz.com> wrote:
> Let's ignore the review+submit portion of Gerrit now.  Can Gerrit be  
> coaxed to take a refs/for/master and directly apply it to the master  
> branch WITHOUT the review cycle?  If so, then I'm wasting my time trying  
> to right a script.

Nope.  But only because nobody has proposed doing that before.
Its not impossible to do...

-- 
Shawn.
