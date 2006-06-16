From: David Kowis <dkowis@shlrm.org>
Subject: Re: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 16:56:12 -0500
Message-ID: <1150494975.DBA8A55@be12.dngr.org>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org> <7v7j3gdc7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 23:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrMIq-0005A1-0p
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWFPV4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWFPV4R
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:56:17 -0400
Received: from mta2.prod1.dngr.net ([216.220.209.221]:60641 "EHLO
	mfe3.prod.danger.com") by vger.kernel.org with ESMTP
	id S1751048AbWFPV4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 17:56:17 -0400
Received: from [10.253.5.251] (HELO localhost.localdomain)
  by mfe3.prod.danger.com (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 706728136; Fri, 16 Jun 2006 14:56:15 -0700
X-Mailer: Danger Service
X-Danger-Send-Id: AAByMESTKP8AAYbV 
In-Reply-To: <7v7j3gdc7t.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21977>


On Fri, 16 Jun 2006 16:55, Junio C Hamano wrote:
> David Kowis <dkowis@shlrm.org> writes:
>
>>  commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
>>  Author: David Kowis <dkowis@kain.org>
>>  Date:   Fri Jun 16 12:20:08 2006 -0500
>>
>>      this is a multi
>>
>>      line comment
>>      with three lines
>>
>>
>>  I'm using git 1.4.0. It added a blank line in there...
>
> Actually, this is an odd but intended behaviour ;-).

Why is this behaviour intended? Just because I'm curoius. :)
-- David Kowis - mobile
