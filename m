From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH][gitweb] Make it possible to retrieve HEAD plain blob
Date: Tue, 06 Jun 2006 23:20:05 +0200
Organization: At home
Message-ID: <e64rhu$i7n$1@sea.gmane.org>
References: <20060606205737.GX10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 06 23:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FniyO-00007s-It
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFFVUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWFFVUU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:20:20 -0400
Received: from main.gmane.org ([80.91.229.2]:16291 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751096AbWFFVUT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 17:20:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FniyB-00005T-7M
	for git@vger.kernel.org; Tue, 06 Jun 2006 23:20:11 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 23:20:11 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 23:20:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21401>

Petr Baudis wrote:

> Sometimes, it is useful to be able to link directly to the blob plain
> version in the latest tree. This patch implements that.

By the way, how to download binary file, like for example image, via gitweb?
blob_plain doesn't give correct file after Save As (in the case of image,
it is not recognized as such)...

-- 
Jakub Narebski
Warsaw, Poland
