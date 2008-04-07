From: Luke Diamand <luke@diamand.org>
Subject: Re: git repo being corrupted?
Date: Mon, 07 Apr 2008 12:21:40 +0100
Message-ID: <47FA03C4.9030104@diamand.org>
References: <47F9F1A1.30009@diamand.org> <20080407111740.GA12776@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@lsd.di.uminho.pt>
X-From: git-owner@vger.kernel.org Mon Apr 07 13:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JipQx-0000qe-DM
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 13:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYDGLVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 07:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYDGLVq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 07:21:46 -0400
Received: from manchester.eukhost.com ([92.48.75.3]:29284 "EHLO
	manchester.eukhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYDGLVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 07:21:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=diamand.org;
	h=Received:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse;
	b=FCJYnVpwctAm+5Wurw5W0bVz+phXUC0fgEspRsdV2RvjyfjRYy2D30iFK6PugsCiozTqtMZZ2a4c/YABSjhJc4SR5FdRzl5oRLmdS1+uA3ISg3HODpp+Zd1+6CSA0j73;
Received: from cpc2-cmbg6-0-0-cust826.cmbg.cable.ntl.com ([81.107.35.59]:43524 helo=ethel.local.diamand.org)
	by manchester.eukhost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <luke@diamand.org>)
	id 1JipPz-0002Gn-2r; Mon, 07 Apr 2008 11:21:43 +0000
Received: from localhost ([127.0.0.1])
	by ethel.local.diamand.org with esmtp (Exim 4.69)
	(envelope-from <luke@diamand.org>)
	id 1JipPx-0002jV-0j; Mon, 07 Apr 2008 12:21:41 +0100
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
In-Reply-To: <20080407111740.GA12776@bit.office.eurotux.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - manchester.eukhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - diamand.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78968>

Luciano Rocha wrote:

>> Linux 2.6.22-3-amd64
>> File system is XFS
>> git version 1.5.4.4
> 
> You're using XFS. Did you have a power fail in the recent past?

How did you know?

> 
