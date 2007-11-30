From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH (homepage)] Make git homepage (main page) use valid HTML
Date: Fri, 30 Nov 2007 13:04:51 +0100
Message-ID: <2c6b72b30711300404k441ff09dl126b61a906273e9f@mail.gmail.com>
References: <200711301159.11290.jnareb@gmail.com>
	 <2c6b72b30711300342g1f8fffdbt8d300e6a35a7c92f@mail.gmail.com>
	 <200711301255.57012.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 13:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4cL-00006r-GR
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbXK3MEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbXK3MEx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:04:53 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:57070 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbXK3MEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 07:04:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1884279rvb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ozm9UNH3ddrBNs/bByEGlc/jOkkMwDDFb1WleqfOnkA=;
        b=QiSJ1PQcuhUCI2+gwj3uFrBYtdmcQtqMqA28uj0MTqb2ufNnihpa8Stz+1wKIw3cv7taietHsSs34HXH769LVj5/mA4uLxMfcWG1U0r+AladlfFAJ3Rm+qtNzi5+ysCFmFOV1T3nT+tamCx5eGjYm4zSXtTj25M3MxWJMpNCdQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jYEf6305SRMdHDXYXJvjM1w3dk3mJc0g7NJur5tX//eCbcydK65TgMpaQTZbGvcjOYBmx0ZqmOmbtEnuvY/DHsFV9LF9bBGuPHW7UWPac2DLdHzmhtpjyJ2OgOQTQr4tqDlUX5HXlONwpXPEjGC+sGxsL09/HtRueG6xZwsgDxU=
Received: by 10.141.20.7 with SMTP id x7mr3936613rvi.1196424291763;
        Fri, 30 Nov 2007 04:04:51 -0800 (PST)
Received: by 10.141.163.17 with HTTP; Fri, 30 Nov 2007 04:04:51 -0800 (PST)
In-Reply-To: <200711301255.57012.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66635>

On Nov 30, 2007 12:55 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Jonas Fonseca wrote:
> > BTW, the patch contained multiple wrapping problems. Don't know if
> > it is from your side or my broken use of GMail.
>
> I'm sorry, this was my mistake (forgot to turn off word wrapping when
> sending this patch). But as you have applied it, I don't need to
> resend, do I?

No.

-- 
Jonas Fonseca
