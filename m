From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of,
 $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 14:54:00 -0500
Message-ID: <535425d891e41_6b186d130cc5@nysa.notmuch>
References: <53076DFC.1000602@gmail.com>
 <53499bb02c140_285f9032ec58@nysa.notmuch>
 <CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
 <53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
 <CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Delcypher <delcypher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 22:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbxyU-0006tM-As
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbaDTUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 16:04:23 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:43262 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbaDTUEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 16:04:21 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so2824346ykq.7
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=LCoQ6SPP4ehKXgVIdFQiIzU2rTIP+u7RdiKA4rXZ/TA=;
        b=ue6khtKvJZkNkkCuzlhLGPb3Z3QZz8EAKVxuB15e3stGO6UE/JFW1OVHmbcryxdgw5
         6hi7tUBoitQDfmq+E4fREO4/O4HtQOtaEbRiQjjkWyMJoLGWNk7hHMTcSjncwIXTj7ye
         1YNeiiQhcsmM/jRE2heqzOFZOamJXxtgo3K3dNcW0TpRhnO573WLHSlb1N7WCVCJd7Hs
         PJ2xYsQTav+s5qKPx3N2FwE61KP6RoH5MtHUeexx/Sii607oieviIzaX5DnJNyRGNWvN
         id1EdiWDlyICIiyf1CA4R/GBcWCNvXHdpN4VeR1Yz8mwKChEnALXAhKfpWAYyMtXJoeH
         AoWw==
X-Received: by 10.236.139.70 with SMTP id b46mr19384561yhj.63.1398024260954;
        Sun, 20 Apr 2014 13:04:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t63sm65605472yhm.32.2014.04.20.13.04.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 13:04:20 -0700 (PDT)
In-Reply-To: <CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246578>

Delcypher wrote:
> > What version of Mercurial are you using?
> 
> $ hg --version
> 
> Mercurial Distributed SCM (version 2.9.2)

Same as me. And which version of git-remote-hg are you using?

-- 
Felipe Contreras
