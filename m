From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] configure.ac: Add --with-gcc-warnings configure option
Date: Tue, 06 Mar 2012 17:12:57 +0100
Message-ID: <4F563789.9080807@gmail.com>
References: <1331044385-14796-1-git-send-email-gitter.spiros@gmail.com>	<4F56329E.9050506@gmail.com> <CA+EOSBm6autG8MCe1fWC+8V=Kx6FkAuVdS-SLKUzkmxz-x-qiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 17:13:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4x0f-00005a-IW
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 17:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2CFQND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 11:13:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51460 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2CFQNC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 11:13:02 -0500
Received: by bkcik5 with SMTP id ik5so4349990bkc.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 08:13:00 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.9.214 as permitted sender) client-ip=10.204.9.214;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.9.214 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.204.9.214])
        by 10.204.9.214 with SMTP id m22mr13660374bkm.111.1331050380736 (num_hops = 1);
        Tue, 06 Mar 2012 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GLc9cVtkYEHLCtiP7JPxQDkVOn05xQXiwc8R1pJn1KY=;
        b=T34KzM9YVxmDmZRSWSW1hg5Llt9KerLEZtLCuTewtuZ0gK+LsvErCv6PNd02lpgNvn
         cQAJ5xWgtt7vAK0NGTfjcKHjxJOPpvgtzcTGBYtEsccDbaJZljm3kXt8Zy5EpGMqwEjL
         2oWFWydzgxmM2RG7axvirQOnAKnPlJh19wOy3FoGfUI4Arh3Mgh5rYygmhACXBmdN26E
         oEG7E+OTQpQEt9fReZOwaAiWGaz20C+BhET+UYQD1xWzMlnzStuASZ9qs+1TP6UZZxaj
         JqIYqQZS/X2qkKnlSKEHT3fOxi0QCzraQHoF2PCikEXoz0l83NRY6l3+wq27HtWTinr5
         TOSw==
Received: by 10.204.9.214 with SMTP id m22mr10663449bkm.111.1331050380624;
        Tue, 06 Mar 2012 08:13:00 -0800 (PST)
Received: from [79.7.94.193] (host193-94-dynamic.7-79-r.retail.telecomitalia.it. [79.7.94.193])
        by mx.google.com with ESMTPS id jr13sm28648303bkb.14.2012.03.06.08.12.58
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 08:12:59 -0800 (PST)
In-Reply-To: <CA+EOSBm6autG8MCe1fWC+8V=Kx6FkAuVdS-SLKUzkmxz-x-qiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192363>

On 03/06/2012 05:08 PM, Elia Pinto wrote:
>
> No problem to reroll with your suggestions.
> 
> Thanks a lot
> 
Before doing so, consider that the git developers might disagree with
me, and their opinion certainly holds more weight than mine ...  You
might want to hear what they think before re-rolling, to save yourself
some potentially useless work.

Best regards,
  Stefano
