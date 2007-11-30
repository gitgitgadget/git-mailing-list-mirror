From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH (homepage)] Make git homepage (main page) use valid HTML
Date: Fri, 30 Nov 2007 12:42:12 +0100
Message-ID: <2c6b72b30711300342g1f8fffdbt8d300e6a35a7c92f@mail.gmail.com>
References: <200711301159.11290.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4GP-0007pT-Ai
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 12:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXK3LmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 06:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbXK3LmN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 06:42:13 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:17545 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341AbXK3LmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 06:42:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1878901rvb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l8A9aV5KpBbnrWMd2d+u1p4/m2mz/DVLey/O40Tl5no=;
        b=EKiMJFf5Gjs8dRWqm9jVifxsg3mh1dC94z6bXiVpItyr47ZjxvPEWtTTCUAjs4lvdI08TAA103m4DeUp/gk1pIpJn9znmkwZaPIX7u8illpC1bfpFS9Fiou1lhNKlOv1sDTxnwN+jcVb69JUkTvc+AvGawdcWSOGypex6G8l0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SID4svz8KPLwVNVa4agZ66ciOrhITL3EBxjdrAjZhL0oj47RBM7LtuJ9um3IsOIirYrVtu+cNWRhUfOaMz1NkyHt1pCnRr+YD5uxdVYlIp6WUIzb6tqz3zGsbvdiklE4unwIO50mmL5XJuMaLCeilmdEgYxFI0q4A6jH/zxMsuA=
Received: by 10.141.88.3 with SMTP id q3mr3931551rvl.1196422932171;
        Fri, 30 Nov 2007 03:42:12 -0800 (PST)
Received: by 10.141.163.17 with HTTP; Fri, 30 Nov 2007 03:42:12 -0800 (PST)
In-Reply-To: <200711301159.11290.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66631>

On Nov 30, 2007 11:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> I hope that it would make through anti-SPAM filters...

I've applied this and your previous patch that added links to Windows
binaries. Should be mirrored one pasky pushes his update button.

> @@ -233,7 +235,6 @@ You can also use one of many <a
> href="http://www.kernel.org/mirrors/">kernel.org
>  <td>Unstable</td>
>  <td><a
> href="http://packages.debian.org/unstable/devel/git-core">http://packages.debian.org/unstable/devel/git-core</a></td>
>  </tr>
> -</td>
>
>  </table>
>

BTW, the patch contained multiple wrapping problems. Don't know if it is
from your side or my broken use of GMail.

-- 
Jonas Fonseca
