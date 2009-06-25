From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Fri, 26 Jun 2009 01:17:22 +0200
Message-ID: <200906260117.22925.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <200906251455.32953.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:18:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJyDC-0004YI-QD
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 01:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbZFYXRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 19:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757211AbZFYXRU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 19:17:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:32106 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477AbZFYXRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 19:17:19 -0400
Received: by fg-out-1718.google.com with SMTP id e21so383538fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=R62HIBF4OX23ggBpjDo+IuWvtbmcYKX3gmiAvQPyuCM=;
        b=DLVG3VpCBre8+VvjpVuo8L3dXh42o+qtvNSdHNOttwg36nBzjxYS9ZdETeTUUqacw7
         JfFMV/YfGOVQBd63GIg6MtWZXCNj/UbKAX6wGIKfpsBcJc36INtaEEzFeruKxC5UWVlL
         sEjijLrzvrBeI8/kqWICveszavXEj0qphGpSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=m/UEQn6oeUDTTUWtZrNBPUrQPF2ghgHknE/Bbs9UYvwFJemc9JGjK+Yg1sMyq4eyPp
         ZAgXMYnZZSusr1etrfeaoO30uLRj/QWS6xWMLNJ3Qa6Iu3kwGI9l6O01iGpwpNjCCyOo
         Ey6fAoKQ8DCRXQtu3Ncevctd1pCRzaHngi5P4=
Received: by 10.86.25.10 with SMTP id 10mr3093005fgy.79.1245971841004;
        Thu, 25 Jun 2009 16:17:21 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id 4sm6373170fgg.27.2009.06.25.16.17.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 16:17:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906251455.32953.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122260>

On Thu, 25 June 2009 14:55, Jakub Narebski wrote:

> I'll try to post my comments today (i.e. within 24 hours)... but it
> looks good.

I'm sorry, I will post comments for the rest of patches in series 
tomorrow (but I'll try to be within those 24 hours).

-- 
Jakub Narebski
Poland
