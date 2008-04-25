From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH 5/5] Introduce fast forward option only
Date: Fri, 25 Apr 2008 14:00:51 -0700
Message-ID: <402c10cd0804251400r7d0adfb9jc793fe4172d77c5f@mail.gmail.com>
References: <402c10cd0804232253g3ff8665dk89e2ddcc38353752@mail.gmail.com>
	 <m3lk32p5z9.fsf@localhost.localdomain>
	 <7v7ielpxq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 23:01:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpV39-0002fF-DI
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 23:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbYDYVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 17:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758508AbYDYVAz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 17:00:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:12094 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391AbYDYVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 17:00:55 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5132460fkr.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+ZVlqxtiY6vXr5cxYVmOQPSyQdT0x7REOQU0M+ej/nA=;
        b=w3F7GHxtdKxP3ioj/fLkcLkPWELmtHbkxYhYiV6noUBl2VcRBoZ/LL4QbKuVmcCckDe3OetUPVfHMTVmFVWEno/uFJeXw5yiwPKHJup2cbjKoyEYIxoOsKXfiNm9rkgrOeCoW/rOwh2fpkB9K171/zyehvDeI1fBNn9pipWdGQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=leSds0NLeVn9yFhf8l07MqafgHwaJwFqn9/OYCHyBvjJndrekI+irLBUQSFQwc/EghffAhWl2qc0KwqYrijUrcIXT0llLfEfrZLG2qmVNOtHLV6UzUIZHywxcEu/hZ2MUEJdcyOA5Wzbsb/Y87C6qA/ZEb2XGA3FzHCWPFi5LS8=
Received: by 10.82.155.10 with SMTP id c10mr3181107bue.55.1209157252160;
        Fri, 25 Apr 2008 14:00:52 -0700 (PDT)
Received: by 10.82.156.16 with HTTP; Fri, 25 Apr 2008 14:00:51 -0700 (PDT)
In-Reply-To: <7v7ielpxq5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80347>

It will probably take more than a week before I have time to look into
this as I am out of town this weekend.  I will then rebase the patches
on top of 1.5.5.1, test them, and send them as attachments to one
mail.

-- 
Sverre Hvammen Johansen
