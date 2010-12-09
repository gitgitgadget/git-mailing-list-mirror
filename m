From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-send-email: Accept -n as a synonym for --dry-run
Date: Thu, 09 Dec 2010 01:39:02 -0500
Message-ID: <4D007986.60809@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 07:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQaEj-0006BT-Co
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 07:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab0LIGoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 01:44:13 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:60223 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754882Ab0LIGoM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 01:44:12 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2010 01:44:12 EST
X-AuditID: 12074424-b7b0bae000000a05-eb-4d00798fa916
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 06.1D.02565.F89700D4; Thu,  9 Dec 2010 01:39:11 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id oB96dApA023469
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 01:39:11 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oB96d9am015422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 01:39:10 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id C6E1914C012; Thu,  9 Dec 2010 01:39:09 -0500 (EST)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id 9A18514C011
	for <git@vger.kernel.org>; Thu,  9 Dec 2010 01:39:09 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAARbjXuk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163269>

I noticed I forgot to make the corresponding documentation change. I'll
include it in the next version of this patch, though I'm waiting to see
if there's any other feedback first.

-Alejandro
