From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [announce] text-based tree visualizer
Date: Sun, 9 Mar 2008 13:36:21 +0100
Message-ID: <200803091336.21931.jnareb@gmail.com>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr> <m3ablahcl4.fsf@localhost.localdomain> <Pine.LNX.4.64.0803081555080.26142@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 13:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYKlq-0007DS-Tx
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 13:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYCIMgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 08:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYCIMgR
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 08:36:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:23905 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYCIMgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 08:36:16 -0400
Received: by ug-out-1314.google.com with SMTP id z38so4708934ugc.16
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=k/Fk0QJcVipzGPl40fdkunXgAEvqc8EUgFDvf0gZdPU=;
        b=Db+RBHhHv/6q4l74nfRe2horNBCblW3yAI1WWPHZqY2x0vwYvfl8Uf6v5B5kuTstUFvqO1XWDR0rgnFYjnnnXN4j6oT7WCqq2bSrlpSbA92TXufh03Ph9CF/lYL/lT4ivyz0cNQOuCshwSWiyZojIIhRe/aCq8P8qfjycKnWeAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MoIR0F1z8ZPuwJTWUrZFLmmeytzXFbS1qyQLidpgI9l+skrf1Tji8ChsyKEl/Nzl4JHt6xOv4vJsqGza9abUIMH9luUM58Vf8mNUdDHkNmh3j9b300IdUMkVqO3rV8GOXtqZipazvx3FbBY791LlaXlLHWCs7BsiDVTBjRTlOkw=
Received: by 10.66.249.8 with SMTP id w8mr3050818ugh.75.1205066174982;
        Sun, 09 Mar 2008 05:36:14 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.176])
        by mx.google.com with ESMTPS id 39sm7834737ugb.15.2008.03.09.05.36.11
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 05:36:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0803081555080.26142@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76657>

On Sat, 8 Mar 2008, Jan Engelhardt wrote:
> 
> would it be possible to just merge the tiny tool into contrib/
> so the file does not stand alone?

I think it would be posible. Simply send a patch adding it somewhere
in the contrib/ directory.

-- 
Jakub Narebski
Poland
