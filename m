From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation: fix missing text for rev-parse --verify
Date: Tue, 22 Jul 2014 16:41:39 -0700
Message-ID: <20140722234139.GB10991@google.com>
References: <20140721233554.GC5616@vauxhall.crustytoothpaste.net>
 <1406072291-99812-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9jgr-0002k4-CY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 01:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbaGVXln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 19:41:43 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52663 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaGVXlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 19:41:42 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so456773pdb.27
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FjxC2u29cgY7Px6ixIn553gNIwn6FeDqdhRZdrHCHqQ=;
        b=P4hGlMTWw5U+Ml/rLigN2RwdclLILcrbo/oSnhk6sYUR+waF7Z7WZVMjvtN65Ep87S
         ol8aeVt7Y+j4C2ajbIfG9dqtnr9OBC5QRQRrsf18fYySGVeHbt6kCaWtAMSpwUdmWpbv
         2ewK2cZHPdRwLP7aOKN4lbPP1OXWtX5ltx7np7BMdoAbWHLNVaoPm5gRv+mBZEzYqPPc
         qcgIRTcNdEEV1Py1Zm+oP9I7b7moU87eqTY/BMibKh+lsk48eREbDEWHJG5RD8WfcISx
         +M3uAYZ6JznR8d5HbMXw5qIuxWwE7nbydVMeP8csLjPXzMwDgIox+puLA+z6h7Tk8oYt
         Ie5g==
X-Received: by 10.66.228.37 with SMTP id sf5mr38059198pac.19.1406072502417;
        Tue, 22 Jul 2014 16:41:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d9e8:fc3e:88c8:61c])
        by mx.google.com with ESMTPSA id g7sm525864pdk.87.2014.07.22.16.41.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 16:41:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406072291-99812-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254052>

brian m. carlson wrote:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-rev-parse.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks again for catching and fixing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
