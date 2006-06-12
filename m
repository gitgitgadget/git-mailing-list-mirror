From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Collecting cvsps patches
Date: Mon, 12 Jun 2006 11:27:37 +0000 (UTC)
Message-ID: <e6jj39$6ua$1@sea.gmane.org>
References: <20060611122746.GB7766@nowhere.earth>
	<46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com>
	<20060611224205.GF1297@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jun 12 13:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpkaw-0006mw-9N
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 13:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWFLL2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 07:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWFLL2b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 07:28:31 -0400
Received: from main.gmane.org ([80.91.229.2]:24003 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751882AbWFLL2b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 07:28:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fpkao-0006lE-IZ
	for git@vger.kernel.org; Mon, 12 Jun 2006 13:28:26 +0200
Received: from mail.globalcapital.cc ([80.85.66.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 13:28:26 +0200
Received: from wildfire by mail.globalcapital.cc with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 13:28:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.globalcapital.cc
User-Agent: pan 0.98 ("The plain old chaos of undifferentiated weirdness.")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21701>

On Mon, 12 Jun 2006 00:42:05 +0200, Yann Dirson wrote:

> http://ydirson.free.fr/soft/git/cvsps.git

I think you need to chmod +x hooks/post-update

and then run 'git-update-server-info'.

Cheers,
Anand
