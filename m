From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [REPLACEMENT PATCH] git-checkout: Add a test case for relative paths use.
Date: Fri, 9 Nov 2007 00:12:14 +1100
Message-ID: <ee77f5c20711080512h2304d2b1y5d3040e2be375197@mail.gmail.com>
References: <11945006082887-git-send-email-dsymonds@gmail.com>
	 <4732D5A9.5040504@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7BS-0007HA-An
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbXKHNMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbXKHNMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:12:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:19454 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbXKHNMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:12:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so137686rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OSgxd+BL3X6OJPwWEy82GiO15zQQQJAn3MlDNuIgYNs=;
        b=CRzV9NoA3kllmcSUp6opppaEY4n/pr3fwxsnnA7aomLNn/zz73nVyPHDN9ymj6uEwjEUhY5wKInPH5wnlrtMfLQYagHspwlN8Rs0YD4Rk3Gy6FG3AVyelx7q0W0YmdNEqzO8SRgV9uGoL5JF4s5K75fYNuiMRVTniwgMi+hUy2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pidcbNzcltTbxDMnOFTmwDg6jhZDiNoQr6vMW1ZqPQFMEPyPdmrPLYo6EEHxd3uNJpTSVzpFEpPumrQtwpi9WHhDDBgEbDoKUv1NbigOvaqtIriPID1VmeUPcI1tuTRnsDvq+f+ditqofzKHxm5+0KhXX31d5tnZr18TnOAhQnU=
Received: by 10.141.79.12 with SMTP id g12mr231331rvl.1194527534886;
        Thu, 08 Nov 2007 05:12:14 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 05:12:14 -0800 (PST)
In-Reply-To: <4732D5A9.5040504@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64014>

On Nov 8, 2007 8:23 PM, Andreas Ericsson <ae@op5.se> wrote:
>
> Single-dashes on all of these?

Damn. I wonder how it passed? I'll resend shortly.


Dave.
