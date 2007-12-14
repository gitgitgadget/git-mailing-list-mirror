From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Creating multiple modules under a project
Date: Fri, 14 Dec 2007 12:03:01 +0600
Message-ID: <7bfdc29a0712132203m165c74e8m9170c74bba641858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 07:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33dw-0005fI-Pw
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbXLNGDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 01:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXLNGDF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:03:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:8845 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbXLNGDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:03:02 -0500
Received: by nf-out-0910.google.com with SMTP id g13so809760nfb.21
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=VSasqYZDu9hU1MhLkH2T/3eYOsLsJpAQS/1cNlJ0u4g=;
        b=wO4oBzwtWNZASy6YynLJWPdt7jWJWwZyqU44bFL10Xx/cws3T5aZ2olklRdrKX0qCR+jL4/0ok7y78TzPsY6Dl4RF1Lded/Dcxngtjhl6nYmDgnqUIe+u983/ytmkFooUDSK7X71d6sJov/uawCAxq/5/WKKmkxMe3A7MPjYEsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E2SJFGELy+jYjZVOvoUde+dJpw/F6PcHpasxIwTlByooim4HqJPgPLVr26hwwDwdsof2iq1h3OZ0GOvnwyYV/9zsr5YBh3S3WdODxFntLEEgR5YGlvED2aFoHOQnIPTGjWRUl9YU6OSvjJF01lWAhOyTO+dCzbxMKtvOk0K3LsI=
Received: by 10.78.190.10 with SMTP id n10mr3498441huf.37.1197612181188;
        Thu, 13 Dec 2007 22:03:01 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Thu, 13 Dec 2007 22:03:01 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68230>

Hi,

I have a project that has just started and has 7 modules and as days
pass by the number of modules will only increase. Currently I am using
SVN and I am so impressed with GIT's concept and Linus's presentation
at Google that I want to use GIT with SVN. I want to create separate
repositories for each modules and then group them under a master
module which I am calling project. In this regard I would also like to
mention that the whole project gets syncd with a SVN server. Can
someone please point me to any article/blog or link where I can learn
on how to do it. If someone would take time to explain the how-to over
email that is also fine.

Thank you & best regards,

-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
