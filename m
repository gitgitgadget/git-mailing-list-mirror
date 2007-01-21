From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Mon, 22 Jan 2007 00:36:09 +0100
Message-ID: <200701220036.10127.jnareb@gmail.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <200701220008.49158.jnareb@gmail.com> <Pine.LNX.4.63.0701220012580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 22 00:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8mDk-0001q8-PA
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXAUXf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbXAUXf3
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:35:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:24463 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbXAUXf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:35:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so909773uga
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:35:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GUUpf8PPIjkEcIg2FzlSDT0+BIz+OuK1FeaFYtSpFHH//TqDT5EDHWcfFViBjFcKBJtSapXSKXyDw7Ml+W2jaxinyMxIe+b0Bv3VH9UhPFn1WoAkigeyws9nXX+bTnIQCQDuaegqeXOX6AwWROmECNPuCX5Q44gwn1fAigIiquA=
Received: by 10.66.250.17 with SMTP id x17mr6610219ugh.1169422527293;
        Sun, 21 Jan 2007 15:35:27 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id k1sm5929916ugf.2007.01.21.15.35.26;
        Sun, 21 Jan 2007 15:35:27 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701220012580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37363>

Johannes Schindelin wrote:
> On Mon, 22 Jan 2007, Jakub Narebski wrote:
> 
>> So I'd say:
>> 
>>   - Reflog records local history of where the tip of each branch
>>     was at each moment.
>> 
>> I think both "local" and "tip of branch" are important
>> for understanding reflog.
> 
> 'kay. Probably the simple addition of "local" is enough. Like it.

Or perhaps this would be better:

   - Reflog records the history of where the tip of each branch
     was at each moment in given repository.

Just nitpicking.
-- 
Jakub Narebski
Poland
