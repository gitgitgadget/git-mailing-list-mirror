From: "Chiyuan Zhang" <pluskid@gmail.com>
Subject: [GSoC2008]What's wrong with last years Gittorrent?
Date: Mon, 24 Mar 2008 09:14:36 +0800
Message-ID: <b6f0e9dd0803231814r72aef8aenf6d35bae77b84181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 02:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdbHS-0003ih-VB
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbYCXBOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYCXBOh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:14:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:20044 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbYCXBOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:14:36 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2756498wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dGFUY417OITDI1HjNSUzruBXAOAMUN9fW2ATCqWewCY=;
        b=VUD6HscasgMgxMA5XV5Zbms2YeJWvlnPmErjPW85GDPfMBcdSvsgqCtmSU/lvKq0VNkOavtGGfa0tQzpojThPKxjY3JFsXhqXMsX/DyOoNjuVwaHftU2jwjz6GhtUW9kiZ6/oNjwlgLSP4+315WDVjxyPqpodXwak21gUGDVr+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k7hCmdU+jbE1lO9mPvGW+LrBnM8q5Ec+fBr1oyftpJ/r5BlkCAQmfEb51uEyVBnecFqgbH1V5YZh5734x48ys/X481Ii+f63nOuKwaLmXq8Z65ACwQ1iZC+fs8M+JDHcn7UfRs6g1YwqsCL9i983XmftyOZncGwcThzXeEyPjVY=
Received: by 10.142.88.20 with SMTP id l20mr4040641wfb.72.1206321276234;
        Sun, 23 Mar 2008 18:14:36 -0700 (PDT)
Received: by 10.142.154.9 with HTTP; Sun, 23 Mar 2008 18:14:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77984>

Hi,

I'm planning to apply Google Summer of Code this year. I noticed
on the git project page there's a gittorrent implementation. I'm
interested in this. But later I found there was also a similar
project (accepted) in last year's SoC: GitTorrent Server and Peer,
written in Python. Unfortunately, the two links on that page aren't
available any more. So I'm wondering what's the status of last
year's GitTorrent? Is there something wrong with that? If any, what
caused the problem and what's the differences between this year's
and that one?

Looking forward for your reply. Thanks!
