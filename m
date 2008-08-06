From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Query: GIT bare repro
Date: Wed, 6 Aug 2008 10:29:09 +0200
Message-ID: <46d6db660808060129u754488d3jda27e3873154c533@mail.gmail.com>
References: <7vfxpislpf.fsf@gitster.siamese.dyndns.org>
	 <FCCFB4CDC6E5564B9182F639FC35608701C2C85A14@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pandita, Vikram" <vikram.pandita@ti.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 10:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQePP-0005VQ-N3
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 10:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214AbYHFI3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760166AbYHFI3M
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 04:29:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:12369 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759799AbYHFI3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 04:29:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3035887rvb.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0ZV0MB2NgbFmsCRL0hd4kBEMKm14rflCfZwpQiMN4p4=;
        b=goRy8StNzZsetwxJYMY5vxF1cm9ZlO7nZ/O3WTqrxbbPvh+6rHqSuH+L6vLp0cexbe
         wFQIoeLC+wcwjCrkZqUPdqXW7VTdD0lGTkhiIJM7148H9m2UJzb+I2tuk4dbM4Hw9FIk
         79AkMOgsEFCD9jFF2Txr5IHQj4riqf6AKJ3K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nv6GdDFDmroMang2bGyTcOwaxuIjDIWQZmjzmWgIifSBChePMtxa5erQM9NtWs/h2y
         0un4UKLWq3bytUA/sWcB0Kok4V9arw3D58loPixCTTwwsoYduGssNDLDx+EOOXo4WFhW
         bjm9VmU6MoLK+TMlHFQHvitY9EluMDx4cQXGs=
Received: by 10.114.180.1 with SMTP id c1mr93554waf.85.1218011349340;
        Wed, 06 Aug 2008 01:29:09 -0700 (PDT)
Received: by 10.115.16.11 with HTTP; Wed, 6 Aug 2008 01:29:09 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608701C2C85A14@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91492>

On Wed, Aug 6, 2008 at 9:46 AM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
> Hi GIT users
>
> I want to use GIT for my team for distributed development.
> The team members are working at different sites.
>
> Would appreciate help on following:
>
> 1) Could you point me to some document/example for doing so? This should be very common scenario I assume.

Please read http://book.git-scm.com/3_distributed_workflows.html

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
