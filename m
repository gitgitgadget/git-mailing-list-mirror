From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH] Teach format-patch to handle output directory relative
 to cwd
Date: Tue, 13 Jan 2009 07:24:58 -0200
Message-ID: <496C5DEA.4020305@cesarb.net>
References: <496BBE70.9060405@cesarb.net> <7vab9wgmwe.fsf@gitster.siamese.dyndns.org> <496BCE55.8030407@cesarb.net> <7vmydwf2a9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 10:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMfXu-0007RE-H0
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 10:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZAMJZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbZAMJZK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 04:25:10 -0500
Received: from smtp-04.mandic.com.br ([200.225.81.151]:40605 "EHLO
	smtp-04.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZAMJZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 04:25:08 -0500
Received: (qmail 13710 invoked from network); 13 Jan 2009 09:24:59 -0000
Received: from grumari.nitnet.com.br (HELO [192.168.96.4]) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-04.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 13 Jan 2009 09:24:59 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vmydwf2a9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105479>

Junio C Hamano escreveu:
> Cesar Eduardo Barros <cesarb@cesarb.net> writes:
> 
>> Works great, only the resulting output to the screen is a bit
>> ugly/confusing:
>>
>> drivers/net/../../../0001-sc92031-more-useful-banner-in-kernel-log.patch
>> ...
>> (after all, I am still inside the drivers/net directory)
> 
> Fair enough.  Here is a replacement diff.

Works fine, thanks.

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
