From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast
 forwards
Date: Thu, 12 Aug 2010 14:28:33 -0500
Message-ID: <20100812192833.GA2029@burratino>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
 <vpqvd7gp2q6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 12 21:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjdTi-0006hz-Os
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 21:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0HLTaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 15:30:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33409 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab0HLTaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 15:30:08 -0400
Received: by gxk23 with SMTP id 23so561630gxk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oxayIUhxX8bVJGHZ+EMQ8RDZkldZYZAUfBQYWspNEgU=;
        b=GJ68PB/z/o/gvyt5LxU3k4eBLyFo1jr+nEyUlinT/0i38FzvzHa8CexYNhqSEmfSqe
         LBA0oOrGwQTq3Zl57/x74VxpuGixZBS23CfmdPQSUbncwPOuyslW3KIivf/BN+Nn0SnF
         WNK0OfJiFxchGNaD8OzQEBcaHZefVbVvi2lZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YOcn+XsoYSEjBYOzeIyTNV5btU2fAp8jqDUf/afVpi4HVQSH23lC1ZYPq9CuNkKkwf
         M3NdJIClz9fLvZuFdmutUNOOLjWwbJNMT+ljI/ZhQjJgMIEJdis4HOvFEdmnbhCTXgMw
         P13xHbM+sB099x2G9tgZF4n8pfmf+IO7fstlk=
Received: by 10.231.168.21 with SMTP id s21mr404277iby.123.1281641407113;
        Thu, 12 Aug 2010 12:30:07 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id h8sm205554ibk.15.2010.08.12.12.30.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 12:30:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqvd7gp2q6.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153402>

Matthieu Moy wrote:

> I'm sorry to insist, but nothing has happened to this patch, and I'd
> really like it to get merged. The only reaction appart from Junio was
> Jonathan, and althought it contained a disgression about "if I were
> running the world", it started with "Your change is good." ;-).

Indeed.  To be clear, I like your change. ;-)
