From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: *** SPAM ***[ANNOUNCE] GIT 1.6.3.rc0
Date: Mon, 13 Apr 2009 05:57:59 +0200
Message-ID: <20090413035759.GB26332@vidovic>
References: <7v7i1pxo5v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 05:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtDKi-0005qp-4f
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 05:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbZDMD6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 23:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbZDMD6H
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 23:58:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55919 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbZDMD6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 23:58:06 -0400
Received: by fxm2 with SMTP id 2so1847850fxm.37
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=W9Wo6M10zWaGSlNwTws4Sb3E35dgp5dtyQUU9rZb3NI=;
        b=MxMmnzmbVHY9Kmmy//sNp0g7w9IVNV6eILTjeyiVzrdAUYcgKqW+9BWKDZ1KkB8YKE
         BzcoOS45G+FuSITgmvU/FzG5NKFtyen5aLwJt8CSkbPq6pLMrMSJ/Rn4eWfARTAvmMdX
         Mi2Kmq0sNhTcglZXgYpWwo1RpgM/teYkWJP58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IjejouGhYEJm631DA3v78DuxWRtcs2ThMvchiTuqjv0kgGOJyFMgODv1+u0+vJJTHp
         bv2qPvA8KNVZ62pgxgDScoZah6cPL4mugfon3ZVicEBl0dNDCDn/sJqe5/9J6bzqyaiR
         eQ7sQcTamazfx2hVrLnNngnd9+AoqpWi4BAPQ=
Received: by 10.103.160.9 with SMTP id m9mr3099394muo.96.1239595083681;
        Sun, 12 Apr 2009 20:58:03 -0700 (PDT)
Received: from @ (88-121-114-181.rev.libertysurf.net [88.121.114.181])
        by mx.google.com with ESMTPS id i5sm8928297mue.13.2009.04.12.20.58.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Apr 2009 20:58:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7i1pxo5v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116410>

On Sun, Apr 12, 2009 at 07:50:20PM -0700, Junio C Hamano wrote:
> 
> A release candidate GIT 1.6.3.rc0 is available at the usual places
> for testing:

Minor issue: git-bisect--helper is missing in .gitignore.

-- 
Nicolas Sebrecht
