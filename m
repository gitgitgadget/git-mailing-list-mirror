From: Shameem Ahamed <shameem.ahamed@yahoo.com>
Subject: error while cloning a remote repository
Date: Fri, 13 Nov 2009 12:08:32 +0530 (IST)
Message-ID: <811075.82054.qm@web94704.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 07:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8puL-0004fW-8C
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 07:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbZKMGpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 01:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbZKMGpK
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 01:45:10 -0500
Received: from web94704.mail.in2.yahoo.com ([203.104.17.146]:39151 "HELO
	web94704.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752987AbZKMGpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 01:45:09 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2009 01:45:08 EST
Received: (qmail 82060 invoked by uid 60001); 13 Nov 2009 06:38:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1258094312; bh=CjnRAta/8pjzcu3T3TGA/Ck1NnxBLp1rJpPMDQ0yDJQ=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=sItHd/EnQJdHKZtC1vbx3Fqg3rIe9KDuolVqwtw/70pZXere4jIvY5EUs2kRJD4ZeExYSbuILXCLdm8YJVWrp9LFWSqwpTMVUfXxII1RUDDyjXc9tSk3kYMZGTi7KR3RAO8nmkwLx92AVQuSVL4ca5MXyfwUv2oyr/9wimkvYlo=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=tot2f3wL2LxXNcCVmuWAovxuJ4Il+i/4s/U5ZaipBDyDST+PBbUnf+OAIW8y6jNct7s1/xzEGKy6U0Oc1ec/Y9UBlbUGHqDB09mJp0yzdT1PVWLnF6NFolMwmADkALcHJxjBfbYhCebu9Yg8RMx/UpTG6IIbnEQw4F8fj6EftSE=;
X-YMail-OSG: xbhNj74VM1l5v64ZPZgSenbVLG7OJUDWCRtuj_v_Z2MY3mgoRwMQFCAGwBcmpkp5Sj.aRMK9G6_6aFtxDHd6ZPzsZh74fRaAF80DrYS4mQmkbzJwCzNrrBxiXMu_u0FGtG8hFhayw7xRN68RvuN6YoS71L3be1EvjQDgdfzy5_qs.JdCC1_CwB_W2jC_MGieW5HXYN4uTWvwaKjPrL2PITKMBSpfPLc-
Received: from [122.181.8.86] by web94704.mail.in2.yahoo.com via HTTP; Fri, 13 Nov 2009 12:08:32 IST
X-Mailer: YahooMailRC/211.6 YahooMailWebService/0.7.361.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132817>

Hi,

I ran in to a warning message while cloning a remote repository.

The message is 

warning: remote HEAD refers to nonexistent ref, unable to checkout.

After the cloning i couldn't see any remote files. The .git folder is created successfully.

Regards,
Shameem


      
