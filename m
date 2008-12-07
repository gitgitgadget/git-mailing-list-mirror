From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make project specific override for 'grep' feature work
Date: Sun, 7 Dec 2008 12:16:30 +0100
Message-ID: <200812071216.31850.jnareb@gmail.com>
References: <20081207052230.GD4357@ftbfs.org> <20081207093447.25785.41811.stgit@localhost.localdomain> <7vljuscl4v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 12:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9HeN-0001oE-7W
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 12:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYLGLQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 06:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbYLGLQw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 06:16:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:30674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbYLGLQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 06:16:51 -0500
Received: by ug-out-1314.google.com with SMTP id 39so383217ugf.37
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=orPs1IoPzTw8G9nFq5iCqKvoEneLWxasXBMsekG9BZ4=;
        b=WSN+WSMP6qGk3oV/M0tXVFOAqr1+qsiJgst7DcnPio46RBvygzmiQfCUXXl8QHei6j
         uWh3CQFm5qWYR3JvvyRBAkQdw4yH/4BH789VUiaqDjTOidjMC5nI37D0UdTbRHC+DMhQ
         D4m85ybeTXpnWIX5EDL0hb/pLtSryKADmLjDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LZu7MCvthZusiyBr0+K9spSh32DGdCZAAzUx993oFSFftnXQf48xjRay6zQPXyhlcC
         Q0PPr3SjnPg5DLdhz0cY7InzNhb1KjyYdEebVefKuoy+hk/LDKDBZl34+UYBHRKrF2Oo
         hHwa8noZ603cKAjE/Z7zQ1XEzeYzfqnPUsbj4=
Received: by 10.67.28.14 with SMTP id f14mr1318753ugj.79.1228648609133;
        Sun, 07 Dec 2008 03:16:49 -0800 (PST)
Received: from ?192.168.1.11? (abvv225.neoplus.adsl.tpnet.pl [83.8.219.225])
        by mx.google.com with ESMTPS id g30sm4297799ugd.32.2008.12.07.03.16.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 03:16:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vljuscl4v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102496>

On Sun, 7 Dec 2008, Junio C Hamano wrote:

> Thanks, both.  This should go to maint, right?
> 

Yes, I think so.
-- 
Jakub Narebski
Poland
