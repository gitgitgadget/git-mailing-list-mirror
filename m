From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Tue, 19 Jan 2010 11:39:35 -0600
Message-ID: <20100119173934.GA6007@progeny.tock>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
 <7vfx6efox9.fsf@alter.siamese.dyndns.org>
 <7vpr58w6qn.fsf@alter.siamese.dyndns.org>
 <201001191829.19284.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:39:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXI3K-0005qS-4x
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 18:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab0ASRjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890Ab0ASRje
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 12:39:34 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56535 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0ASRjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 12:39:33 -0500
Received: by yxe17 with SMTP id 17so5208248yxe.33
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RtiCAxaNN+GardzKKQb4GP7YO3wvSd7vlopGAZeQrNU=;
        b=Bmt4P8xUlYYhN45eAtCqDj0ssahVU0PN3l36MBvQZiBhnhRiATbuspcedCrpCFOQ27
         bAYLTBbsj3H98SZDrVjQRnAwnW+KUP8gDg+GKsjK78LH4/M0u6CXeEuCBINMjqSMIPuZ
         A6t0viGsdBKErTjg2EZWdmqjnn2PeTdySJKpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VPsVF3ouYqZ2irhWQZKuvlVTZJG1j7u7F56FE0iY9bztIOmp4EN5jLxeVXoUd0lkr9
         2f30TsnGdmWjwEHcs8XHSI+Ln4ZbkQkoWCsm1sgecqE3VheMXAkuNpSduTKVQlj/TIyB
         jUbETxqEJ39SVEhi6RROSsj2tmdM3IbTP/EjY=
Received: by 10.91.19.17 with SMTP id w17mr3841212agi.54.1263922771583;
        Tue, 19 Jan 2010 09:39:31 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm2674434ywf.40.2010.01.19.09.39.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 09:39:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001191829.19284.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137477>

Thomas Rast wrote:

> Jonathan, do you plan on rerolling your 6-patch series with Pasky's
> and my comments?

Yes, I was planning to get to it today; sorry for the lack of noise.

Jonathan
