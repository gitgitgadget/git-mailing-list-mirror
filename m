From: Jason Timrod <jtimrod@yahoo.com>
Subject: "git branch" to list whether it's tracking remote branch?
Date: Tue, 14 Jun 2011 03:23:38 -0700 (PDT)
Message-ID: <934599.4947.qm@web121018.mail.ne1.yahoo.com>
Reply-To: Jason Timrod <jtimrod@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:29:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQsc-0004ZG-W8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 12:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab1FNK3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 06:29:41 -0400
Received: from nm25-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.42]:41835 "HELO
	nm25-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752605Ab1FNK3k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 06:29:40 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2011 06:29:40 EDT
Received: from [98.138.90.49] by nm25.bullet.mail.ne1.yahoo.com with NNFMP; 14 Jun 2011 10:23:58 -0000
Received: from [98.138.89.172] by tm2.bullet.mail.ne1.yahoo.com with NNFMP; 14 Jun 2011 10:23:58 -0000
Received: from [127.0.0.1] by omp1028.mail.ne1.yahoo.com with NNFMP; 14 Jun 2011 10:23:39 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 119943.14788.bm@omp1028.mail.ne1.yahoo.com
Received: (qmail 37487 invoked by uid 60001); 14 Jun 2011 10:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1308047018; bh=3LibgtV2rHIMTahoXR9Xdp+/qhxU6EBn8hCip3GnABk=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=DfLKyirZC5QdX1Vgch1ZleVIgLgEPDazdvd2+GTWaojDF6hSl/SvcFWBhDICQNCoAVhJml23md77c9sV1BEUCV2EqQyQunpNfmjUBRZaIT3FVTGHKBXdoKcPcCB3z59nPj8hWsdCekPd2Dxfpo/Tzb44uZBQqwrzs31SAhjO5jk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=QIJns7170CfNjBSyzoItbsKSKmjJkrYuYrt1W5K5hY7V1D4poPmhkN1WnyZ1Pf+IvY5oUiBvs8fBlR+G2YX5UU9hEw1RtnUfF8Hv993wQsqfgEzPfkad97IYin4DkRFDdWxVrNS7e/1llawRADa77iAWwEMQwF6ubL9IiFU9WOI=;
X-YMail-OSG: HN9Op_oVM1lRCx0DPCgVHB91UA8NQS24ih01pL_nWILjxzf
 Xzm58wYAUPfn_dwstEbLZ1n.foFnX6EEdIlN0Xl0xDcdJAyY7ajdu4XQOmCb
 btTmMO2WOQ6qWLIqcA1EW3VIKhMUK9tf98lB0iMLXxCY9SuOA_YYAs0HH_.M
 FIxGTTt2q4HTbOfjFF1fln0GLNzKTrqxZHoy5ZNSBzxtXnFs27wdqYVlWHiP
 QPDpKsIb_sqEfw6DpiIJCq9aXgijN3vitwgbX9ucB5_SHhINT3N7Y8L6wznp
 P.gE6JVqA5qSQ_ZCTfFBak9Hs4RZ0b_l_eRTAAhY8muDDV2sSXo0-
Received: from [82.69.211.6] by web121018.mail.ne1.yahoo.com via HTTP; Tue, 14 Jun 2011 03:23:38 PDT
X-Mailer: YahooMailWebService/0.8.111.304355
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175759>

Hi,

please cc me as i am not subscribed to this list.

is there a command in git that will tell me if a given topic branch in a repository is setup to track a remote branch?

i think it would be useful so i can see which branches are pointing where when i try and then do a "git push"

TIA!

Jason
