From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/5] gitweb: Remove function prototypes
Date: Sun, 10 May 2009 11:05:38 +0200
Message-ID: <200905101105.40025.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <200905100205.23733.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 11:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M34zG-0000rz-K3
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 11:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbZEJJFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 05:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbZEJJFp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 05:05:45 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49777 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZEJJFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 05:05:44 -0400
Received: by ewy24 with SMTP id 24so2776199ewy.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FeK0lShbFtAbwxFGjsHwtbc+wEHUhANIrhh/BbZLZM0=;
        b=J1UhEEqfU9dYuf2kkwfaiuHIdkiCibxHOFPD4jUBDXok/z0jsCHtCbz3SZ4e3tz5lQ
         0Vq1CfvTPPjVosvixRTlWuPLTL24FH6U3vbraVpcUew/UktCa8WOwUr1WMG8vadT78OL
         HcuLQ9wLkGY4DojvhMWCp0lDRC0CL4EApQcrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=cuchoGD2GLk2jTQGGf8K7SLQhLt5Dr2nGsQXgfagWXKAyrwPslJ8mHBGTdiLXBqA9v
         Ev1dR+EEX1TDZwQ3nA0O488LTW388RebU607r2YBhXz9TYNpRrwm+XBr6Up/UGwYRFp5
         3DyjfV3Q6e//uzvc5qCtsXVQaRI++PA4bKedo=
Received: by 10.210.18.8 with SMTP id 8mr1987028ebr.16.1241946344701;
        Sun, 10 May 2009 02:05:44 -0700 (PDT)
Received: from ?192.168.1.13? (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id 23sm5318769eya.49.2009.05.10.02.05.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 02:05:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100205.23733.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118711>

On Sun, 10 May 2009, Jakub Narebski wrote:

> This patch was send with slightly different commit message as
> standalone patch earlier. This is the replacement patch, which differs
> only in the commit message.

I see that v1 version of patch (send as standalone patch) was already 
accepted.  Just skip this patch then, as it differs only in that it has 
more wordy commit message...

-- 
Jakub Narebski
Poland
