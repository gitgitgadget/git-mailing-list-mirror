From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [RFH] Multiple repository for mult-module project
Date: Fri, 14 Dec 2007 14:58:25 +0600
Message-ID: <7bfdc29a0712140058te788700h429c08b3e0c6eeff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 09:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J36Nd-00058a-6G
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 09:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbXLNI61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 03:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757910AbXLNI61
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 03:58:27 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:46042 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbXLNI60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 03:58:26 -0500
Received: by an-out-0708.google.com with SMTP id d31so269693and.103
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=cJ0/3I8KnNS0UfghHxi89VCQS5IqrK4/WJ9F8ZzJaiU=;
        b=fc9oh570AJC4TkyJuoNYdnNaSlTWbQ5RNObC+alCuov+SD+7slVNmKjG6+Z8jsF7LIrttQEUI7fYUOaFBSS9EBXrNfVcunUACzEtEmEf2NrBQZlNboDqwhAHPzp3X1vE4jRRAamKRMujvUlEbXLjfhFbSPOhUVNoJ8i368WdkHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gG6NQeCWBxbwjmsfLjOIcngiIueZ9Ca2mSyTaqu/q5WSKX61eX/DEcvJVjjRf0KMJFUFDHvot5MVtAu49N5olZz5WS97D54lZW5IsIHjaz7U6zBEs2UBUVzTurcYTF4IAOJ4Ro/ObGoxpDCXPtRwWMUaWyGDRqcKA+f0Y3UIg9w=
Received: by 10.100.205.9 with SMTP id c9mr6366844ang.62.1197622705384;
        Fri, 14 Dec 2007 00:58:25 -0800 (PST)
Received: by 10.100.10.4 with HTTP; Fri, 14 Dec 2007 00:58:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68268>

Hi,

I have a project that has started recently and has 7 modules and as
days pass by the number of modules will only increase. Currently I am
using SVN and I am so impressed with GIT's concept and Linus's
presentation at Google that I want to use GIT but as the rest of the
team wants to use SVN I guess I will have do it GIT with SVN. I want
to create separate repositories for each modules and then group them
under a master module which I am calling project. In this regard I
would also like to mention that the whole project gets syncd with a
SVN server as mentioned earlier. Can someone please point me to any
article/blog or link where I can learn
on how to do it. If someone would take time to explain the how-to over
email that is also fine by me :).

Thank you & best regards,

-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
