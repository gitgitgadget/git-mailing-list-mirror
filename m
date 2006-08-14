From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 22:33:38 +0200
Organization: At home
Message-ID: <ebqmlk$npt$1@sea.gmane.org>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 22:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj7y-0000aN-8w
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWHNUdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWHNUdf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:33:35 -0400
Received: from main.gmane.org ([80.91.229.2]:53993 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932729AbWHNUde (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 16:33:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCj7X-0000UA-96
	for git@vger.kernel.org; Mon, 14 Aug 2006 22:33:11 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 22:33:11 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 22:33:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25397>

David Rientjes wrote:

> This patch series cleans up a number of static function returns that are either 
> meaningless or could be more efficiently written.

Could you please make description of patch series email to be parent
(ancestor) of all patches emails, i.e. for patches either to be 
chain-replied to introduction email, or all be replies to introduction
email.

It makes for easier reading/viewing/applying/ignoring the series.

Thanks in advance
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
