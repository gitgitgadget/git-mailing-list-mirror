From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (homepage)] Make git homepage (main page) use valid HTML
Date: Fri, 30 Nov 2007 12:55:56 +0100
Message-ID: <200711301255.57012.jnareb@gmail.com>
References: <200711301159.11290.jnareb@gmail.com> <2c6b72b30711300342g1f8fffdbt8d300e6a35a7c92f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4U5-00059g-Ur
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 12:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761885AbXK3L4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 06:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761774AbXK3L4K
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 06:56:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:11493 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761600AbXK3L4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 06:56:09 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2221543nfb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 03:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=uktzH2xaWjEkhM57dU7HqL41IlI9D1rj+dYLRhthkw8=;
        b=imV62wTmmEdImZ3dRDYwJ2iIy5eWZAiEQGoT2S5Oi/JsU4S/cxXtwkERQtjr14El7fLc+DTQ4JX3Ft+umlWmuUc1hKj8ZXFPk6qcWC89uvutVyo7SHozpKj+CTOvKYOYOjvfhOIssrN812EUgpW9CelTrfA7jmNavhvvPMovcFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pAx0EMUCSrrrSCGCFmE28+Rbemf19ILBWUPl6UTSEYxOGu33mBvU7P1rqvHEV5FONrTNrDkbhQAsH7O+OUeaNGDtONHIePBtm43aaE6uCGfTduy7s2YltFhpEHWgQcB8kthoGDWmCs7FO99WGp7Qg0vepzyh6wiO8krTbKRxuns=
Received: by 10.86.36.11 with SMTP id j11mr7181477fgj.1196423767642;
        Fri, 30 Nov 2007 03:56:07 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id o11sm9182138fkf.2007.11.30.03.56.04
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 03:56:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <2c6b72b30711300342g1f8fffdbt8d300e6a35a7c92f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66633>

Jonas Fonseca wrote:
> 
> I've applied this and your previous patch that added links to Windows
> binaries. Should be mirrored one pasky pushes his update button.
 
> BTW, the patch contained multiple wrapping problems. Don't know if
> it is from your side or my broken use of GMail.

I'm sorry, this was my mistake (forgot to turn off word wrapping when 
sending this patch). But as you have applied it, I don't need to 
resend, do I?

-- 
Jakub Narebski
Poland
