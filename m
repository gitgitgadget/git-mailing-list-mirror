From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: Split description of pretty formats of commit log
Date: Mon, 14 May 2007 09:47:17 +0200
Message-ID: <200705140947.17285.jnareb@gmail.com>
References: <200705140125.45711.jnareb@gmail.com> <7vejlkp440.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 09:42:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnVCg-0004EO-MS
	for gcvg-git@gmane.org; Mon, 14 May 2007 09:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbXENHmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 03:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXENHmm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 03:42:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60243 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbXENHmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 03:42:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1281725uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 00:42:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bIvWrYxCER7wfkmeewzpwypQYtvoEvh5vXTr1GIoqJjbsvfmvGqVtRSf1BXf0XjPxcckyLQrsgvvh4cXJ7jG4lCOluEUmeBTmZBfF/0tAvlN21HVT2dAWFgOlZU+WrvX0oIKJD9rgcd2w4dgGvHBshawe1TxjDgi9klkzeKfwbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ly2P0kXzpYkrnWMFAEbhxVJV45b3tPTupi8lJUj6Du9bAnnf9UwY4L1Ijaam3Oq4HokBHOVVPr1I878eyIY0qakbgjYNOhJMhIEXbTP8YXvrwl60jRx34sjGo87OxrQoBD/U9Vk1mnQ0AN9ECrCJrLJEb8wfZLB/nIrO9d4pugQ=
Received: by 10.82.151.14 with SMTP id y14mr1025575bud.1179128560734;
        Mon, 14 May 2007 00:42:40 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 39sm10743094ugb.2007.05.14.00.42.38;
        Mon, 14 May 2007 00:42:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vejlkp440.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47225>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Split description of pretty formats into list of pretty options
>> (--pretty and --encoding) in new file Documentation/pretty-options.txt
>> and description of formats itself as a separate "PRETTY FORMATS"
>> section in pretty-formats.txt
> 
> Very good -- thanks.

It should be: "section in Documentation/pretty-formats.txt". I updated
one part, but forgot to update another.

Not terribly important...
-- 
Jakub Narebski
Poland
