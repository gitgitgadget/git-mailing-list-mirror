From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Wed, 18 Feb 2009 00:51:14 +0100
Message-ID: <bd6139dc0902171551u58365c0ao1e6b603b2efc603a@mail.gmail.com>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
	 <bd6139dc0902170929g7215427clcf40348c01dfd10e@mail.gmail.com>
	 <alpine.DEB.1.00.0902180049110.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZk5-0006Hr-AK
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbZBQXvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZBQXvR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:51:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:1744 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZBQXvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:51:16 -0500
Received: by fg-out-1718.google.com with SMTP id 16so586534fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=FON9Xng0Qew46ukvfQcIU7JSZ7Qv7sBOb4X0iggyFK4=;
        b=Hyn/cXla72u/YYlR02l6ElgjYhWd8+np6h/fFxYzXsODxz9t0HkDjwUNA+WzihTddr
         wDBezWWDMP967V0qYOKzTgEC0wgnf3Epl52KTm+Wi69pRkzou4W1Ywi4lsEW2azVV19h
         nsXHdS7DHM1UPZ2KToYZgI0Q7NIj2Z8ba4I3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Xs/ggH3imJYgfMmljk1ibMu6oV7NeMGVWIHKqtidCqd7ucSsW+di/3YWiy+hbESrZH
         +W9za3b+BG4fji4dxtLRl5R5SBMlIathiM5iy0CpO+xJZsVj9JU0XVp93I/QLKxe5aKV
         CfIhtebpT1VqKKarrH7xyjVr9inxPixtCYCZA=
Received: by 10.86.74.4 with SMTP id w4mr905020fga.22.1234914674428; Tue, 17 
	Feb 2009 15:51:14 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902180049110.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 9bb58f0b87b0aab4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110482>

On Wed, Feb 18, 2009 at 00:49, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Heh, do you actually use it?

Yup, at times when I need to work with an svn repository but cannot be
bothered to rev up git-svn for it :).

-- 
Cheers,

Sverre Rabbelier
