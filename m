From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/6] Improve error message for git-filter-branch
Date: Thu, 19 Feb 2009 16:13:19 +0100
Message-ID: <bd6139dc0902190713o50593c5emaa6934f9efda0e1e@mail.gmail.com>
References: <200902190736.35364.johnflux@gmail.com>
	 <43d8ce650902190619u149b4619k3f9e08bc1e5869f8@mail.gmail.com>
	 <alpine.DEB.1.00.0902191602520.6223@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 16:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaAc4-0004YU-K3
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 16:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbZBSPNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 10:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZBSPNW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 10:13:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:4227 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbZBSPNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 10:13:21 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1215684fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TfgQTO/gHiWDCeFp9Eti5fmC9hoIpGbgZ5NtdcTYMLY=;
        b=jyVTFAyMvghtt90xmaKZoRkjLSsNpR7q08kTsK9zI9gs8+JEQwj4iLoPBUm0cL9rCB
         eXepmvtb+m+k/yG/zEbAwni4qwD4ZJjbic+qvFs1vK6dOhjChJzjXQKmntjaq4HXVFrK
         gCyxd5hBDido9Ls3z/4Z76DQX7S4B+br2eCi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=vLCNX3eIxTKAW4OIJEWJ89HUBt0rCGoUJUfxci9kkyR39TzSV/HoIwhAyNPgrqnzGb
         qM1dnfRTMojXxe4XULkNQGjRqmCK+doU7nipY/YiXhV2eLo/Oz9MKy00FQ/6J5Ywt7BV
         eOg6VWevVlPO3hyWZYvLP7Q7HilbMyrD8FFSg=
Received: by 10.86.36.11 with SMTP id j11mr367261fgj.65.1235056399940; Thu, 19 
	Feb 2009 07:13:19 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902191602520.6223@intel-tinevez-2-302>
X-Google-Sender-Auth: 0037b232dcc2aec6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110709>

On Thu, Feb 19, 2009 at 16:03, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Might be nice to resend it so that the maintainer has less work, no?

Junio said it was ok to ask him to forge and fixup if desired in the
other thread.

> Also might be nice to cut the complete crap after the only piece of
> information in your mail:

Somehow you failed to do so yourself ;).


-- 
Cheers,

Sverre Rabbelier
