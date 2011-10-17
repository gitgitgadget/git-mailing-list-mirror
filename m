From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] Git-p4: Add "git p4 change" command.
Date: Mon, 17 Oct 2011 15:20:34 -0700 (PDT)
Message-ID: <682349072.26755.1318890034730.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <1318889798-17334-1-git-send-email-andreiw@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andrei Warkentin <andreiw@vmware.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:20:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvXz-0005ZS-P4
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054Ab1JQWUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:20:35 -0400
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:25825 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab1JQWUf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 18:20:35 -0400
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 133E03C003;
	Mon, 17 Oct 2011 15:20:35 -0700 (PDT)
Received: from zimbra-prod-mta-3.vmware.com (zimbra-prod-mta-3.vmware.com [10.113.160.227])
	by mailhost3.vmware.com (Postfix) with ESMTP id 08417CDA95;
	Mon, 17 Oct 2011 15:20:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id F1B26F9C0E;
	Mon, 17 Oct 2011 15:20:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from zimbra-prod-mta-3.vmware.com ([127.0.0.1])
	by localhost (zimbra-prod-mta-3.vmware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldIV99DiqwHC; Mon, 17 Oct 2011 15:20:34 -0700 (PDT)
Received: from zimbra-prod-mbox-2.vmware.com (zimbra-prod-mbox-2.vmware.com [10.113.160.202])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id D9364F9C02;
	Mon, 17 Oct 2011 15:20:34 -0700 (PDT)
In-Reply-To: <1318889798-17334-1-git-send-email-andreiw@vmware.com>
X-Originating-IP: [10.113.61.163]
X-Mailer: Zimbra 7.1.1_GA_3225 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3225)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183833>

----- Original Message -----
> From: "Andrei Warkentin" <andreiw@vmware.com>
> To: git@vger.kernel.org, gitster@pobox.com
> Cc: "Andrei Warkentin" <andreiw@vmware.com>
> Sent: Monday, October 17, 2011 6:16:38 PM
> Subject: [PATCH] Git-p4: Add "git p4 change" command.
> 
> Many users of p4/sd use changelists for review, regression
> tests and batch builds.
> 
> "p4 change" is almost equivalent to "p4 submit", yet will
> just create the changelist and not submit it.
> 
> Signed-off-by: Andrei Warkentin <andreiw@vmware.com>
> ---

Sorry for the spam, this is the wrong patch :-(.

A
