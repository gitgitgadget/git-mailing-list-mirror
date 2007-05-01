From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: This seems somewhat less that ideal
Date: Tue, 01 May 2007 18:32:19 -0400
Message-ID: <4637BFF3.2000804@gmail.com>
References: <4634F508.5020702@gmail.com> <7vmz0p88u0.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 00:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0tX-00074X-6r
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbXEAWcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbXEAWcY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:32:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:56648 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbXEAWcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:32:23 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1954785wxd
        for <git@vger.kernel.org>; Tue, 01 May 2007 15:32:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZKRC8LPKRWaR+DCotSMkN7o5RJx6FbOLjAbfnGadfxwPrJYKWDBnZrMjmI2gkEDLLT4siQHyY8C+oLgR9I2Y8bLqYGm1faIcLT1ip50oGIEMoNJJC97OWs+VDRHjSa/po94uhZs3YawxJUO+l2u8OzOeYplR3clsBkeYyMRMfYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Zmpx7kKujZBF6XfBnPZ4v7uHkCCmkaD5nE0Il8q2SI5aS169rLvL+tae4mK/sxmV084wjvbNzXzcGUWiWL+xH8hhhFZg2AQ/uxQiC3hsbaV2Fqx8rsB+DsIQq7XnHOGrJGAJGUdZLVVfz9aF+G0ddciyJW5/nhcm6hUKecA/PAw=
Received: by 10.70.113.16 with SMTP id l16mr35476wxc.1178058741500;
        Tue, 01 May 2007 15:32:21 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h14sm60759wxd.2007.05.01.15.32.20;
        Tue, 01 May 2007 15:32:20 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vmz0p88u0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45988>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> remote: Generating pack...
>> remote: Done counting 46473 objects.
>> remote: Deltifying 46473 objects.
>> remote:  100% (46473/46473) done
>> Indexing 46473 objects...
>> remote: Total 46473 (delta 32624), reused 46043 (delta 32299)
>>  100% (46473/46473) done
>> Resolving 32624 deltas...
>>  100% (32624/32624) done
> 
> Indeed it seems somewhat less than ideal.  Funny thing is that
> it does not reproduce.

Not hear either, but I'm not able to recreate the precise conditions again.
