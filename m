From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 19:09:10 -0500
Message-ID: <20100727000910.GB3460@burratino>
References: <4C4D152A.7050505@gmail.com>
 <20100726050849.GA16858@burratino>
 <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
 <20100726152356.GA6564@burratino>
 <alpine.DEB.2.00.1007261346060.14251@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julio.lajara@alum.rpi.edu, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 27 02:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdXka-0003eY-5e
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 02:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab0G0AKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 20:10:20 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50135 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab0G0AKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 20:10:19 -0400
Received: by gxk23 with SMTP id 23so1057746gxk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=822w7Dos46vA6xPqFlhqfR2OnRffYPR0wA2HRsURHdc=;
        b=vOuapaARyF/Q6198EUcjTEMPwBv27q+9DfAd2IKV6H0/uk7yGHxiKTUht3WZmWqQP7
         DcKiuTthH+ZU5kvJ1akTpN8UpxDlWx9W6jZQQtDGUaU+X89KvRlQZwgxek+Mp2ru2LNx
         1eK/O7JMkM4IFdkw3t0ICwLXUEa4ptJJ7g5WU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NcFQ0Z4ifKCsNIinUP6L5+bn8x6s6SV7QDCKW6p5sryDKeQRsAWuek2Pb1MtIh+oM1
         MGoi1wcC9EuSYPeXHQnyi7+qyxZNrWszMK7zXfa8JEuQXRoUvCj27edzjVlgQE2DeOOu
         3m8eDHn3wEtVG8TF+3H0y2isPHmmt/gmHeo9Y=
Received: by 10.150.74.11 with SMTP id w11mr4698519yba.164.1280189417633;
        Mon, 26 Jul 2010 17:10:17 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p8sm6361104ybk.15.2010.07.26.17.10.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 17:10:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007261346060.14251@dr-wily.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151905>

Anders Kaseorg wrote:

>   git://andersk.mit.edu/git.git

Thanks!

FWIW (because this does not seem to have been advertised widely)
there's a mailing list to coordinate work on the Debian git packages.

Anyone interested can send mail (with any content) to
<debian-package-git-help@list.smarden.org> for a list of supported
commands or <debian-package-git-subscribe@list.smarden.org> to
subscribe.
