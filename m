From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: What exactly does 'needs update' mean?
Date: Sat, 25 Sep 2010 08:16:07 -0600
Message-ID: <4C9E0427.9080901@workspacewhiz.com>
References: <4C9D8643.1040001@workspacewhiz.com> <7vk4manyql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 16:17:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzVYv-0005ip-Mu
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 16:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab0IYOQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 10:16:10 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33134 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab0IYOQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 10:16:09 -0400
Received: (qmail 792 invoked by uid 399); 25 Sep 2010 08:16:08 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 25 Sep 2010 08:16:08 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vk4manyql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157155>

  ----- Original Message -----
From: Junio C Hamano
Date: 9/25/2010 12:06 AM
> Joshua Jensen<jjensen@workspacewhiz.com>  writes:
>>   I've come to accept the term 'needs update' when I've forgotten to
>> stash or commit before certain Git operations.  However, I got
>> cornered today and was asked to explain what it means.  I had to admit
>> I don't know.
> It came from "you need to run update-index on that path, as you have local
> modification in the working tree".
Okay, your description makes sense to me, and I'll be able to explain 
what it means.

I did a Google search before I posted here.  It turns out this phrase is 
*very* confusing to others.  Casual Joes don't use the plumbing commands 
(which I assume git update-index is).  Is there opposition to 
modernizing this turn to make it more clear based on the porcelain 
commands being run?

Thanks.

Josh
