From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-send-email and aliases
Date: Mon, 26 Mar 2007 11:57:59 +0200
Message-ID: <38b2ab8a0703260257i29d374f9kb63dc18aad0572b8@mail.gmail.com>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	 <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 11:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlxl-00015z-AN
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbXCZJ6B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXCZJ6B
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:58:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:48393 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbXCZJ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:58:00 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1444038wra
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 02:58:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D5CHsxf3XAnrgefFqy9BneGw7lGPZOs9U30pfCpRFnGQEbO/OsM3cHfQCByKKfwzaF1ZnywxCMtRgVkFompgobeuatL4higE1pYRGXXdrzBqAwGjLxygB2Fqs/PCL8HA1LsU18iGHfyZKDNiTvbcYrHtB8DXemc/E6HFzEc9qnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z3S/gtVaHvL0kwWE15nPdJNAcj+rFpAoMiA8eH2KoSwsDhyS2CEic5k38z6oCzoeZ1Mr6ETtCtx8NBQ6TmS1HCO1r8e4trklTHArl1dVNRdPgEeA2uvM76C5tMAQ8NUsEVJD19H9WTKOUPfW1kDYEkUg8DZ9ePNCWpZAeqkFVdA=
Received: by 10.115.93.16 with SMTP id v16mr2573570wal.1174903079358;
        Mon, 26 Mar 2007 02:57:59 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Mon, 26 Mar 2007 02:57:59 -0700 (PDT)
In-Reply-To: <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43141>

On 3/26/07, Junio C Hamano <junkio@cox.net> wrote:
>
> $ sed -ne '/^alias\.\*/,/^$/p' Documentation/config.txt
>

oops sorry. I was so thinking about bash aliases that I didn't take a
look to the documentation.

sorry again.
-- 
Francis
