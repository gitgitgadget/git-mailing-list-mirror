From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Make revision display configurable
Date: Mon, 3 Nov 2008 19:58:45 +0100
Message-ID: <200811031858.46404.andyparkins@gmail.com>
References: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4hB-0000Pd-3N
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYKCTBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbYKCTBU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:01:20 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:22924 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYKCTBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 14:01:19 -0500
Received: by ey-out-2122.google.com with SMTP id 6so909684eyi.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ilRPLBpXXA9x/27ymManvNQjQeVByEDwJVt9rV23R8M=;
        b=MtKCjHVaDYgwv356oThNnWZ1R1mDhBwkXNXoMFa+Hmwal8WwLVyW7BGgFlnK8fSQwo
         /rB4CtFs1p1NJNezabZF67noFUq/rWg1nJzmSD4iPWJe7U7+5x+snopQCJoyR3e2Sd5g
         tJEzsHdzZRUriE0/r3c/7trhKwRCaY56Ezh/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sMAsrgdEBYEwcOVUOzb/xhb+3r37AZTSIA0UjtyP1njf42JS0UYJOY+cXjJz/8WwZt
         QPbMEWcfk6j6qL7zmnDuI12tkA/Yl9TvR/9GdLbNqXGGxoW9ELWwZmbBlqrpKKN/Uriz
         EfZI2M62y+SkY33ftQM8eCGysOmD2IV3og1qs=
Received: by 10.210.21.6 with SMTP id 6mr551330ebu.18.1225738875667;
        Mon, 03 Nov 2008 11:01:15 -0800 (PST)
Received: from grissom.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id f13sm15091246gvd.4.2008.11.03.11.01.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 11:01:15 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26-1-686; KDE/4.1.2; i686; ; )
In-Reply-To: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99979>

On Sunday 02 November 2008 23:20:59 Pete Harlan wrote:
> Add configuration option hooks.showrev, letting the user override how
> revisions will be shown in the commit email.
>
> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
Acked-By: Andy Parkins <andyparkins@gmail.com>


-- 
Dr Andy Parkins
andyparkins@gmail.com
