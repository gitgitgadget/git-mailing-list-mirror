From: Luben Tuikov <ltuikov@yahoo.com>
Subject: git-revert in branch next
Date: Mon, 9 Oct 2006 18:05:12 -0700 (PDT)
Message-ID: <20061010010512.33201.qmail@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 10 03:06:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX63g-0006Zs-Ik
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWJJBFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 21:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWJJBFP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 21:05:15 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:59763 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751293AbWJJBFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 21:05:14 -0400
Received: (qmail 33203 invoked by uid 60001); 10 Oct 2006 01:05:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=N5rbWoaK60uapYIgNlle+J+8Z3326tvi4e/FRcstITsJq8BEFNfTzk9aehOVi37ttVGYXFa/df0iZqPB64DszLtXTpcR5YbFPc/xiTg0cjoL+9frKvhzy66h3VYI9OHfUvSqMlHecQz6EqU0gWZCy4xxV0kqFHHzFUyI/1zjK6Q=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 18:05:12 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28590>

Has anyone successfully used "git-revert" from branch next, lately?
It seems to print USAGE no matter what arguments are given to it.

    Luben
